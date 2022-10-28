# frozen_string_literal: true

require_relative "lib/hix/version"

Gem::Specification.new do |s|
  s.name = "hix"
  s.version = Hix::Version::STRING
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = ">= 2.7.0"
  s.authors = ["Wiktor Plaga"]
  s.description = <<-DESCRIPTION
    Gem hix is an API client of hix.dev website and a file rendering tool used
    by hix.dev to spin-up new programming projects.
    It aims to standardize projects creation and maintenance.
  DESCRIPTION

  s.email = "hix.dev@tzif.io"
  s.files = Dir.glob("{assets,lib}/**/*", File::FNM_DOTMATCH) + %w[VERSION]
  s.bindir = "exe"
  s.executables = ["hix"]
  s.homepage = "https://hix.dev"
  s.licenses = ["GPL-3.0"]
  s.summary = "The hix.dev ruby API client and a progamming files rendering tool"

  s.metadata = {
    "homepage_uri" => "https://hix.dev",
    "changelog_uri" => "https://github.com/hixdevs/hix/blob/prd/CHANGELOG.md",
    "source_code_uri" => "https://github.com/hixdevs/hix/",
    "documentation_uri" => "https://github.com/hixdevs/hix/blob/prd/README.md",
    "bug_tracker_uri" => "https://github.com/hixdevs/hix/issues",
    "rubygems_mfa_required" => "true",
  }

  s.add_runtime_dependency("activesupport", "~> 7.0")
  s.add_runtime_dependency("fileutils", "~> 1.6")
  s.add_runtime_dependency("httparty", "~> 0.20")
  s.add_runtime_dependency("json", "~> 2.6")
  s.add_runtime_dependency("open-uri", "~> 0.2")
  s.add_runtime_dependency("pry", "~> 0.14")
  s.add_runtime_dependency("rubyzip", "~> 2.3")
  s.add_runtime_dependency("thor", "~> 1.2")
  s.add_runtime_dependency("tty-prompt", "~> 0.23")
  s.add_runtime_dependency("yaml", "~> 0.2")

  s.add_development_dependency("fasterer", "~> 0.10")
  s.add_development_dependency("rspec", "~> 3.11")
  s.add_development_dependency("rspec-expectations", "~> 3.12")
  s.add_development_dependency("rubocop", "~> 1.36")
  s.add_development_dependency("rubocop-performance", "~> 1.15")
  s.add_development_dependency("rubocop-rspec", "~> 2.13")
  s.add_development_dependency("simplecov", "~> 0.21")
end
