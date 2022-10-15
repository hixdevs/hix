# frozen_string_literal: true

module Hix
  module API
    class Reset < Hix::API::Base
      def request(id:)
        HTTParty.post(
          "#{url}/projects/#{id}/reset",
          headers: auth_headers,
        )
      end
    end
  end
end
