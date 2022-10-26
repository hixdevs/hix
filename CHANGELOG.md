# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.5.0] - 2022-10-26
### Added
- "hix deploy" command
### Updated
- cleanup to not run on localhost

## [0.4.0] - 2022-10-21
### Added
- kernel system method
### Updated
- printer's output to diff file create and update

## [0.3.1] - 2022-10-20
### Updated
- backtick system call to Kernel.backtick

## [0.3.0] - 2022-10-18
### Added
- error system logs
### Updated
- system command log to out
- high-level require to parse directories instead of requiring line by line
- exe/hix to call a class instead of execute the inline code
### Fixed
- requiring system calls module

## [0.2.0] - 2022-10-18
### Added
- module with system calls and stdout logs

## [0.1.3] - 2022-10-15
### Fixed
- reading version and —development installation

## [0.1.2] - 2022-10-15
### Fixed
- CircleCI RubyGems access

## [0.1.1] - 2022-10-15
### Fixed
- RubyGems release to happen on prd branch merge

## [0.1.0] - 2022-10-15
### Added
- CircleCI config
- bin/release script
- gem documentation
- sentry configuration
- "hix config {env}" command
- template file-printing class
- gem configuration override
- gems "hix new {uuid}" command
- gems "hix version" command
- gem configuration
- gems "hix" executable
- gemspec and development config
- initial files
