# frozen_string_literal: true

require "active_support/all"
require "fileutils"
require "httparty"
require "json"
require "open-uri"
require "pry"
require "thor/shell"
require "tty-prompt"
require "yaml"
require "zip"

require_relative "hix/api"
require_relative "hix/lib"
require_relative "hix/version"

module Hix
  CONFIG = if File.exist?("#{ENV['HOME']}/.hixdev/config")
             YAML.load(File.read("#{ENV['HOME']}/.hixdev/config")).with_indifferent_access
           else
             {
               api: "https://api.hix.dev/api/v1",
             }
           end
end
