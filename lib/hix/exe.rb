# frozen_string_literal: true

Dir[__FILE__.sub(/\.rb$/, "/**/*.rb").to_s].sort.each { |rb| require rb }

module Hix
  module Exe
    CONFIG = "config"
    DEPLOY = "deploy"
    LOGIN = "login"
    NEW = "new"
    VERSION = "version"
  end
end
