require_relative "../spec_helper"
require_relative "../../lib/daily_affirmation/validators/date_validator"

require "date"

unless defined?(DailyAffirmation::OptionError)
  DailyAffirmation::OptionError = Class.new(StandardError)
end

describe "DateValidator" do
  subject { DailyAffirmation::Validators::DateValidator }

  context ":as is unset" do
    it "passes validation if the attribute is a valid date" do
      obj1 = double(:created_at => Date.today)
      obj2 = double(:created_at => Date.today.to_s)

      validator1 = subject.new(obj1, :created_at)
      validator2 = subject.new(obj2, :created_at)
      expect(validator1).to be_valid
      expect(validator2).to be_valid
    end

    it "fails validation if the attribute is an invalid date" do
      obj = double(:created_at => "Invalid Date")

      validator = subject.new(obj, :created_at)
      expect(validator).to_not be_valid
    end

    it "has the correct error message" do
      obj = double(:created_at => "Invalid Date")

      validator = subject.new(obj, :created_at)
      expect(validator.error_message).to eq(
        "created_at is not a valid date"
      )
    end
  end

  context ":as is :date" do
    it "passes validation if the attribute is a valid date" do
      obj1 = double(:created_at => Date.today)
      obj2 = double(:created_at => Date.today.to_s)

      validator1 = subject.new(obj1, :created_at, :as => :date)
      validator2 = subject.new(obj2, :created_at, :as => :date)
      expect(validator1).to be_valid
      expect(validator2).to be_valid
    end

    it "fails validation if the attribute is an invalid date" do
      obj = double(:created_at => "Invalid Date")

      validator = subject.new(obj, :created_at, :as => :date)
      expect(validator).to_not be_valid
    end

    it "has the correct error message" do
      obj = double(:created_at => "Invalid Date")

      validator = subject.new(obj, :created_at, :as => :date)
      expect(validator.error_message).to eq(
        "created_at is not a valid date"
      )
    end
  end

  context ":as is :datetime" do
    it "passes validation if the attribute is a valid datetime" do
      obj1 = double(:created_at => DateTime.now)
      obj2 = double(:created_at => DateTime.now.to_s)

      validator1 = subject.new(obj1, :created_at, :as => :datetime)
      validator2 = subject.new(obj2, :created_at, :as => :datetime)
      expect(validator1).to be_valid
      expect(validator2).to be_valid
    end

    it "fails validation if the attribute is an invalid datetime" do
      obj = double(:created_at => "Invalid DateTime")

      validator = subject.new(obj, :created_at, :as => :datetime)
      expect(validator).to_not be_valid
    end

    it "has the correct error message" do
      obj = double(:created_at => "Invalid DateTime")

      validator = subject.new(obj, :created_at, :as => :datetime)
      expect(validator.error_message).to eq(
        "created_at is not a valid datetime"
      )
    end
  end

  context ":as is :time" do
    it "passes validation if the attribute is a valid time" do
      obj1 = double(:created_at => Time.now)
      obj2 = double(:created_at => Time.now.to_s)

      validator1 = subject.new(obj1, :created_at, :as => :time)
      validator2 = subject.new(obj2, :created_at, :as => :time)
      expect(validator1).to be_valid
      expect(validator2).to be_valid
    end

    it "fails validation if the attribute is an invalid time" do
      obj = double(:created_at => "Invalid Time")

      validator = subject.new(obj, :created_at, :as => :time)
      expect(validator).to_not be_valid
    end

    it "has the correct error message" do
      obj = double(:created_at => "Invalid Time")

      validator = subject.new(obj, :created_at, :as => :time)
      expect(validator.error_message).to eq(
        "created_at is not a valid time"
      )
    end
  end

  context ":as is invalid" do
    it "raises an ArgumentError" do
      obj = double(:created_at => "Invalid Time")

      validator = subject.new(obj, :created_at, :as => :foo)
      expect {
        validator.valid?
      }.to raise_error(DailyAffirmation::OptionError)
    end
  end

  context "the :before option is passed" do
    it "passes validation if the date is before the date passed in :before" do
      obj = double(:created_at => Date.today.prev_year(2))
      validator = subject.new(obj, :created_at, :before => Date.today.prev_year)
      expect(validator).to be_valid
    end

    it "fails validation if the date is after the date passed in :before" do
      obj = double(:created_at => Date.today)
      validator = subject.new(obj, :created_at, :before => Date.today.prev_year)
      expect(validator).to_not be_valid
    end
  end

  context "the :after option is passed" do
    it "fails validation if the date is before the date passed in :after" do
      obj = double(:created_at => Date.today.prev_year(2))
      validator = subject.new(obj, :created_at, :after => Date.today.prev_year)
      expect(validator).to_not be_valid
    end

    it "passes validation if the date is after the date passed in :after" do
      obj = double(:created_at => Date.today)
      validator = subject.new(obj, :created_at, :after => Date.today.prev_year)
      expect(validator).to be_valid
    end
  end
end
