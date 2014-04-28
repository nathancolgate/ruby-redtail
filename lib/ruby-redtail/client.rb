module RubyRedtail
  class Client < RubyRedtail::Contact
    # http://help.redtailtechnology.com/entries/21654562-authentication-methods
    def initialize(client = {}, api_hash)
      @api_hash = api_hash
      
      raise ArgumentError unless client['ClientID']
      @id = client['ClientID']
      
      raise ArgumentError if client.class != Hash
      client.each do |key, value|
        key = key.underscore
        self.class.send :attr_accessor, key
        instance_variable_set "@#{key}", value
      end
    end

  end
end