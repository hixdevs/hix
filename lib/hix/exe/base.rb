# frozen_string_literal: true

module Hix
  module Exe
    class Base
      include Hix::Sh

      private

      attr_reader :log

      def credentials
        return unless File.exist?(Hix::CREDENTIALS_PATH)

        # rubocop:disable Security/YAMLLoad
        JSON.parse(YAML.load(File.read(Hix::CREDENTIALS_PATH)).to_json, symbolize_names: true)
        # rubocop:enable Security/YAMLLoad
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
