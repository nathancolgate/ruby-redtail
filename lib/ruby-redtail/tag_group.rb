module RubyRedtail
  class TagGroup
    
    def initialize(tag_group = {},api_hash)
      @api_hash = api_hash
      
      raise ArgumentError unless tag_group['RecID']
      @id = tag_group['RecID']
      
      raise ArgumentError if setting.class != Hash
      setting.each do |key, value|
        key = key.underscore
        self.class.send :attr_accessor, key
        instance_variable_set "@#{key}", value
      end
    end
    
    def contacts
      RubyRedtail::TagGroup::Contacts.new self.api_hash
    end
    
  end
end