# frozen_string_literal: true

module Hix
  module Exe
    class Base
      def initialize(*_args)
        @log = Thor::Shell::Color.new
      end

      private

      attr_reader :log

      def credentials
        return unless File.exist?(Hix::Exe::CREDENTIALS_PATH)

        JSON.parse(YAML.load(File.read(Hix::Exe::CREDENTIALS_PATH)).to_json, symbolize_names: true)
      end

      def auth_token
        credentials&.[](:auth)&.[](:token)
      end

      def refresh_token
        credentials&.[](:refresh)&.[](:token)
      end

      def tokens
        {
          auth_token: auth_token,
          refresh_token: refresh_token,
        }
      end
    end
  end
end
