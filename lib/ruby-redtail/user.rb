require 'ruby-redtail/contacts'
require 'ruby-redtail/addresses'
require 'ruby-redtail/notes'
require 'ruby-redtail/accounts'
require 'ruby-redtail/activities'
require 'ruby-redtail/tag_groups'
require 'ruby-redtail/settings'

module RubyRedtail
  class User
    attr_accessor :api_hash

    def initialize type, *args
      if type == "Basic"
        self.api_hash = "Basic " + Base64.strict_encode64("#{RubyRedtail.config.api_key}:#{args[0]}:#{args[1]}")
      elsif type == "UserKey"
        self.api_hash = "Userkeyauth " + Base64.strict_encode64("#{RubyRedtail.config.api_key}:#{args[0]}")
      elsif type == "UserToken"
        self.api_hash = "UsertokenAuth " + Base64.strict_encode64("#{RubyRedtail.config.api_key}:#{args[0]}")
      else
        raise ArgumentError
      end
    end
    
    def self.authenticate_via_basic(username, password)
      yield self.new('Basic',username,password)
    end
    
    def self.authenticate_via_user_key(key)
      yield self.new('UserKey',key)
    end
    
    def self.authenticate_via_user_token(token)
      yield self.new('UserToken',token)
    end
    
    # def self.method_missing(method_name, *args)
    #   method_array = method_name.to_s.split('_')
    #   if method_array.first == 'authenticate'
    #     type = method_array[2]
    #     type += ('' if type == 'basic') || ('auth' if type == 'userkey') || 'Auth'
    #     yield RubyRedtail::User.new type.to_s.capitalize, *args
    #   else
    #     super
    #   end
    # end
    
    def authentication
      RubyRedtail::Query.run("authentication", self.api_hash, "GET")
    end
	  
	  def sso
      Redtail::Query.run("sso", self.api_hash, "GET")
    end

    def contacts
      RubyRedtail::Contacts.new self.api_hash
    end

    def addresses
      RubyRedtail::Addresses.new self.api_hash
    end

    def notes
      RubyRedtail::Notes.new self.api_hash
    end

    def accounts
      RubyRedtail::Accounts.new self.api_hash
    end

    def activities
      RubyRedtail::Activities.new self.api_hash
    end

    def tag_groups
      RubyRedtail::TagGroups.new self.api_hash
    end

    def settings
      RubyRedtail::Settings.new self.api_hash
    end
  end
end