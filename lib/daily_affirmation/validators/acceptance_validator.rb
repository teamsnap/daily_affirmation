require_relative "../validator"

module DailyAffirmation
  module Validators
    class AcceptanceValidator < Validator
      def valid?
        @valid ||= !!value
      end

      def error_message
        @error_message ||= "#{attribute} must be accepted"
      end
    end
  end
end
