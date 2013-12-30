require_relative "../validator"

module DailyAffirmation
  module Validators
    class NumericalityValidator < Validator
      def valid?
        @valid ||= value.is_a?(Numeric)
      end

      def error_message
        @error_message ||= i18n_error_message(
          :numericality, :default => "#{attribute} is not a number"
        )
      end
    end
  end
end
