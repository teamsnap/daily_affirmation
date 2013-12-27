require_relative "../spec_helper"
require_relative "../../lib/daily_affirmation/validators/acceptance_validator"

describe "AcceptanceValidator" do
  subject { DailyAffirmation::Validators::AcceptanceValidator }

  it "passes validation if attribute is not nil/false" do
    obj = double(:eula => true)

    validator = subject.new(obj, :eula)
    expect(validator).to be_valid
  end

  it "fails validation if attribute is nil" do
    obj = double(:eula => nil)

    validator = subject.new(obj, :eula)
    expect(validator).to_not be_valid
  end

  it "fails validation if attribute is false" do
    obj = double(:eula => false)

    validator = subject.new(obj, :eula)
    expect(validator).to_not be_valid
  end

  it "has the correct error message" do
    obj = double(:eula => nil)

    validator = subject.new(obj, :eula)
    expect(validator.error_message).to eq(
      "eula must be accepted"
    )
  end
end
