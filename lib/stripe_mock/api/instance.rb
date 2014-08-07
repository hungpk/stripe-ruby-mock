module StripeMock

  @state = 'ready'
  @instance = nil
  @original_request_method = Stripe.method(:request)

  def self.start
    @instance = Instance.new
    alias_stripe_method :request, @instance.method(:mock_request)
    @state = 'local'
  end

  def self.stop
    return unless @state == 'local'
    alias_stripe_method :request, @original_request_method
    @instance = nil
    @state = 'ready'
  end

  def self.alias_stripe_method(new_name, method_object)
    
    Stripe.singleton_class.send(:define_method, new_name){ |*args| method_object.call(*args) }
    
    #Stripe.define_singleton_method(new_name) {|*args| method_object.call(*args) }
  end

  def self.instance; @instance; end
  def self.state; @state; end
    
end

module Stripe
  def singleton_class
      class << self; self end
  end
end