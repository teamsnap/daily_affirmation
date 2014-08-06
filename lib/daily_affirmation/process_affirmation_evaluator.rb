class ProcessAffirmationEvaluator
  def initialize(object, attribute, args)
    self.object = object
    self.attribute = attribute
    self.args = args
  end

  def process?
    if_statement_passes? && allow_nil_passes?
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

  def allow_nil_passes?
    if args.include?(:allow_nil)
      object.send(attribute)
    else
      true
    end
  end
end
