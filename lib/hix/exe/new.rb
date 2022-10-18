# frozen_string_literal: true

module Hix
  module Exe
    class New < Hix::Exe::Base
      def initialize(uuid: nil)
        @uuid = uuid || TTY::Prompt.new.ask("Project UUID:")
        super
      end

      def call
        log(:begin, "Started: hix new #{uuid}")
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
        log(:error, message, :red)
      end

      def persist_options
        File.write("#{Hix::BUILD_PATH}/#{uuid}.yml", start["data"].to_yaml)
      end

      def cache_template_files
        return if Dir.exist?(version_cache_path)

        FileUtils.mkdir_p(version_cache_path)
        zip_url = "#{Hix::API::Base.new.url}/templates/#{template}/filename?#{zip_querystring}"
        zip_path = "#{version_cache_path}.zip"
        IO.copy_stream(URI.open(zip_url), zip_path)
        Zip::File.open(zip_path) { |zip| zip.each { |file| zip.extract(file, "#{template_cache_path}/#{file.name}") } }
        FileUtils.rm_rf(zip_path)
      end

      def zip_querystring
        "filename=#{version}.zip&project=#{uuid}&auth=#{auth_token}"
      end

      def template_cache_path
        "#{Hix::CACHE_PATH}/#{template}"
      end

      def version_cache_path
        "#{template_cache_path}/#{version}"
      end

      def require_template_files
        Dir["#{version_cache_path}/**/*.rb"].reject { |file| file.include?("/templates/") }.each { |file| require file }
      end

      def run_template
        Hix::New.new(
          args: Hix::Lib::Args.new(start["data"]),
          root: version_cache_path,
        ).run
      end

      def finish_project
        Hix::API::Finish.new(**tokens).request(id: uuid)
        log(:done, "Completed: hix new #{uuid}")
      end

      def failure(error)
        reset("#{error.class}: #{error.message}")
        # TODO: use DSN defined in template files
        # return if Hix::CONFIG[:dsn].nil?

        # Sentry.init do |config|
        #   config.dsn = Hix::CONFIG[:dsn]
        #   config.environment = Hix::CONFIG[:env]
        #   config.release = Hix::Version::STRING
        #   config.traces_sample_rate = 1.0
        # end
        # Sentry.capture_exception(e)
      end

      def cleanup
        FileUtils.rm_rf(version_cache_path)
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
