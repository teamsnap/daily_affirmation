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

  describe ".affirms_exclusion_of" do
    let(:cls) do
      Class.new do
        include DailyAffirmation.affirmations

        affirms_exclusion_of :age, :list => 13..18
      end
    end

    it "passes validation if attribute is not in the list" do
      obj = double(:age => 12)

      affirmation = cls.new(obj)
      expect(affirmation).to be_valid
    end

    it "fails validation if attribute is in the list" do
      obj = double(:age => 13)

      affirmation = cls.new(obj)
      expect(affirmation).to_not be_valid
    end
  end

  describe ".affirms_format_of" do
    let(:cls) do
      Class.new do
        include DailyAffirmation.affirmations

        affirms_format_of :name, :regex => /Bobby/
      end
    end

    it "passes validation if the attribute matches the format" do
      obj = double(:name => "Bobby Tabbles")

      affirmation = cls.new(obj)
      expect(affirmation).to be_valid
    end

    it "fails validation if the attribute doesn't match the format" do
      obj = double(:name => "Tommy Tabbles")

      affirmation = cls.new(obj)
      expect(affirmation).to_not be_valid
    end
  end

  describe ".affirms_length_of" do
    let(:cls) do
      Class.new do
        include DailyAffirmation.affirmations

        affirms_length_of :name, :range => 1..10
      end
    end

    it "passes validation if the attribute's size is within range" do
      obj = double(:name => "Bobby")

      affirmation = cls.new(obj)
      expect(affirmation).to be_valid
    end

    it "fails validation if the attribute's size is lower than range" do
      obj = double(:name => "")

      affirmation = cls.new(obj)
      expect(affirmation).to_not be_valid
    end

    it "fails validation if the attribute's size is higher than range" do
      obj = double(:name => "ABCDEFGHIJKLMNOPQRSTUVWXYZ")

      affirmation = cls.new(obj)
      expect(affirmation).to_not be_valid
    end
  end

  describe ".affirms_numericality_of" do
    let(:cls) do
      Class.new do
        include DailyAffirmation.affirmations

        affirms_numericality_of :age
      end
    end

    it "passes validation if the attribute is a Numeric" do
      obj = double(:age => 1.0)

      affirmation = cls.new(obj)
      expect(affirmation).to be_valid
    end

    it "fails validation if the attribute is not a Numeric" do
      obj = double(:age => "Bobby")

      affirmation = cls.new(obj)
      expect(affirmation).to_not be_valid
    end
  end

  describe ".affirms_acceptance_of" do
    let(:cls) do
      Class.new do
        include DailyAffirmation.affirmations

        affirms_acceptance_of :eula
      end
    end

    it "passes validation if attribute is not nil/false" do
      obj = double(:eula => true)

      affirmation = cls.new(obj)
      expect(affirmation).to be_valid
    end

    it "fails validation if attribute is nil" do
      obj = double(:eula => nil)

      affirmation = cls.new(obj)
      expect(affirmation).to_not be_valid
    end

    it "fails validation if attribute is false" do
      obj = double(:eula => false)

      affirmation = cls.new(obj)
      expect(affirmation).to_not be_valid
    end
  end

  describe ".affirms_confirmation_of" do
    let(:cls) do
      Class.new do
        include DailyAffirmation.affirmations

        affirms_confirmation_of :password
      end
    end

    it "passes validation if the attributes match" do
      obj = double(:password => 1, :password_confirmation => 1)

      affirmation = cls.new(obj)
      expect(affirmation).to be_valid
    end

    it "fails validation if the attributes don't match" do
      obj = double(:password => 1, :password_confirmation => 2)

      affirmation = cls.new(obj)
      expect(affirmation).to_not be_valid
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
      expect(is_valid).to be true
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
