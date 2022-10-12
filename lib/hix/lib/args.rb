# frozen_string_literal: true

module Hix
  module Lib
    class Args
      # include ::Hix::Lib::DefaultsDB
      # include ::Hix::Lib::DefaultsSMTP

      attr_reader :app_name, :engines, :products

      def initialize(options)
        @app_name = options["name"]
        @engines = OpenStruct.new(options["engines"])
        @products = options["products"]
      end

      def app_dir
        @app_dir ||= app_name.underscore.downcase
      end

      def get(path)
        products.dig(*path.split("."))
      end

      def ctg?(abbr)
        products[abbr].is_a?(Hash)
      end

      def is?(path)
        get(path).present?
      end
    end
  end
end
