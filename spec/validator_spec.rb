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

  it "uses a generic error message if one is not provied" do
    cls = Class.new(DailyAffirmation::Validator) do
      def valid?; false; end
    end
    obj = double(:age => 13)

    expect(cls.new(obj, :age).error_message).to eq("age failed validation")
  end

  context "i18n required" do
    before(:all) do
      require "i18n"
      I18n.enforce_available_locales = false
    end

    after(:all) { Object.send(:remove_const, :I18n) if defined?(I18n) }

    it "uses specific translation if available" do
      I18n.load_path = [File.expand_path("../support/specific.yml", __FILE__)]
      I18n.backend.load_translations

      cls = Class.new(DailyAffirmation::Validator) do
        def valid?; false; end
      end
      obj = double(:age => 13)

      expect(cls.new(obj, :age).error_message).to eq("must include age yo!")
    end

    it "uses generic translation if specific is not available" do
      I18n.load_path = [File.expand_path("../support/generic.yml", __FILE__)]
      I18n.backend.load_translations

      cls = Class.new(DailyAffirmation::Validator) do
        def valid?; false; end
      end
      obj = double(:age => 13)

      expect(cls.new(obj, :age, :range => 10..20).error_message).to eq(
        "egads man, you must have age (10..20, 13)"
      )
    end

    it "uses default if both translations are unavailable" do
      I18n.load_path = [File.expand_path("../support/default.yml", __FILE__)]
      I18n.backend.load_translations

      cls = Class.new(DailyAffirmation::Validator) do
        def valid?; false; end
      end
      obj = double(:age => 13)

      expect(cls.new(obj, :age).error_message).to eq("age failed validation")
    end
  end
end
