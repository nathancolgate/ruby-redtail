require 'redtail/contacts'
require 'redtail/addresses'
require 'redtail/notes'
require 'redtail/accounts'
require 'redtail/activities'
require 'redtail/tag_groups'
require 'redtail/settings'

module RubyRedtail
  class User
    attr_accessor :username
    attr_accessor :password
    attr_accessor :user_key
    attr_accessor :user_token
    attr_accessor :api_hash

    def initialize type, *args
      if type == "Basic"
        self.username = args[0]
        self.password = args[1]
        self.api_hash = Base64.strict_encode64("#{RubyRedtail.config.api_key}:#{self.username}:#{self.password}")
      elsif type == "Userkeyauth"
        self.user_key = args[0]
        self.api_hash = Base64.strict_encode64("#{RubyRedtail.config.api_key}:#{self.user_key}")
      elsif type == "UsertokenAuth"
        self.user_token = args[0]
        self.api_hash = Base64.strict_encode64("#{RubyRedtail.config.api_key}:#{self.user_token}")
      else
        raise ArgumentError
      end

      self.api_hash = type + " " + self.api_hash
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