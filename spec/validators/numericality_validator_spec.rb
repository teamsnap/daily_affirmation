require_relative "../spec_helper"
require_relative "../../lib/daily_affirmation/validators/numericality_validator"

describe "NumericalityValidator" do
  subject { DailyAffirmation::Validators::NumericalityValidator }

  it "passes validation if the attribute is a Numeric" do
    obj = double(:age => 1.0)

    validator = subject.new(obj, :age)
    expect(validator).to be_valid
  end

  it "fails validation if the attribute is not a Numeric" do
    obj = double(:age => "Bobby")

    validator = subject.new(obj, :age)
    expect(validator).to_not be_valid
  end

  it "has the correct error message" do
    obj = double(:age => "Bobby")

    validator = subject.new(obj, :age)
    expect(validator.error_message).to eq(
      "age is not a number"
    )
  end
end
