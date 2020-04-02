# RackEsLogger

Rack::Es::Logger is a middleware gem to save logs using Elastic Search.

## Goals

- [ ] Intercept requests to generate response attributes.
- [ ] Save response attributes in Elasticsearch.
- [ ] Support process asyncronous.
- [ ] Filter path by regular expression, Example: 'api/*', 'api/v1'.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack_es_logger'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rack_es_logger

## Usage

Generate initialize configuration:

```ruby
rails generate rack_es_logger:initialize
creating initializer...
      create  config/initializers/rack_es_logger.rb
```

Include middleware in `config/application.rb` or `config/environments/<environment>rb`:

`config.middleware.use RackEsLogger`

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Beetrack/rack_es_logger.

