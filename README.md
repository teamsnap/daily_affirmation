# DailyAffirmation

[![Semaphore](https://semaphoreapp.com/api/v1/projects/7268def52c792e50bfc60e1b1a6e905ed4e2a80d/118940/shields_badge.png)](https://semaphoreapp.com/minter/daily_affirmation)
[![Code Climate](https://codeclimate.com/github/teamsnap/daily_affirmation.png)](https://codeclimate.com/github/teamsnap/daily_affirmation)

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
    
## Roadmap

- Provide all the validations ActiveModel does
- Add a way to build custom validations (example validating a password)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
