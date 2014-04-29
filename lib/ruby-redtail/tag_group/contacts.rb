module RubyRedtail
  class TagGroup
    class Contacts
      def initialize(tag_group_id,api_hash)
        @api_hash = api_hash
        @tag_group_id = tag_group_id
      end
  
      def fetch
        build_contacts_array RubyRedtail::Query.run("taggroups/#{@tag_group_id}/contacts", @api_hash, "GET")["TagMember_Result"]["TagMembers"]
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
end