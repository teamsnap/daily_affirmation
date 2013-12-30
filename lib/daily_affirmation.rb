require_relative "daily_affirmation/affirmations"
require_relative "daily_affirmation/validators/absence_validator"
require_relative "daily_affirmation/validators/acceptance_validator"
require_relative "daily_affirmation/validators/confirmation_validator"
require_relative "daily_affirmation/validators/exclusion_validator"
require_relative "daily_affirmation/validators/format_validator"
require_relative "daily_affirmation/validators/inclusion_validator"
require_relative "daily_affirmation/validators/length_validator"
require_relative "daily_affirmation/validators/numericality_validator"
require_relative "daily_affirmation/validators/presence_validator"
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
