module RubyRedtail
  class Notes
    def initialize (api_hash)
      @api_hash = api_hash
    end

    # Fetch Notes By Contact Id
    def fetch (contact_id, page = 1)
      RubyRedtail::Query.run("contacts/#{contact_id}/notes?page=#{page}", @api_hash, "GET")
    end

    # Update Note
    def update (contact_id, note_id, params)
      RubyRedtail::Query.run("contacts/#{contact_id}/notes/#{note_id}", @api_hash, 'PUT', params)
    end

    # Create New Note
    def create (contact_id, params)
      update(contact_id, 0, params)
    end

    # Fetch Recently Added Notes
    def recent
      RubyRedtail::Query.run("contacts/notes/recent", @api_hash, 'GET')
    end
  end
end