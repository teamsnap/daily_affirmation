require_relative "../validator"

module DailyAffirmation
  module Validators
    # This affirmation accepts a :proc option and evaluates it's results.
    #
    # @option opts [Proc] :proc evaluated to determine if attribute should be
    #   validated.
    class CustomValidator < Validator
      def valid?
        @valid ||= opts[:proc].call(object)
      end

      def error_message
        @error_message ||= i18n_error_message(
          :custom, :default => "#{attribute} is invalid"
        )
      end
    end
  end
end
