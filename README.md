# Trailblazer::Generator

Generate trailblazer files, this is just a prototype, soon will be a WIP, check back soon ;)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'trailblazer-generator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install trailblazer-generator

## Usage

It includes a binary called `trailblazer`

run trailblazer and check usage

```bash
○ trailblazer
Commands:
  trailblazer generate COMMANDS  # Generates trailblazer file
  trailblazer help [COMMAND]     # Describe available commands or one specific command
```

## Examples

Generating some operations:

```shell
trailblazer generate operation BlogPost --actions index,create
```

Generating some cells:

```shell
trailblazer generate cell BlogPost --actions index,edit
```

As bonus, we get some views:
* index.erb
* item.erb (to be used as a item render on index collection)
* edit.erb


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/trailblazer/trailblazer-generator.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
