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

require_relative "hix/version"

module Hix; end
