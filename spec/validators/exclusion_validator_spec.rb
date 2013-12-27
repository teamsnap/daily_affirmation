require_relative "../spec_helper"
require_relative "../../lib/daily_affirmation/validators/exclusion_validator"

describe "ExclusionValidator" do
  subject { DailyAffirmation::Validators::ExclusionValidator }

  it "passes validation if attribute is not in the list" do
    obj = double(:age => 12)

    validator = subject.new(obj, :age, :list => 13..18)
    expect(validator).to be_valid
  end

  it "fails validation if attribute is in the list" do
    obj = double(:age => 13)

    validator = subject.new(obj, :age, :list => 13..18)
    expect(validator).to_not be_valid
  end

  it "has the correct error message" do
    obj = double(:age => 13)

    validator = subject.new(obj, :age, :list => 13..18)
    expect(validator.error_message).to eq(
      "age is reserved"
    )
  end
end
