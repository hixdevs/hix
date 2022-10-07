# frozen_string_literal: true

require "fileutils"
require "httparty"
require "json"
require "open-uri"
require "pry"
require "thor/shell"
require "tty-prompt"
require "yaml"
require "zip"

require_relative "hix/config"
require_relative "hix/version"

module Hix
  class << self
    def config
      @config ||= Config.new
    end

    def configure
      yield(config)
    end
  end
end
