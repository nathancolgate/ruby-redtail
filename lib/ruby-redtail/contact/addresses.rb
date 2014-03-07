module RubyRedtail
  class Addresses

    def initialize(api_hash)
      @api_hash = api_hash
    end

    # Fetch Address By Contact Id
    def fetch (contact_id)
      RubyRedtail::Query.run("contacts/#{contact_id}/addresses", @api_hash, "GET")
    end

    # Update Address
    def update (contact_id, address_id, params)
      RubyRedtail::Query.run("contacts/#{contact_id}/addresses/#{address_id}", @api_hash, 'PUT', params)
    end

    # Create New Address
    def create (contact_id, params)
      update(contact_id, 0, params)
    end

    # Delete Address
    def delete (contact_id, address_id)
      RubyRedtail::Query.run("contacts/#{contact_id}/addresses/#{address_id}", @api_hash, 'DELETE')
    end

    # Fetch Phones By Contact Id
    def phones (contact_id)
      RubyRedtail::Query.run("contacts/#{contact_id}/phones", @api_hash, "GET")
    end

    # Update Phone
    def update_phone (contact_id, phone_id, params)
      RubyRedtail::Query.run("contacts/#{contact_id}/phones/#{phone_id}", @api_hash, 'PUT', params)
    end

    # Create New Phone
    def create_phone (contact_id, params)
      update(contact_id, 0, params)
    end

    # Delete Phone
    def delete_phone (contact_id, phone_id)
      RubyRedtail::Query.run("contacts/#{contact_id}/phones/#{phone_id}", @api_hash, 'DELETE')
    end

    # Fetch Internet Addresses By Contact Id
    def internet_addresses (contact_id)
      RubyRedtail::Query.run("contacts/#{contact_id}/internets", @api_hash, "GET")
    end

    # Update Internet Address
    def update_internet_address (contact_id, internet_id, params)
      RubyRedtail::Query.run("contacts/#{contact_id}/phones/#{internet_id}", @api_hash, 'PUT', params)
    end

    # Create New Internet Address
    def create_internet_address (contact_id, params)
      update_internet_address(contact_id, 0, params)
    end

    # Delete Internet Address
    def delete_internet_address (contact_id, internet_id)
      RubyRedtail::Query.run("contacts/#{contact_id}/phones/#{internet_id}", @api_hash, 'DELETE')
    end

    # Fetch Assets and Liabilities
    def assets_and_liabilities (contact_id)
      RubyRedtail::Query.run("contacts/#{contact_id}/assets-liabilities", @api_hash, "GET")
    end

  end
end