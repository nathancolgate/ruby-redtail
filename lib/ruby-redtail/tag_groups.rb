module RubyRedtail
  class TagGroups
    def initialize api_hash
      @api_hash = api_hash
    end

    def fetch(tag_id)
      RubyRedtail::Query.run("taggroups/#{tag_id}", @api_hash, "GET")
    end

    def fetch_contacts(tag_id)
      RubyRedtail::Query.run("taggroups/#{tag_id}/contacts", @api_hash, "GET")
    end

    def fetch_by_contact(contact_id)
      RubyRedtail::Query.run("contacts/#{contact_id}/taggroups", @api_hash, "GET")
    end
  end
end