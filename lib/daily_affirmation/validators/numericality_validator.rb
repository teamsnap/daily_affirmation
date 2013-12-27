require_relative "../validator"

module DailyAffirmation
  module Validators
    class NumericalityValidator < Validator
      def valid?
        @valid ||= value.is_a?(Numeric)
      end

      def error_message
        @error_message ||= "#{attribute} is not a number"
      end
    end
  end
end
