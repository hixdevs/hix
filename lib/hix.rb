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

CONFIG_PATH = "#{ENV['HOME']}/.hixdev/config"

module Hix
  BUILD_PATH = "#{ENV['HOME']}/.hixdev/build"
  CONFIG_PATH = "#{ENV['HOME']}/.hixdev/config"
  CACHE_PATH = "#{ENV['HOME']}/.hixdev/cache"
  CREDENTIALS_PATH = "#{ENV['HOME']}/.hixdev/credentials"
  ENVS = {
    "prd" => "https://api.hix.dev",
    "dev" => "https://api.dev.hix.dev",
    "stg" => "https://api.stg.hix.dev",
    "u00" => "https://api.u00.hix.dev",
    "u01" => "https://api.u01.hix.dev",
    "u02" => "https://api.u02.hix.dev",
    "local" => "http://localhost",
  }.freeze
  CONFIG = if File.exist?(CONFIG_PATH)
             YAML.load(File.read(CONFIG_PATH)).with_indifferent_access
           else
             {
               api: "https://api.hix.dev/api/v1",
             }
           end
end
