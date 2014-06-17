require_relative "spec_helper"
require_relative "../lib/daily_affirmation"

describe DailyAffirmation do
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
      expect(is_valid).to be(true)
    end

    it "returns validation error messages as the second result" do
      obj = double(:name => "", :age => 12)
      affirmation = cls.new(obj)

      messages = affirmation.validate[1]
      expect(messages).to include("name can't be blank")
      expect(messages).to include("age is not included in 13..18")
    end
  end

  describe "#valid?" do
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

  describe ".affirms_*_of" do
    let(:cls) do
      Class.new do
        include DailyAffirmation.affirmations

        affirms_absence_of :conflicts
        affirms_acceptance_of :eula
        affirms_confirmation_of :password
        affirms_exclusion_of :age, :list => 13..18
        affirms_format_of :name, :regex => /Bobby/
        affirms_inclusion_of :age, :list => 1..21
        affirms_length_of :password, :range => 8..40
        affirms_numericality_of :age
        affirms_presence_of :name
        affirms :name, :proc => Proc.new { |object|
          object.name == "Bobby Tabbles"
        }
      end
    end

    it "correct sets up affirmations" do
      obj = double(
        :conflicts => nil,
        :eula => true,
        :password => "test1234",
        :password_confirmation => "test1234",
        :age => 19,
        :name => "Bobby Tabbles"
      )

      affirmation = cls.new(obj)
      expect(affirmation).to be_valid
    end
  end

  it "allows each affirmation to be skipped via an :if option" do
    cls = Class.new do
      include DailyAffirmation.affirmations

      affirms_presence_of :name, :if => Proc.new { object.age > 10 }
    end

    obj1 = double(:name => nil, :age => 1)
    obj2 = double(:name => nil, :age => 11)

    affirmation1 = cls.new(obj1)
    affirmation2 = cls.new(obj2)
    expect(affirmation1).to be_valid
    expect(affirmation2).to_not be_valid
  end

  it "allows each affirmation to be inverted via an :inverse option" do
    cls = Class.new do
      include DailyAffirmation.affirmations

      affirms_presence_of :name, :inverse => true
    end

    obj1 = double(:name => nil)
    obj2 = double(:name => :foo)

    affirmation1 = cls.new(obj1)
    affirmation2 = cls.new(obj2)
    expect(affirmation1).to be_valid
    expect(affirmation2).to_not be_valid
  end
end
