require_relative "../validator"

module DailyAffirmation
  module Validators
    # This affirmation ensures an attribute is present.
    class PresenceValidator < Validator
      def valid?
        @valid ||= present?
      end

      def error_message
        @error_message ||= i18n_error_message(
          :presence, :default => "#{attribute} can't be blank"
        )
      end

      private

      def blank?
        if value.is_a?(String)
          value !~ /[^[:space:]]/
        else
          value.respond_to?(:empty?) ? value.empty? : !value
        end
      end

      def present?
        !blank?
      end
    end
  end
end
