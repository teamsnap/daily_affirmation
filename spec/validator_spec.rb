require_relative "spec_helper"
require_relative "../lib/daily_affirmation/validator"

describe "Validator" do
  it "requires #valid? to be implemented" do
    cls = Class.new(DailyAffirmation::Validator)
    obj = double(:age => 13)

    expect { cls.new(obj, :age).affirm }.to raise_error(
      StandardError, "must implement #valid?"
    )
  end

  it "requires #error_message to be implemented" do
    cls = Class.new(DailyAffirmation::Validator) do
      def valid?; false; end
    end
    obj = double(:age => 13)

    expect { cls.new(obj, :age).affirm }.to raise_error(
      StandardError, "must implement #error_message"
    )
  end
end
