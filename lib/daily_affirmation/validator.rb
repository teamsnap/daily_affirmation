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
      raise StandardError, "must implement #error_message"
    end

    private

    attr_accessor :object, :attribute, :value, :opts
  end
end
