require_relative "../validator"

module DailyAffirmation
  module Validators
    class AcceptanceValidator < Validator
      def valid?
        @valid ||= !!value
      end

      def error_message
        @error_message ||= i18n_error_message(
          :acceptance, :default => "#{attribute} must be accepted"
        )
      end
    end
  end
end
