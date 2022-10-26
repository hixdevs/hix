# frozen_string_literal: true

module Hix
  module API
    class Bump < Hix::API::Base
      def request(template:, body:)
        HTTParty.post(
          "#{url}/templates/#{template}/bump",
          headers: auth_headers,
          body: body.to_json,
        )
      end
    end
  end
end
