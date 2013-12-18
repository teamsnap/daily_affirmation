# DailyAffirmation

A simple library for external validations of POROs

![Daily Affirmation](http://i.imgur.com/rdvgFAK.jpg)

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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
