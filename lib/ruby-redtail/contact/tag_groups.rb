module RubyRedtail
  class Contact
    class TagGroups
      def initialize(contact_id,api_hash)
        @api_hash = api_hash
        @contact_id = contact_id
      end
  
      # def fetch(tag_id)
      #   RubyRedtail::Query.run("tag_groups/#{tag_id}", @api_hash, "GET")
      # end
      #   
      # def fetch_contacts(tag_id)
      #   RubyRedtail::Query.run("tag_groups/#{tag_id}/contacts", @api_hash, "GET")
      # end
  
      def fetch
        build_tag_groups_array RubyRedtail::Query.run("contacts/#{@contact_id}/taggroups", @api_hash, "GET")["ArrayOfTagGroup"]
      end
      
      private
      
      def build_tag_group tag_group_hash
        if tag_group_hash
          RubyRedtail::TagGroup.new(tag_group_hash,@api_hash)
        else
          raise RubyRedtail::AuthenticationError
        end
      end

      def build_tag_groups_array tag_group_hashes
        if tag_group_hashes
          tag_group_hashes.collect { |tag_group_hash| self.build_tag_group tag_group_hash }
        else
          raise RubyRedtail::AuthenticationError
        end
      end
      
    end
  end
end