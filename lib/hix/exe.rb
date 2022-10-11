# frozen_string_literal: true

require_relative "../hix"

module Hix
  module Exe
    LOGIN = "login"
    START = "start"
    VERSION = "version"
  end
end

log = Thor::Shell::Color.new

case ARGV.first
when Hix::Exe::LOGIN
  log.say_status(:ok, "Loging in", :green)
when Hix::Exe::START
  log.say_status(:ok, "Starting new project", :green)
when Hix::Exe::VERSION
  puts Hix::Version::STRING
else
  log.say_status(:error, "command does not exist", :red)
end
