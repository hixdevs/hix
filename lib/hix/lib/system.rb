# frozen_string_literal: true

module Hix
  module Lib
    module System
      def sh(cmd)
        `#{cmd}`
      end

      def log(label, message, color = :blue)
        thor.say_status(label, message, color)
      end

      def thor
        @thor ||= Thor::Shell::Color.new
      end
    end
  end
end
