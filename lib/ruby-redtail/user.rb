# require 'ruby-redtail/addresses'
# require 'ruby-redtail/notes'
# require 'ruby-redtail/accounts'
# require 'ruby-redtail/activities'
# require 'ruby-redtail/tag_groups'
require 'ruby-redtail/user/contacts'
require 'ruby-redtail/user/settings'
require 'ruby-redtail/authentication'
require 'ruby-redtail/sso'

module RubyRedtail
  class User
    attr_accessor :api_hash

    # http://help.redtailtechnology.com/entries/21654562-authentication-methods
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
    
    # UserKey Retrieval
    # http://help.redtailtechnology.com/entries/22621068
    # returns a UserKey in exchange for the Username and Password specified in the Authentication.
	  def user_key
	    authentication.user_key
	  end
    def authentication
      RubyRedtail::Authentication.new(RubyRedtail::Query.run("authentication", self.api_hash, "GET"))
    end
	  
    # Single Sign-On
    # http://help.redtailtechnology.com/entries/22602246
    # returns a URL for Single Sign-On based on the specified endpoint.
    # TODO: pass endpoint and id parameters
    def sso_return_url
      sso.return_url
    end
	  def sso
      RubyRedtail::Sso.new(RubyRedtail::Query.run("sso", self.api_hash, "GET"))
    end

    def contacts
      RubyRedtail::User::Contacts.new self.api_hash
    end

    def settings
      RubyRedtail::User::Settings.new self.api_hash
    end
  end
end