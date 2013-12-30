require_relative "../spec_helper"
require_relative "../../lib/daily_affirmation/validators/confirmation_validator"

describe "ConfirmationValidator" do
  subject { DailyAffirmation::Validators::ConfirmationValidator }

  it "passes validation if the attributes match" do
    obj = double(:password => 1, :password_confirmation => 1)

    validator = subject.new(obj, :password)
    expect(validator).to be_valid
  end

  it "fails validation if the attributes don't match" do
    obj = double(:password => 1, :password_confirmation => 2)

    validator = subject.new(obj, :password)
    expect(validator).to_not be_valid
  end

  it "has the correct error message" do
    obj = double(:password => 1, :password_confirmation => 2)

    validator = subject.new(obj, :password)
    expect(validator.error_message).to eq(
      "password doesn't match confirmation"
    )
  end
end
