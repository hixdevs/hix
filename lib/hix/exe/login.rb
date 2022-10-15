# frozen_string_literal: true

module Hix
  module Exe
    class Login < Hix::Exe::Base
      def initialize(email: nil, password: nil)
        @email = email || TTY::Prompt.new.ask("Email:")
        @password = password || TTY::Prompt.new.mask("Password:")
        super
      end

      def call
        log.say_status(:ok, "Loging in", :green)
        File.write(Hix::CREDENTIALS_PATH, credentials.to_yaml)
        log.say_status(:ok, "Saved: #{Hix::CREDENTIALS_PATH}", :green)
      end

      private

      attr_reader :email, :password

      def credentials
        {
          "email" => email,
          "auth" => {
            "token" => response["data"]["token"],
          },
          "refresh" => {
            "token" => response.headers["x-refresh-token"],
            "expire" => response.headers["x-refresh-expire"],
          },
        }
      end

      def response
        @response ||= Hix::API::SignIn.new.request(email: email, password: password)
      end
    end
  end
end
