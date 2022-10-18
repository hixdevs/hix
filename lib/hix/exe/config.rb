# frozen_string_literal: true

module Hix
  module Exe
    class Config < Hix::Exe::Base
      def initialize(env: nil)
        out("Configuring hix", :begin)
        @env = (Hix::ENVS.key?(env) && env) || TTY::Prompt.new.select("Env:") do |menu|
          menu.default("prd")
          menu.choice("prd")
          menu.choice("stg")
          menu.choice("dev")
          menu.choice("u00")
          menu.choice("u01")
          menu.choice("u02")
          menu.choice("local")
        end
        return unless @env == "local"

        @port = TTY::Prompt.new.ask("API port:", default: 3000) do |answer|
          answer.modify(:remove)
          answer.in("1-65535")
          answer.messages[:range?] = "%{value}s out of allowed port range %{in}s"
        end
      end

      def write
        File.write(Hix::CONFIG_PATH, config.to_yaml)
        out("Activated: #{env}", :done)
      end

      private

      attr_reader :env, :port

      def config
        api = Hix::ENVS[env]
        api = "#{api}:#{port}" if env == "local"
        api = "#{api}/api/v1"

        {
          "env" => env,
          "api" => api,
          # "dsn" => Hix::DSNS[env],
        }
      end

      def api
        api = Hix::ENVS[env]
        api = "#{api}:#{port}" if env == "local"
        "#{api}/api/v1"
      end
    end
  end
end
