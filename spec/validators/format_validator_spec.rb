require_relative "../spec_helper"
require_relative "../../lib/daily_affirmation/validators/format_validator"

describe "FormatValidator" do
  subject { DailyAffirmation::Validators::FormatValidator }

  it "passes validation if the attribute matches the format" do
    obj = double(:name => "Bobby Tabbles")

    validator = subject.new(obj, :name, :regex => /Bobby/)
    expect(validator).to be_valid
  end

  it "fails validation if the attribute doesn't match the format" do
    obj = double(:name => "Tommy Tabbles")

    validator = subject.new(obj, :name, :regex => /Bobby/)
    expect(validator).to_not be_valid
  end

  it "has the correct error message" do
    obj = double(:name => "Tommy Tabbles")

    validator = subject.new(obj, :name, :regex => /Bobby/)
    expect(validator.error_message).to eq(
      "name is invalid"
    )
  end
end
