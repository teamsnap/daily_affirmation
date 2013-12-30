module DailyAffirmation
  class Validator
    def initialize(object, attribute, opts = {})
      self.object = object
      self.attribute = attribute
      self.value = object.send(attribute)
      self.opts = opts
    end

    def affirm
      @affirm ||= [valid?, valid? ? nil : error_message]
    end

    def valid?
      raise StandardError, "must implement #valid?"
    end

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
              :"daily_affirmation.errors.messages.#{type}", default
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
