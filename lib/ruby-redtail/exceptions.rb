module RubyRedtail
  class Error < StandardError; end
  class AuthenticationError < Error; end
  class InvalidURIError < Error; end
  class AccessKeyError < Error; end
end