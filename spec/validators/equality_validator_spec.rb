require_relative "../spec_helper"
require_relative "../../lib/daily_affirmation/validators/equality_validator"

describe "EqualityValidator" do
  subject { DailyAffirmation::Validators::EqualityValidator }

  it "passes validation if the attribute value matches the value" do
    obj = double(:name => "Bobby Tabbles")

    validator = subject.new(obj, :name, :value => "Bobby Tabbles")
    expect(validator).to be_valid
  end

  it "fails validation if the attribute values doesn't match the value" do
    obj = double(:name => "Robert Tabbles")

    validator = subject.new(obj, :name, :value => "Bobby Tabbles")
    expect(validator).to_not be_valid
  end

  it "has the correct error message" do
    obj = double(:name => "Robert Tabbles")

    validator = subject.new(obj, :name, :value => "Bobby Tabbles")
    expect(validator.error_message).to eq(
      "name is not 'Bobby Tabbles'"
    )
  end
end
