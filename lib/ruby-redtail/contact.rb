module RubyRedtail
  class Contact
    attr_accessor :api_hash

    # http://help.redtailtechnology.com/entries/21654562-authentication-methods
    def initialize(contact = {}, api_hash)
      @api_hash = api_hash
      
      raise ArgumentError if contact.class != Hash
      raise ArgumentError unless contact['ContactID']
      contact.each do |key, value|
        key = key.underscore
        self.class.send :attr_accessor, key
        instance_variable_set "@#{key}", value
      end
    end
    
    
    def addresses
      RubyRedtail::Contact::Addresses.new self.api_hash
    end
    
    def notes
      RubyRedtail::Contact::Notes.new self.api_hash
    end
    
    def accounts
      RubyRedtail::Contact::Accounts.new self.api_hash
    end
    
    def activities
      RubyRedtail::Contact::Activities.new self.api_hash
    end
    
    def tag_groups
      RubyRedtail::Contact::TagGroups.new self.api_hash
    end
    
    # Fetch Contact By Contact Id
    def fetch (recent = false, basic = false)
      if basic
        RubyRedtail::Query.run("contacts/#{self.contact_id}/basic?recent=#{recent ? 1 : 0}", @api_hash, "GET")
      else
        RubyRedtail::Query.run("contacts/#{self.contact_id}?recent=#{recent ? 1 : 0}", @api_hash, "GET")
      end
    end

    # Update Contact
    def update (params)
      RubyRedtail::Query.run("contacts/#{self.contact_id}", @api_hash, 'PUT', params)
    end
  
    # Delete Contact
    def delete
      RubyRedtail::Query.run("contacts/#{self.contact_id}", @api_hash, 'DELETE')['Status'] == 0
    end

    # Master Fetch Contact
    def master_fetch
      RubyRedtail::Query.run("contacts/#{self.contact_id}/master", @api_hash, 'GET')
    end

    # Fetch Contact Details
    def details
      RubyRedtail::Query.run("contacts/#{self.contact_id}/details", @api_hash, "GET")
    end

    # Update Contact Details
    # Is this required? (Deprecated on API website). Ask Client?
    def update_details (params)
      RubyRedtail::Query.run("contacts/#{self.contact_id}/details", @api_hash, 'PUT', params)
    end

    # Fetch Contact Family
    def family
      RubyRedtail::Query.run("contacts/#{self.contact_id}/family", @api_hash, "GET")
    end

    # Fetch Contact Memberships
    def memberships
      RubyRedtail::Query.run("contacts/#{self.contact_id}/memberships", @api_hash, "GET")
    end

    # Fetch Contact Personal Profile
    def personal_profile
      RubyRedtail::Query.run("contacts/#{self.contact_id}/personalprofile", @api_hash, "GET")
    end

    # Update Contact Personal Profile
    def update_personal_profile (personal_profile_id, params)
      RubyRedtail::Query.run("contacts/#{self.contact_id}/personalprofile/#{personal_profile_id}", @api_hash, 'PUT', params)
    end

    # Fetch Contact Important Information
    def inportant_information
      RubyRedtail::Query.run("contacts/#{self.contact_id}/importantinfo", @api_hash, "GET")
    end

    # Update Contact Important Information
    def update_important_information (params)
      RubyRedtail::Query.run("contacts/#{self.contact_id}/importantinfo", @api_hash, 'PUT', params)
    end

    # Fetch Contact Departments
    def departments
      RubyRedtail::Query.run("contacts/#{self.contact_id}/importantinfo", @api_hash, "GET")
    end

    # Fetch User Defined Fields for Contact
    def user_defined_fields
      RubyRedtail::Query.run("contacts/#{self.contact_id}/udf", @api_hash, "GET")
    end

    # Update User Defined Field for Contact
    def update_user_defined_field (udf_id, params)
      RubyRedtail::Query.run("contacts/#{self.contact_id}/udf/#{udf_id}", @api_hash, 'PUT', params)
    end

    # Create User Defined Field for Contact
    def create_user_defined_field (params)
      update_user_defined_field(self.contact_id, 0, params)
    end
  end
end