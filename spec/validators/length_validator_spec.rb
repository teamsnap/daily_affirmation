require_relative "../spec_helper"
require_relative "../../lib/daily_affirmation/validators/length_validator"

describe "LengthValidator" do
  subject { DailyAffirmation::Validators::LengthValidator }

  it "passes validation if the attribute's size is within range" do
    obj = double(:name => "Bobby")

    validator = subject.new(obj, :name, :range => 1..10)
    expect(validator).to be_valid
  end

  it "fails validation if the attribute's size is lower than range" do
    obj = double(:name => "")

    validator = subject.new(obj, :name, :range => 1..10)
    expect(validator).to_not be_valid
  end

  it "fails validation if the attribute's size is higher than range" do
    obj = double(:name => "ABCDEFGHIJKLMNOPQRSTUVWXYZ")

    validator = subject.new(obj, :name, :range => 1..10)
    expect(validator).to_not be_valid
  end

  it "has the correct error message" do
    obj = double(:name => "ABCDEFGHIJKLMNOPQRSTUVWXYZ")

    validator = subject.new(obj, :name, :range => 1..10)
    expect(validator.error_message).to eq(
      "name is the wrong length (allowed 1..10)"
    )
  end
end
