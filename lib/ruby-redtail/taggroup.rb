module RubyRedtail
  class Taggroup
    def initialize(setting = {},api_hash)
      @api_hash = api_hash
      
      raise ArgumentError if setting.class != Hash
      setting.each do |key, value|
        key = key.underscore
        self.class.send :attr_accessor, key
        instance_variable_set "@#{key}", value
      end
    end
  end
end