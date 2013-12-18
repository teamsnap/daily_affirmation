require_relative "daily_affirmation/affirmations"
require_relative "daily_affirmation/version"

module DailyAffirmation
  def self.affirmations
    Module.new do
      def self.included(descendant)
        descendant.send(:include, ::DailyAffirmation::Affirmations)
      end
    end
  end
end
