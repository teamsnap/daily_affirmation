require_relative "../spec_helper"
require_relative "../../lib/daily_affirmation/validators/custom_validator"

describe "CustomValidator" do
  subject { DailyAffirmation::Validators::CustomValidator }

  it "passes validation if the proc returns true" do
    obj = double(:name => "Bobby Tabbles")

    validator = subject.new(obj, :name, :proc => Proc.new { |object|
      object.name == "Bobby Tabbles"
    })
    expect(validator).to be_valid
  end

  it "fails validation if the proc returns false" do
    obj = double(:name => "Bobby Tabbles")

    validator = subject.new(obj, :name, :proc => Proc.new { |object|
      object.name == "Robert Tabbles"
    })
    expect(validator).to_not be_valid
  end

  it "has the correct error message" do
    obj = double(:name => "Bobby Tabbles")

    validator = subject.new(obj, :name, :proc => Proc.new { |object|
      object.name == "Robert Tabbles"
    })
    expect(validator.error_message).to eq(
      "name is invalid"
    )
  end
end
