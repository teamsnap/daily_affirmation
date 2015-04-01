class ProcessAffirmationEvaluator
  def initialize(object, attribute, args)
    self.object = object
    self.attribute = attribute
    self.args = args
  end

  def process?
    if_statement_passes? && process_non_nil_value? && process_non_blank_value?
  end

  private

  attr_accessor :object, :attribute, :args

  def if_statement_passes?
    if args.include?(:if)
      instance_eval(&args[:if])
    else
      true
    end
  end

  def process_non_blank_value?
    !(allow_blank_values? && object_is_blank?)
  end

  def allow_blank_values?
    args.include?(:allow_blank)
  end

  def object_is_blank?
    blank?(object.send(attribute))
  end

  def blank?(val)
    case val
    when String
      val !~ /[^[:space:]]/
    else
      val.respond_to?(:empty?) ? val.empty? : !val
    end
  end

  def object_is_nil?
    object.send(attribute).nil?
  end

  def allow_nil_values?
    args.include?(:allow_nil)
  end

  def process_non_nil_value?
    !(allow_nil_values? && object_is_nil?)
  end
end
