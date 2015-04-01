module DailyAffirmation
  class Validator
    # Initializes a new validator to validate the given object/attribute
    # combination.
    #
    # @param object [Object] the object to validate.
    # @param attribute [Symbol] the attribute to validate. The object must
    #   `respond_to?` a method with the name `attribute` with no arguments.
    # @param opts [Hash] any special options related to the affirmation.
    # @option opts [Proc] :if evaluated before affirmation to ensure we should
    #   run validation.
    # @option opts [true, false] :allow_nil determines if we skip validation of
    #   `nil` valued attributes.
    # @option opts [true, false] :allow_blank determines if we skip validation
    #   of `""` valued attributes.
    #
    # @return [self]
    def initialize(object, attribute, opts = {})
      self.object = object
      self.attribute = attribute
      self.value = object.send(attribute)
      self.opts = opts
    end

    # Returns an array of length 2 telling you if the object passes this
    # affirmation along with an error message if it doesn't.
    #
    # @return [Array(Boolean, [nil, String])] Array of length 2 containing
    #   validation results.
    def affirm
      @affirm ||= [valid?, valid? ? nil : error_message]
    end

    # Tells you if the object is valid based on this affirmation.
    #
    # @note Subclasses of DailyAffirmation::Validator must implement this
    # method.
    #
    # @return [true, false]
    def valid?
      raise StandardError, "must implement #valid?"
    end

    # Returns the error message related to this validation.
    #
    # @note This method will always return the associated error message, even
    # if the object passes validation.
    #
    # @return [String]
    def error_message
      i18n_error_message(:none)
    end

    private

    attr_accessor :object, :attribute, :value, :opts

    def i18n_error_message(type, default: "#{attribute} failed validation")
      if defined?(I18n)
        args = opts.merge(
          {
            :default => [
              :"daily_affirmation.errors.messages.#{type}.default", default
            ],
            :attribute => attribute,
            :value => value
          }
        )
        I18n.t(:"daily_affirmation.errors.messages.#{type}.#{attribute}", args)
      else
        default
      end
    end
  end
end
