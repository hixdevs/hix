# frozen_string_literal: true

module Hix
  module Exe
    class Init
      include Hix::Sh

      def initialize(argv)
        @cmd, *@argv = argv
      end

      def run
        mkdirs
        return err("command does not exist") unless respond_to?(cmd, true)

        __send__(cmd)
      end

      private

      attr_reader :cmd, :argv

      def mkdirs
        FileUtils.mkdir_p("#{Dir.home}/.hixdev/cache")
        FileUtils.mkdir_p("#{Dir.home}/.hixdev/build")
      end

      def config
        Hix::Exe::Config.new(env: argv[0]&.chomp).write
      end

      def deploy
        Hix::Exe::Deploy.new(template: argv[0]&.chomp, version: argv[1]&.chomp).call
      end

      def login
        Hix::Exe::Login.new(email: argv[0]&.chomp, password: argv[1]&.chomp).call
      end

      def new
        Hix::Exe::New.new(uuid: argv[0]&.chomp).call
      end

      def version
        puts Hix::Version::STRING
      end
    end
  end
end
