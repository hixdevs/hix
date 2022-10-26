# frozen_string_literal: true

module Hix
  module Lib
    class Printer
      include Hix::Sh

      EXTENSION = ".erb"

      def initialize(root:, path:, args: {})
        @path = "#{args.app_dir}/#{path}"
        @args = args
        @template = ERB.new(File.read(File.join(root, "templates", "#{path}#{EXTENSION}")), trim_mode: "-")
      end

      def render
        create_subdirectories
        delete_file
        out(path.sub("#{args.app_dir}/", ""), tag, color)
        File.write(extended_path, content)
      end

      private

      attr_reader :path, :template, :args

      def overwrite?
        return @overwrite if defined?(@overwrite)

        @overwrite = File.exist?(path)
      end

      def tag
        overwrite? ? :update : :create
      end

      def color
        overwrite? ? :blue : :green
      end

      def content
        template.result_with_hash(args: args)
      end

      def create_subdirectories
        return unless !subdirectories.empty? && !File.exist?(subdirectories)

        out("#{subdirectories}/", :create, :green)
        FileUtils.mkdir_p(subdirectories)
      end

      def subdirectories
        return @subdirectories if defined?(@subdirectories)

        @subdirectories = path.split("/")[0..-2].join("/")
      end

      def delete_file
        File.delete(path) if overwrite?
      end

      def extended_path
        path
      end
    end
  end
end
