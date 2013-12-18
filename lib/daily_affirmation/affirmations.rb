module DailyAffirmation
  module Affirmations
    def self.included(descendant)
      descendant.extend(ClassMethods)
    end

    def initialize(object)
      self.object = object
    end

    def valid?
      affirmations
        .map { |affirmation| affirm(affirmation) }
        .all?
    end

    private

    attr_accessor :object

    def affirmations
      self.class.affirmations
    end

    def affirm(affirmation)
      method = "affirm_#{affirmation[:type]}_of"
      attribute = affirmation[:attribute]
      args = affirmation.reject { |k, _| [:type, :attribute].include?(k) }
      send(method, attribute, args)
    end

    def affirm_presence_of(attribute, _ = {})
      present?(attribute)
    end

    def affirm_inclusion_of(attribute, list: [])
      list.include?(object.send(attribute))
    end

    def blank?(attribute)
      value = object.send(attribute)
      case value
      when String
        value !~ /[^[:space:]]/
      else
        value.respond_to?(:empty?) ? value.empty? : !value
      end
    end

    def present?(attribute)
      !blank?(attribute)
    end

    module ClassMethods
      def affirms_presence_of(attribute)
        affirmations << {:attribute => attribute, :type => :presence}
      end

      def affirms_inclusion_of(attribute, list: [])
        affirmations << {
          :attribute => attribute, :type => :inclusion, :list => list
        }
      end

      def affirmations
        @affirmations ||= []
      end
    end
  end
end
