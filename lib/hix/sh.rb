# frozen_string_literal: true

module Hix
  module Sh
    def sh(cmd)
      Kernel.`(cmd)&.chomp
    end

    def out(message, label = :status, color = :green)
      thor.say_status(label, message, color)
    end

    def err(message, label = :error, color = :red)
      thor.say_status(label, message, color)
    end

    def thor
      @thor ||= Thor::Shell::Color.new
    end
  end
end