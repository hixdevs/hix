# frozen_string_literal: true

Dir[__FILE__.sub(/\.rb$/, "/data/*.rb").to_s].sort.each { |rb| require rb }
Dir[__FILE__.sub(/\.rb$/, "/**/*.rb").to_s].sort.each { |rb| require rb }

module Hix
  module Lib; end
end
