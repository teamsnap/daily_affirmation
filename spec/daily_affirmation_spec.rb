require_relative "spec_helper"
require_relative "../lib/daily_affirmation"

describe DailyAffirmation do
  describe ".affirms_presence_of" do
    let(:cls) do
      Class.new do
        include DailyAffirmation.affirmations

        affirms_presence_of :name
      end
    end

    it "fails validation if attribute is nil" do
      obj = double(:name => nil)

      affirmation = cls.new(obj)
      expect(affirmation).to_not be_valid
    end

    it "fails validation if attribute is empty" do
      obj = double(:name => " ")

      affirmation = cls.new(obj)
      expect(affirmation).to_not be_valid
    end

    it "passes validation if attribute is present" do
      obj = double(:name => :foo)

      affirmation = cls.new(obj)
      expect(affirmation).to be_valid
    end
  end

  describe ".affirms_inclusion_of" do
    let(:cls) do
      Class.new do
        include DailyAffirmation.affirmations

        affirms_inclusion_of :age, :list => 13..18
      end
    end

    it "fails validation if attribute is not in the list" do
      obj = double(:age => 12)

      affirmation = cls.new(obj)
      expect(affirmation).to_not be_valid
    end

    it "passes validation if attribute is in the list" do
      obj = double(:age => 13)

      affirmation = cls.new(obj)
      expect(affirmation).to be_valid
    end
  end
end
