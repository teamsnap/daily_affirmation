# DailyAffirmation

[![Codeship Status for teamsnap/daily_affirmation](https://www.codeship.io/projects/70727b30-de01-0131-af05-5236ebb52643/status)](https://www.codeship.io/projects/24759)

[![Gem Version](https://badge.fury.io/rb/daily_affirmation.png)](http://badge.fury.io/rb/daily_affirmation)
[![Code Climate](https://codeclimate.com/github/teamsnap/daily_affirmation.png)](https://codeclimate.com/github/teamsnap/daily_affirmation)
[![Coverage Status](https://coveralls.io/repos/teamsnap/daily_affirmation/badge.png?branch=master)](https://coveralls.io/r/teamsnap/daily_affirmation?branch=master)
[![Dependency Status](https://gemnasium.com/teamsnap/daily_affirmation.png)](https://gemnasium.com/teamsnap/daily_affirmation)
[![License](http://img.shields.io/license/MIT.png?color=green)](http://opensource.org/licenses/MIT)

[Documentation](http://www.rubydoc.info/gems/daily_affirmation)

A simple library for external validations of POROs

![Daily Affirmation](http://i.imgur.com/rdvgFAK.jpg)

There are currently two ways to validate objects in Rails, ActiveRecord based validates and ActiveModel based validations. Both require them to be placed directly into your models, making for more heavy weight, less flexible code. DailyAffirmation allows you to validate your models (or any PORO) externally.

By validating objects externally, you can have different validations depending on your code path. Perhaps you require a password for a User object when it's being created, but do not need it again when it's being updated. Simply create a UserCreationAffirmation and a UserChangeAffirmation with the correct validations.

## Installation

Add this line to your application's Gemfile:

    gem 'daily_affirmation'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install daily_affirmation

## Usage

```ruby
require "daily_affirmations"

class Team
  attr_accessor :name, :status_cd
end

class TeamAffirmation
  include DailyAffirmation.affirmations

  affirms_presence_of :name
  affirms_inclusion_of :status_cd, :list => 0..2
end

team1 = OpenStruct.new(:name => "", :status_cd => 3)
TeamAffirmation.new(team1).valid? #=> false
```

## Contributing

1. Fork it ( http://github.com/teamsnap/daily_affirmation/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
