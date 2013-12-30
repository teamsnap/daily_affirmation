require_relative "../validator"

module DailyAffirmation
  module Validators
    class LengthValidator < Validator
      def valid?
        @valid ||= opts[:range].include?(value.size)
      end

      def error_message
        @error_message ||= i18n_error_message(
          :length,
          :default => "#{attribute} is the wrong length (allowed #{opts[:range]})"
        )
      end
    end
  end
end
