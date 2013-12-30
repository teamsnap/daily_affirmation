require_relative "../spec_helper"
require_relative "../../lib/daily_affirmation/validators/inclusion_validator"

describe "InclusionValidator" do
  subject { DailyAffirmation::Validators::InclusionValidator }

  it "fails validation if attribute is not in the list" do
    obj = double(:age => 12)

    validator = subject.new(obj, :age, :list => 13..18)
    expect(validator).to_not be_valid
  end

  it "passes validation if attribute is in the list" do
    obj = double(:age => 13)

    validator = subject.new(obj, :age, :list => 13..18)
    expect(validator).to be_valid
  end

  it "has the correct error message" do
    obj = double(:age => 13)

    validator = subject.new(obj, :age, :list => 13..18)
    expect(validator.error_message).to eq(
      "age is not included in 13..18"
    )
  end
end
