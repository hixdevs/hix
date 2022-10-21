# frozen_string_literal: true

module Hix
  module Sh
    def out(message, label = :status, color = :green)
      thor.say_status(label, message, color)
    end

    def err(message, label = :error, color = :red)
      thor.say_status(label, message, color)
    end

    def thor
      @thor ||= Thor::Shell::Color.new
    end

    def sys(cmd)
      Kernel.system(cmd)
    end

    def sh(cmd)
      Kernel.`(cmd)&.chomp
    end
  end
end
