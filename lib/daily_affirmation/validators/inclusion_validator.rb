require_relative "../validator"

module DailyAffirmation
  module Validators
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
