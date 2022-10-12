# frozen_string_literal: true

module Hix
  module Exe
    class New < Hix::Exe::Base
      def initialize(uuid: nil)
        @uuid = uuid || TTY::Prompt.new.ask("Project UUID:")
        super
      end

      def call
        log.say_status(:ok, "New project: #{uuid}", :green)
        login if credentials.nil?
        return reset(start_errors) if start.code != 200

        begin
          persist_options
          cache_template_files
          require_template_files
          run_template
          finish_project
        rescue StandardError => e
          failure(e)
        ensure
          cleanup
        end
      end

      private

      attr_reader :uuid

      def login
        Hix::Exe::Login.new.call
      end

      def reset(message)
        Hix::API::Reset.new(**tokens).request(id: uuid)
        log.say_status(:error, message, :red)
      end

      def persist_options
        File.write("#{Hix::Exe::BUILD_PATH}/#{uuid}.yml", start["data"].to_yaml)
      end

      def cache_template_files
        return if Dir.exist?(cache_version)

        FileUtils.mkdir_p(cache_version)
        zip_url = "#{Hix::API::Base.new.url}/templates/#{template}/filename?#{zip_querystring}"
        zip_path = "#{cache_version}.zip"
        IO.copy_stream(URI.open(zip_url), zip_path)
        Zip::File.open(zip_path) { |zip| zip.each { |file| zip.extract(file, "#{cache_template}/#{file.name}") } }
        FileUtils.rm_rf(zip_path)
      end

      def zip_querystring
        "filename=#{version}.zip&project=#{uuid}&auth=#{auth_token}"
      end

      def cache_template
        "#{Hix::Exe::CACHE_PATH}/#{template}"
      end

      def cache_version
        "#{cache_template}/#{version}"
      end

      def require_template_files
        Dir["#{cache_version}/**/*.rb"].reject { |file| file.include?("/templates/") }.each { |file| require file }
      end

      def run_template
        Hix::New.new(
          args: Hix::Lib::Args.new(start["data"]),
          root: cache_version,
        ).run
      end

      def finish_project
        Hix::API::Finish.new(**tokens).request(id: uuid)
      end

      def failure(error)
        reset("#{error.class}: #{error.message}")
        return if version == "0.0.0"

        # Sentry.init do |config|
        #   # TODO: return dsn from API?
        #   config.dsn = ENV["SENTRY_DSN"]
        #   config.traces_sample_rate = 1.0
        # end
        # Sentry.capture_exception(e)
      end

      def cleanup
        FileUtils.rm_rf(cache_version) if version != "0.0.0"
      end

      def start
        @start ||= Hix::API::Start.new(**tokens).request(id: uuid)
      end

      def template
        start["data"]["template"]
      end

      def version
        start["data"]["version"]
      end

      def start_errors
        start["errors"].pluck("detail").join(".")
      end
    end
  end
end
