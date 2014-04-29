require 'ruby-redtail/tag_group/contacts'

module RubyRedtail
  class TagGroup
    
    def initialize(tag_group = {},api_hash)
      @api_hash = api_hash
      
      raise ArgumentError unless tag_group['RecID']
      @id = tag_group['RecID']
      
      raise ArgumentError if tag_group.class != Hash
      tag_group.each do |key, value|
        key = key.underscore
        self.class.send :attr_accessor, key
        instance_variable_set "@#{key}", value
      end
    end
    
    def contacts
      build_contacts_array RubyRedtail::Query.run("taggroups/#{@id}/contacts", @api_hash, "GET")["TagMember_Result"]["TagMembers"]
    end
      
    private
    
    def build_contact contact_hash
      if contact_hash
        RubyRedtail::Contact.new(contact_hash,@api_hash)
      else
        raise RubyRedtail::AuthenticationError
      end
    end

    def build_contacts_array contact_hashes
      if contact_hashes
        contact_hashes.collect { |contact_hash| self.build_contact contact_hash }
      else
        raise RubyRedtail::AuthenticationError
      end
    end
    
  end
end