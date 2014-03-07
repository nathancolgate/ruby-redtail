module RubyRedtail
  class Accounts
    def initialize (api_hash)
      @api_hash = api_hash
    end

    def fetch (contact_id)
      RubyRedtail::Query.run("contacts/#{contact_id}/accounts", @api_hash, "GET")
    end

    def update (contact_id, account_id, params)
      RubyRedtail::Query.run("contacts/#{contact_id}/accounts/#{account_id}", @api_hash, 'PUT', params)
    end

    def create (contact_id, params)
      update(contact_id, 0, params)
    end

    def assets (contact_id, account_id)
      RubyRedtail::Query.run("contacts/#{contact_id}/#{account_id}/assets", @api_hash, "GET")
    end
  end
end