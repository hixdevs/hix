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

module Hix; end
