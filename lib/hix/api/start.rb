# frozen_string_literal: true

module Hix
  module API
    class Start < Hix::API::Base
      def request(id:)
        HTTParty.post(
          "#{url}/projects/#{id}/start",
          headers: auth_headers,
        )
      end
    end
  end
end
