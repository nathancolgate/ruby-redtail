module RubyRedtail
  class Contacts

    CONTACT_SEARCH_FIELDS = ['LastUpdate','Name','RecAdd','PhoneNumber','Tag_Group','FirstName','LastName','FamilyName','FamilyHead','ClientStatus','ContactType','ClientSource','TaxId']
    CONTACT_SEARCH_OPERANDS = ['=','>','<','!=','Like','BeginsWith','IsEmpty']

    def initialize(api_hash)
      @api_hash = api_hash
    end

    # Search Contact By Name or Part of Name
    def search_by_name (value, page = 1)
      RubyRedtail::Query.run("contacts/search?value=#{value}&page=#{page}", @api_hash, "GET")["Contacts"]
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
      RubyRedtail::Query.run("contacts/search?page=#{page}", @api_hash, "POST", body)
    end

    # Fetch Contact By Contact Id
    def fetch (contact_id, recent = false, basic = false)
      if basic
        RubyRedtail::Query.run("contacts/#{contact_id}/basic?recent=#{recent ? 1 : 0}", @api_hash, "GET")
      else
        RubyRedtail::Query.run("contacts/#{contact_id}?recent=#{recent ? 1 : 0}", @api_hash, "GET")
      end
    end

    # Update Contact
    def update (contact_id, params)
      RubyRedtail::Query.run("contacts/#{contact_id}", @api_hash, 'PUT', params)
    end

    # Create New Contact
    def create (params)
      update(0, params)
    end

    # Delete Contact
    def delete (contact_id)
      RubyRedtail::Query.run("contacts/#{contact_id}", @api_hash, 'DELETE')['Status'] == 0
    end

    # Master Fetch Contact
    def master_fetch (contact_id)
      RubyRedtail::Query.run("contacts/#{contact_id}/master", @api_hash, 'GET')
    end

    # Fetch Contact Details
    def details (contact_id)
      RubyRedtail::Query.run("contacts/#{contact_id}/details", @api_hash, "GET")
    end

    # Update Contact Details
    # Is this required? (Deprecated on API website). Ask Client?
    def update_details (contact_id, params)
      RubyRedtail::Query.run("contacts/#{contact_id}/details", @api_hash, 'PUT', params)
    end

    # Fetch Contact Family
    def family (contact_id)
      RubyRedtail::Query.run("contacts/#{contact_id}/family", @api_hash, "GET")
    end

    # Fetch Contact Memberships
    def memberships (contact_id)
      RubyRedtail::Query.run("contacts/#{contact_id}/memberships", @api_hash, "GET")
    end

    # Fetch Contact Personal Profile
    def personal_profile (contact_id)
      RubyRedtail::Query.run("contacts/#{contact_id}/personalprofile", @api_hash, "GET")
    end

    # Update Contact Personal Profile
    def update_personal_profile (contact_id, personal_profile_id, params)
      RubyRedtail::Query.run("contacts/#{contact_id}/personalprofile/#{personal_profile_id}", @api_hash, 'PUT', params)
    end

    # Fetch Contact Important Information
    def inportant_information (contact_id)
      RubyRedtail::Query.run("contacts/#{contact_id}/importantinfo", @api_hash, "GET")
    end

    # Update Contact Important Information
    def update_important_information (contact_id, params)
      RubyRedtail::Query.run("contacts/#{contact_id}/importantinfo", @api_hash, 'PUT', params)
    end

    # Fetch Contact Departments
    def departments (contact_id)
      RubyRedtail::Query.run("contacts/#{contact_id}/importantinfo", @api_hash, "GET")
    end

    # Fetch User Defined Fields for Contact
    def user_defined_fields (contact_id)
      RubyRedtail::Query.run("contacts/#{contact_id}/udf", @api_hash, "GET")
    end

    # Update User Defined Field for Contact
    def update_user_defined_field (contact_id, udf_id, params)
      RubyRedtail::Query.run("contacts/#{contact_id}/udf/#{udf_id}", @api_hash, 'PUT', params)
    end

    # Create User Defined Field for Contact
    def create_user_defined_field (contact_id, params)
      update_user_defined_field(contact_id, 0, params)
    end
  end
end