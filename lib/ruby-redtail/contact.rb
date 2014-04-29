# require 'ruby-redtail/contact/tag_groups'
# require 'ruby-redtail/contact/notes'
# require 'ruby-redtail/contact/accounts'
# require 'ruby-redtail/contact/activities'
# require 'ruby-redtail/contact/addresses'

module RubyRedtail
  class Contact
    attr_accessor :api_hash, :id

    # http://help.redtailtechnology.com/entries/21654562-authentication-methods
    def initialize(contact = {}, api_hash)
      @api_hash = api_hash
      
      raise ArgumentError unless contact['ContactID']
      @id = contact['ContactID']
      
      raise ArgumentError if contact.class != Hash
      contact.each do |key, value|
        key = key.underscore
        self.class.send :attr_accessor, key
        instance_variable_set "@#{key}", value
      end
    end
    
    
    # def addresses
    #   RubyRedtail::Contact::Addresses.new @api_hash
    # end
    # 
    # def notes
    #   RubyRedtail::Contact::Notes.new @api_hash
    # end
    # 
    # def accounts
    #   RubyRedtail::Contact::Accounts.new @api_hash
    # end
    # 
    # def activities
    #   RubyRedtail::Contact::Activities.new @api_hash
    # end
    
    def tag_groups
      build_tag_groups_array RubyRedtail::Query.run("contacts/#{@contact_id}/taggroups", @api_hash, "GET")
    end
    
    # Fetch Contact By Contact Id
    # Optional parameter: ?recent={recent}*
    # * {0} does nothing
    # * {1} updates recently viewed
    def fetch (recent = false, basic = false)
      RubyRedtail::Query.run("contacts/#{@id}?recent=#{recent ? 1 : 0}", @api_hash, "GET")
    end
    
    # Fetch Basic Contact By Contact Id
    # Optional parameter: ?recent={recent}*
    # * {0} does nothing
    # * {1} updates recently viewed
    def fetch_basic (recent = false, basic = false)
      RubyRedtail::Query.run("contacts/#{@id}/basic?recent=#{recent ? 1 : 0}", @api_hash, "GET")
    end

    # Master Fetch Contact
    # http://help.redtailtechnology.com/entries/22846682-master-fetch-contacts-contactid-master
    def fetch_master
      RubyRedtail::Query.run("contacts/#{@id}/master", @api_hash, 'GET')
    end

    # Update Contact
    def update (params)
      RubyRedtail::Query.run("contacts/#{@id}", @api_hash, 'PUT', params)
    end
  
    # Delete Contact
    def delete
      RubyRedtail::Query.run("contacts/#{@id}", @api_hash, 'DELETE')['Status'] == 0
    end

    # Fetch Contact Details
    def details
      RubyRedtail::Query.run("contacts/#{@id}/details", @api_hash, "GET")
    end

    # Update Contact Details
    # Is this required? (Deprecated on API website). Ask Client?
    def update_details (params)
      RubyRedtail::Query.run("contacts/#{@id}/details", @api_hash, 'PUT', params)
    end

    # Fetch Contact Family
    def family
      RubyRedtail::Query.run("contacts/#{@id}/family", @api_hash, "GET")
    end

    # Fetch Contact Memberships
    def memberships
      RubyRedtail::Query.run("contacts/#{@id}/memberships", @api_hash, "GET")
    end

    # Fetch Contact Personal Profile
    def personal_profile
      RubyRedtail::Query.run("contacts/#{@id}/personalprofile", @api_hash, "GET")
    end

    # Update Contact Personal Profile
    def update_personal_profile (personal_profile_id, params)
      RubyRedtail::Query.run("contacts/#{@id}/personalprofile/#{personal_profile_id}", @api_hash, 'PUT', params)
    end

    # Fetch Contact Important Information
    def inportant_information
      RubyRedtail::Query.run("contacts/#{@id}/importantinfo", @api_hash, "GET")
    end

    # Update Contact Important Information
    def update_important_information (params)
      RubyRedtail::Query.run("contacts/#{@id}/importantinfo", @api_hash, 'PUT', params)
    end

    # Fetch Contact Departments
    def departments
      RubyRedtail::Query.run("contacts/#{@id}/importantinfo", @api_hash, "GET")
    end

    # Fetch User Defined Fields for Contact
    def user_defined_fields
      RubyRedtail::Query.run("contacts/#{@id}/udf", @api_hash, "GET")
    end

    # Update User Defined Field for Contact
    def update_user_defined_field (udf_id, params)
      RubyRedtail::Query.run("contacts/#{@id}/udf/#{udf_id}", @api_hash, 'PUT', params)
    end

    # Create User Defined Field for Contact
    def create_user_defined_field (params)
      update_user_defined_field(@id, 0, params)
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