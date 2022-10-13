# frozen_string_literal: true

module Hix
  module Lib
    module Data
      module DB
        DB = {
          sqlite: {}.freeze,
          mysql: { port: 3306 }.freeze,
          postgres: { port: 5432 }.freeze,
        }.freeze
      end
    end
  end
end
