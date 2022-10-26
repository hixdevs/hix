# frozen_string_literal: true

module Hix
  module Exe
    class Login < Hix::Exe::Base
      def initialize(email: nil, password: nil)
        @email = email || TTY::Prompt.new.ask("Email:")
        @password = password || TTY::Prompt.new.mask("Password:")
      end

      def call
        out("Loging in", :begin)
        File.write(Hix::CREDENTIALS_PATH, credentials.to_yaml)
        out("Saved: #{Hix::CREDENTIALS_PATH}", :done)
      rescue StandardError => e
        err("#{e.class}: #{e.message}")
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
        return @response if defined?(@response)

        @response = Hix::API::SignIn.new.request(email: email, password: password)
        return @response if @response.code == 200
        raise("HTTP #{@response.code}") if @response["errors"].nil?

        raise(@response["errors"].map { |msg| "#{msg['status']} \"#{msg['field']}\": #{msg['detail']}" }.join(". "))
      end
    end
  end
end
