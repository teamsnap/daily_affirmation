require_relative "daily_affirmation/process_affirmation_evaluator"
require_relative "daily_affirmation/affirmations"
require_relative "daily_affirmation/validators/absence_validator"
require_relative "daily_affirmation/validators/acceptance_validator"
require_relative "daily_affirmation/validators/confirmation_validator"
require_relative "daily_affirmation/validators/custom_validator"
require_relative "daily_affirmation/validators/date_validator"
require_relative "daily_affirmation/validators/equality_validator"
require_relative "daily_affirmation/validators/exclusion_validator"
require_relative "daily_affirmation/validators/format_validator"
require_relative "daily_affirmation/validators/inclusion_validator"
require_relative "daily_affirmation/validators/length_validator"
require_relative "daily_affirmation/validators/numericality_validator"
require_relative "daily_affirmation/validators/presence_validator"
require_relative "daily_affirmation/version"

module DailyAffirmation
  OptionError = Class.new(StandardError)

  # Include DailyAffirmation.affirmations to make your object a validator.
  def self.affirmations
    Module.new do
      def self.included(descendant)
        descendant.send(:include, ::DailyAffirmation::Affirmations)
      end
    end
  end
end
