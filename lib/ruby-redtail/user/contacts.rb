require 'ruby-redtail/contact'
require 'ruby-redtail/client'

module RubyRedtail
  class User
    class Contacts

      CONTACT_SEARCH_FIELDS = ['LastUpdate','Name','RecAdd','PhoneNumber','Tag_Group','FirstName','LastName','FamilyName','FamilyHead','ClientStatus','ContactType','ClientSource','TaxId']
      CONTACT_SEARCH_OPERANDS = ['=','>','<','!=','Like','BeginsWith','IsEmpty']

      def initialize(api_hash)
        @api_hash = api_hash
      end

      # Contact Search by Name Fetch
      # returns a paged list of limited Contact Information, including the ContactID
      # *value = searched name
      # *page = pagination
      # http://help.redtailtechnology.com/entries/21937828-contacts-search-contacts-search
      def search_by_name (value, page = 1)
        build_contacts_array RubyRedtail::Query.run("contacts/search?value=#{value}&page=#{page}", @api_hash, "GET")["Contacts"]
      end
      
      # Contact Search by Letter Fetch
      # returns a paged list of limited Contact Information, including the ContactID, 
      # based on a partial name or a single character.
      # *value = searched beginning letter(s)
      # *page = pagination
      # http://help.redtailtechnology.com/entries/21937828-contacts-search-contacts-search
      def search_by_letter (value, page = 1)
        build_contacts_array RubyRedtail::Query.run("contacts/search/beginswith?value=#{value}&page=#{page}", @api_hash, "GET")["Contacts"]
      end

      # TODO: Test this properly
      # Search Contact by Custom Query
      # returns a paged list of Basic Contact Information, including the ContactID, 
      # based on the specified field, operand, and field value. 
      # http://help.redtailtechnology.com/entries/22550401
      def search (query, page = 1)
        body = Array.new(query.length) { {} }
        query.each_with_index do |expr, i|
          body[i]["Field"] = CONTACT_SEARCH_FIELDS.index(expr[0]).to_s
          body[i]["Operand"] = CONTACT_SEARCH_OPERANDS.index(expr[1]).to_s
          body[i]["Value"] = expr[2]
        end
        build_clients_array RubyRedtail::Query.run("contacts/search?page=#{page}", @api_hash, "POST", body)["Contacts"]
      end
      
      # Create New Contact
      def create (params)
        update(0, params)
      end
      
      protected
      
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
      
      def build_client client_hash
        if client_hash
          RubyRedtail::Client.new(client_hash,@api_hash)
        else
          raise RubyRedtail::AuthenticationError
        end
      end

      def build_clients_array client_hashes
        if client_hashes
          client_hashes.collect { |client_hash| self.build_client client_hash }
        else
          raise RubyRedtail::AuthenticationError
        end
      end


    end
  end
end