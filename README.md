# Gem `hix` of [hix.dev](https://hix.dev)

[![Gem Version][gem-version-img]][gem-version]
[![Build Status][build-status-img]][build-status]

The `hix` gem is intended to be used by [hix.dev](https://hix.dev) users for
spinning up new programming projects.

## Installation

1. Update to the latest Ruby 3.1.2, using any of the Ruby version managers.
2. Run `gem install hix:1.0.0`.
3. Confirm installation by running `hix version`.

## CLI

The main functionality of this gem is its exposed command-line interface that's
purpose is to communicate with [hix.dev](https://hix.dev) API in order to
setup projects that were generated via website's UI.

### Command `hix login {email} {password}`

Persists authentication credentials locally for the API communication. Passing
`email` and `password` is optional - if ommited, you will be prompted for them.

### Command `hix new {uuid}`

Setups a project generated via [hix.dev](https://hix.dev) website. To use it:

1. Run `hix login`.
2. Complete a project's generation on [hix.dev](https://hix.dev).
3. In CLI, navigate to the directory where you want the project to reside.
4. Grab project's `uuid`, and enter the `hix new {uuid}`.

When `uuid` is ommited, you'll be prompted to provide it.

### Command `hix config {env}`

**Note:** This command is for hix maintainers only. Requirements:

1. Connect to the `tzif` VPN.
2. Run `hix config {env}`.

When `env` is ommited, you'll be prompted to provide it. From now on, your `hix`
commands will communicate with the selected environment's API.

[gem-version]: https://rubygems.org/gems/hix
[gem-version-img]: https://badge.fury.io/rb/hix.svg
[build-status]: https://circleci.com/gh/hixdevs/hix/tree/prd
[build-status-img]: https://circleci.com/gh/hixdevs/hix/tree/prd.svg?style=shield
