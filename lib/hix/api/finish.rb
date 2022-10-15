# frozen_string_literal: true

module Hix
  module API
    class Finish < Hix::API::Base
      def request(id:)
        HTTParty.post(
          "#{url}/projects/#{id}/finish",
          headers: auth_headers,
        )
      end
    end
  end
end
