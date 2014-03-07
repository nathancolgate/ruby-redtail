require "base64"
require 'httparty'

require 'ruby-redtail/version'
require 'ruby-redtail/user'
require 'ruby-redtail/exceptions'
require 'ruby-redtail/query'

module RubyRedtail
  class << self
    attr_accessor :config
  end

  def self.configure
    self.config ||= Configuration.new
    yield config
    raise RubyRedtail::InvalidURIError if (config.api_uri =~ URI::regexp).nil?
    raise RubyRedtail::AccessKeyError if (config.api_key.empty? || config.secret_key.empty?)
    config.api_uri << '/' unless config.api_uri[-1, 1] == '/'
  end

  def self.method_missing(method_name, *args)
    method_array = method_name.to_s.split('_')
    if method_array.first == 'authenticate'
      type = method_array[2]
      type += ('' if type == 'basic') || ('auth' if type == 'userkey') || 'Auth'
      yield RubyRedtail::User.new type.to_s.capitalize, *args
    else
      super
    end
  end

  class Configuration
    attr_accessor :api_key
    attr_accessor :api_uri
    attr_accessor :secret_key
  end
end