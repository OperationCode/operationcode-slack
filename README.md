# [Operationcode::Slack](https://github.com/OperationCode/operationcode-slack)

[![Build Status](https://travis-ci.org/OperationCode/operationcode-slack.svg?branch=master)](https://travis-ci.org/OperationCode/operationcode-slack)
[![Code Climate](https://codeclimate.com/github/OperationCode/operationcode-slack/badges/gpa.svg)](https://codeclimate.com/github/OperationCode/operationcode-slack)
[![Test Coverage](https://codeclimate.com/github/OperationCode/operationcode-slack/badges/coverage.svg)](https://codeclimate.com/github/OperationCode/operationcode-slack/coverage)

This gem provides a common interface to slack for the Operation Code platform.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'operationcode-slack', git: 'https://github.com/OperationCode/operationcode-slack'
```

And then execute:

    $ bundle

## Usage

* Require the gem in your application like so:
```ruby
require 'operationcode/slack'
```

You can now call the slack API like so

```ruby
Operationcode::Slack::Api::ChannelInvite.post(with_data: { channel_id: '1234', user: 'ID1234' })
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

To add a new API endpoint simply add a new class in ```lib/operationcode/slack/api.rb```. The name of the class determines its URL.
For example - the users info endpoint URL is https://slack.com/api/users.invite. The class name should be ```UsersInvite```

If you need more advanced funcationality please define your class in ```lib/operationcode/slack/api/```. See ```OauthAccess.rb``` for an example.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/OperationCode/operationcode-slack. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


