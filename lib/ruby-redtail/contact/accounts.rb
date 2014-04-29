module RubyRedtail
  class Contact
    class Account
      def initialize(contact_id, account_id, api_hash)
        @api_hash = api_hash
        @contact_id = contact_id
        @account_id = account_id
      end

      def fetch
        RubyRedtail::Query.run("contacts/#{@contact_id}/accounts", @api_hash, "GET")
      end

      def create (params)
        update(@contact_id, 0, params)
      end

      def update (account_id, params)
        RubyRedtail::Query.run("contacts/#{@contact_id}/accounts/#{account_id}", @api_hash, 'PUT', params)
      end

      def assets (account_id)
        RubyRedtail::Query.run("contacts/#{@contact_id}/#{account_id}/assets", @api_hash, "GET")
      end
    end
  end
end