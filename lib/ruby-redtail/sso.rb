module RubyRedtail
  class Sso
    def initialize(sso = {})
      raise ArgumentError if sso.class != Hash
      sso.each do |key, value|
        key = key.underscore
        self.class.send :attr_accessor, key
        instance_variable_set "@#{key}", value
      end
    end
  end
end