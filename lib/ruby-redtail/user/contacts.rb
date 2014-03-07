require 'ruby-redtail/contact'

module RubyRedtail
  class User
    class Contacts

      CONTACT_SEARCH_FIELDS = ['LastUpdate','Name','RecAdd','PhoneNumber','Tag_Group','FirstName','LastName','FamilyName','FamilyHead','ClientStatus','ContactType','ClientSource','TaxId']
      CONTACT_SEARCH_OPERANDS = ['=','>','<','!=','Like','BeginsWith','IsEmpty']

      def initialize(api_hash)
        @api_hash = api_hash
      end

      # Contact Search by Name Fetch
      # returns a paged list of Contacts, associated with the search value. 
      # The searched value is based on a contact's or contacts' name.
      # http://help.redtailtechnology.com/entries/21937828-contacts-search-contacts-search#Get
      def search_by_name (value, page = 1)
        build_contacts_array RubyRedtail::Query.run("contacts/search?value=#{value}&page=#{page}", @api_hash, "GET")["Contacts"]
      end

      # TODO: Test this properly
      # Search Contact by Custom Query
      def search (query, page = 1)
        body = Array.new(query.length) { {} }
        query.each_with_index do |expr, i|
          body[i]["Field"] = CONTACT_SEARCH_FIELDS.index expr[0]
          body[i]["Operand"] = CONTACT_SEARCH_OPERANDS.index expr[1]
          body[i]["Value"] = expr[2]
        end
        build_contacts_array RubyRedtail::Query.run("contacts/search?page=#{page}", @api_hash, "POST", body)
      end
      
      # Create New Contact
      def create (params)
        update(0, params)
      end
      
      protected
      
      def build_contact contact_hash
        RubyRedtail::Contact.new(contact_hash,@api_hash)
      end

      def build_contacts_array contact_hashes
        contact_hashes.collect { |contact| self.build_contact contact }
      end


    end
  end
end