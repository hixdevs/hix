# frozen_string_literal: true

require_relative "../hix"
require_relative "exe/base"
require_relative "exe/config"
require_relative "exe/login"
require_relative "exe/new"

module Hix
  module Exe
    CONFIG = "config"
    LOGIN = "login"
    NEW = "new"
    VERSION = "version"
  end
end

FileUtils.mkdir_p("#{ENV['HOME']}/.hixdev/cache")
FileUtils.mkdir_p("#{ENV['HOME']}/.hixdev/build")

case ARGV[0]
when Hix::Exe::CONFIG
  Hix::Exe::Config.new(env: ARGV[1]&.chomp).write
when Hix::Exe::LOGIN
  Hix::Exe::Login.new(email: ARGV[1]&.chomp, password: ARGV[2]&.chomp).call
when Hix::Exe::NEW
  Hix::Exe::New.new(uuid: ARGV[1]&.chomp).call
when Hix::Exe::VERSION
  puts Hix::Version::STRING
else
  log.say_status(:error, "command does not exist", :red)
end
