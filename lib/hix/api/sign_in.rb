# frozen_string_literal: true

module Hix
  module API
    class SignIn < Hix::API::Base
      def request(email:, password:)
        HTTParty.post(
          "#{url}/sign-in",
          headers: headers,
          body: {
            email: email,
            password: password,
          }.to_json,
        )
      end
    end
  end
end
