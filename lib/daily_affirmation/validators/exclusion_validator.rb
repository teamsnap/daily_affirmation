require_relative "../validator"
require_relative "inclusion_validator"

module DailyAffirmation
  module Validators
    # This affirmation ensures an attribute is not in the provided :list
    # option.
    class ExclusionValidator < Validator
      def valid?
        @valid ||= !InclusionValidator.new(object, attribute, opts).valid?
      end

      def error_message
        @error_message ||= i18n_error_message(
          :exclusion, :default => "#{attribute} is reserved"
        )
      end
    end
  end
end
