require_relative "../validator"

module DailyAffirmation
  module Validators
    # This affirmation ensures an attribute is equal to the :value option
    # given.
    #
    # @option opts [Object] :value used to determine if attribute is equal
    class EqualityValidator < Validator
      def valid?
        @valid ||= (opts[:value] == value)
      end

      def error_message
        @error_message ||= i18n_error_message(
          :equality, :default => "#{attribute} is not '#{opts[:value]}'"
        )
      end
    end
  end
end
