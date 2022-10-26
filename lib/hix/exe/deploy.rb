# frozen_string_literal: true

module Hix
  module Exe
    class Deploy < Hix::Exe::Base
      def initialize(template: nil, version: nil)
        @template = template || TTY::Prompt.new.ask("Template slug:")
        @version = version || TTY::Prompt.new.ask("Version:")
      end

      def call
        out("Started: hix deploy #{template}:#{version}", :begin)
        begin
          login if credentials.nil?
          verify_template_path
          write_zip_archive
          bump_template
          cleanup
        rescue StandardError => e
          err("#{e.class}: #{e.message}")
        end
      end

      private

      attr_reader :version, :template

      def login
        Hix::Exe::Login.new.call
      end

      def verify_template_path
        raise("Not a hix template path") unless File.directory?("hix")
      end

      def write_zip_archive
        FileUtils.rm_rf(zip_path)
        FileUtils.cp_r("hix", tmp_path)
        Zip::File.open(zip_path, Zip::File::CREATE) do |archive|
          Dir.glob("#{tmp_path}/**/*", File::FNM_DOTMATCH)
            .select { |path| File.file?(path) }
            .each { |path| archive.add(path, path) }
        end
        FileUtils.rm_rf(tmp_path)
      end

      def zip_path
        "#{version}.zip"
      end

      def tmp_path
        version
      end

      def integrations_path
        "bumps/#{version}.yml"
      end

      def bump_template
        response = Hix::API::Bump.new(**tokens).request(template: template, body: bump_body)
        return out("Deployed to #{bold(Hix::CONFIG['env'])}", :success) if response.code == 200

        raise(response["errors"].map { |msg| "#{msg['status']} \"#{msg['field']}\": #{msg['detail']}" }.join(". "))
      end

      def bump_body
        body = {
          version: version,
          zip: "data:@file/zip;base64,#{Base64.strict_encode64(File.read(zip_path))}",
        }
        body[:integrations] = integrations if File.file?(integrations_path)
        out("Deploying without integrations", :warn, :orange) unless File.file?(integrations_path)
        body
      end

      def integrations
        YAML.load_file(integrations_path)["integrations"]
      end

      def cleanup
        FileUtils.rm_rf(zip_path)
        FileUtils.rm_rf(tmp_path)
      end
    end
  end
end
