module RubyRedtail
  class Authentication
    def initialize(authentication = {})
      raise ArgumentError if authentication.class != Hash
      authentication.each do |key, value|
        key = key.underscore
        self.class.send :attr_accessor, key
        instance_variable_set "@#{key}", value
      end
    end
  end
end