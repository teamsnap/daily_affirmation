require_relative "../validator"

module DailyAffirmation
  module Validators
    class NumericalityValidator < Validator
      def valid?
        @valid ||= value ? numeric? && greater_than? && less_than? : true
      end

      def error_message
        @error_message ||= i18n_error_message(
          :numericality, :default => default_error_message
        )
      end

      private

      def numeric?
        @numeric ||= value.is_a?(Numeric)
      end

      def greater_than?
        @greater_than ||= if numeric? && gt = opts[:greater_than]
                            value > gt
                          else
                            true
                          end
      end

      def less_than?
        @less_than ||= if numeric? && lt = opts[:less_than]
                         value < lt
                       else
                         true
                       end
      end

      def default_error_message
        numeric_error_message + greater_than_error_message +
          less_than_error_message
      end

      def numeric_error_message
        "#{attribute} must be a number."
      end

      def greater_than_error_message
        if greater_than?
          ""
        else
          " Must also be greater than #{opts[:greater_than]}."
        end
      end

      def less_than_error_message
        if less_than?
          ""
        else
          " Must also be less than #{opts[:less_than]}."
        end
      end
    end
  end
end
