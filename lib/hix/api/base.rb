# frozen_string_literal: true

module Hix
  module API
    class Base
      def initialize(auth_token: nil, refresh_token: nil)
        @auth_token = auth_token
        @refresh_token = refresh_token
      end

      def url
        Hix::CONFIG[:api]
      end

      def headers
        { "Content-Type" => "application/json" }
      end

      def auth_headers
        raise ArgumentError, "Unauthorized" if auth_token.nil? && refresh_token.nil?

        refresh_auth_token!
        raise ArgumentError, "Refresh failure" if auth_token.nil?

        headers.merge("Authorization" => "Bearer #{auth_token}")
      end

      private

      attr_accessor :auth_token, :refresh_token

      def refresh_auth_token!
        @auth_token = HTTParty.get(
          "#{url}/refresh-token",
          headers: {
            "Cookie" => "rt=#{refresh_token}",
          },
        )&.[]("data")&.[]("token")
      end
    end
  end
end
