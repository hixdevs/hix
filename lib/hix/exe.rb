# frozen_string_literal: true

require_relative "../hix"
require_relative "exe/base"
require_relative "exe/login"
require_relative "exe/new"

module Hix
  module Exe
    BUILD_PATH = "#{ENV['HOME']}/.hixdev/build"
    CACHE_PATH = "#{ENV['HOME']}/.hixdev/cache"
    CREDENTIALS_PATH = "#{ENV['HOME']}/.hixdev/credentials"
    LOGIN = "login"
    NEW = "new"
    VERSION = "version"
  end
end

FileUtils.mkdir_p("#{ENV['HOME']}/.hixdev/cache")
FileUtils.mkdir_p("#{ENV['HOME']}/.hixdev/build")

case ARGV[0]
when Hix::Exe::LOGIN
  Hix::Exe::Login.new(email: ARGV[1].chomp, password: ARGV[2].chomp).call
when Hix::Exe::NEW
  Hix::Exe::New.new(uuid: ARGV[1].chomp).call
when Hix::Exe::VERSION
  puts Hix::Version::STRING
else
  log.say_status(:error, "command does not exist", :red)
end
