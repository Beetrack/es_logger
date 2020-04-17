# EsLogger

![](https://github.com/Beetrack/es-logger/workflows/.github/workflows/continouos_integration.yml/badge.svg?branch=master)
EsLogger is a gem to save custom PORO object in Elasticsearch.

## Goals

- [x] Middleware to intercept and save request in Elasticsearch.
- [x] Generate initialize configuration.
- [x] Include pattern to accept the requests, Example: `^api\/external\/\w+` -> `api/external/<some word>`
- [x] Process asyncronous with Sidekiq.
- [ ] Generate new configuration to save custom objects.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'es_logger'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install es_logger

## Usage

Generate initialize configuration:

```ruby
rails generate es_logger:initialize

create config/initializers/es_logger.rb
```

Include middleware in `config/application.rb` or `config/environments/<environment>rb`:

`config.middleware.use EsLogger::Rack`

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Beetrack/es_logger.

