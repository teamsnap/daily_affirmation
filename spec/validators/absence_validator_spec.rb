require_relative "../spec_helper"
require_relative "../../lib/daily_affirmation/validators/absence_validator"

describe "AbsenceValidator" do
  subject { DailyAffirmation::Validators::AbsenceValidator }

  it "fails validation if the attribute is present" do
    obj = double(:name => :foo)

    validator = subject.new(obj, :name)
    expect(validator).to_not be_valid
  end

  it "passes validation if the attribute is empty" do
    obj = double(:name => " ")

    validator = subject.new(obj, :name)
    expect(validator).to be_valid
  end

  it "passes validation if the attribute is nil" do
    obj = double(:name => nil)

    validator = subject.new(obj, :name)
    expect(validator).to be_valid
  end

  it "has the correct error message" do
    obj = double(:name => :foo)

    validator = subject.new(obj, :name)
    expect(validator.error_message).to eq(
      "name must be blank"
    )
  end
end
