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

  describe ".affirms_absence_of" do
    let(:cls) do
      Class.new do
        include DailyAffirmation.affirmations

        affirms_absence_of :name
      end
    end

    it "passes validation if attribute is nil" do
      obj = double(:name => nil)

      affirmation = cls.new(obj)
      expect(affirmation).to be_valid
    end

    it "passes validation if attribute is empty" do
      obj = double(:name => " ")

      affirmation = cls.new(obj)
      expect(affirmation).to be_valid
    end

    it "fails validation if attribute is present" do
      obj = double(:name => :foo)

      affirmation = cls.new(obj)
      expect(affirmation).to_not be_valid
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

  describe "#validate" do
    let(:cls) do
      Class.new do
        include DailyAffirmation.affirmations

        affirms_presence_of :name
        affirms_inclusion_of :age, :list => 13..18
      end
    end

    it "returns if object is valid as the first result" do
      obj = double(:name => :foo, :age => 13)
      affirmation = cls.new(obj)

      is_valid = affirmation.validate[0]
      expect(is_valid).to eq(true)
    end

    it "returns validation error messages as the second result" do
      obj = double(:name => "", :age => 12)
      affirmation = cls.new(obj)

      messages = affirmation.validate[1]
      expect(messages).to include("name can't be blank")
      expect(messages).to include("age is not included in 13..18")
    end
  end

  describe "#valid" do
    let(:cls) do
      Class.new do
        include DailyAffirmation.affirmations

        affirms_presence_of :name
        affirms_inclusion_of :age, :list => 13..18
      end
    end

    it "returns true if the object is valid" do
      obj = double(:name => :foo, :age => 13)
      affirmation = cls.new(obj)

      expect(affirmation).to be_valid
    end

    it "returns false if the object is not valid" do
      obj = double(:name => "", :age => 12)
      affirmation = cls.new(obj)

      expect(affirmation).to_not be_valid
    end
  end

  describe "error_messages" do
    let(:cls) do
      Class.new do
        include DailyAffirmation.affirmations

        affirms_presence_of :name
        affirms_inclusion_of :age, :list => 13..18
      end
    end

    it "returns an array of error message if the object is not valid" do
      obj = double(:name => "", :age => 12)
      affirmation = cls.new(obj)
      messages = affirmation.error_messages

      expect(messages).to include("name can't be blank")
      expect(messages).to include("age is not included in 13..18")
    end

    it "returns an empty array if the object is valid" do
      obj = double(:name => :foo, :age => 13)
      affirmation = cls.new(obj)
      messages = affirmation.error_messages

      expect(messages).to eq([])
    end
  end
end
