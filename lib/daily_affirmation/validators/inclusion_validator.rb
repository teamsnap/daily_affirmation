require_relative "../validator"

module DailyAffirmation
  module Validators
    # This affirmation ensures an attribute is in the provided :list option.
    class InclusionValidator < Validator
      def valid?
        @valid ||= opts[:list].include?(value)
      end

      def error_message
        @error_message ||= i18n_error_message(
          :inclusion,
          :default => "#{attribute} is not included in #{opts[:list]}"
        )
      end
    end
  end
end
