# frozen_string_literal: true

module Hix
  module Exe
    class Config < Hix::Exe::Base
      def initialize(env: nil)
        @env = Hix::ENVS[env] || TTY::Prompt.new.select("Env:") do |menu|
          menu.default("prd")
          menu.choice("prd", Hix::ENVS["prd"])
          menu.choice("stg", Hix::ENVS["stg"])
          menu.choice("dev", Hix::ENVS["dev"])
          menu.choice("u00", Hix::ENVS["u00"])
          menu.choice("u01", Hix::ENVS["u01"])
          menu.choice("u02", Hix::ENVS["u02"])
          menu.choice("local", Hix::ENVS["local"])
        end
        if @env == Hix::ENVS["local"]
          port = TTY::Prompt.new.ask("API port:", default: 3000) do |answer|
            answer.modify(:remove)
            answer.in("1-65535")
            answer.messages[:range?] = "%{value} out of allowed port range %{in}"
          end
          @env = "#{@env}:#{port}"
        end
        @env = "#{@env}/api/v1"
        super
      end

      def write
        File.write(Hix::CONFIG_PATH, config.to_yaml)
        log.say_status(:done, "Activated: #{env}", :green)
      end

      private

      attr_reader :env

      def config
        { "api" => env }
      end
    end
  end
end
