# frozen_string_literal: true

module Hix
  class Version
    STRING = File.read(__dir__.sub(%r{lib/hix$}, "VERSION"))
  end
end
