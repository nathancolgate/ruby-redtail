module RubyRedtail
  class Query
    # TODO: Refactor (Lots of repetition)
    def self.run (uri, auth_hash, method, request_body = nil)
      base_uri = RubyRedtail.config.api_uri
      if method == "GET"
        @response = HTTParty.get(base_uri + uri, :headers => {"Authorization" => auth_hash, 'Content-Type' => 'text/json'}).parsed_response
      elsif method == "POST"
        @response = HTTParty.post(base_uri + uri, :headers => {"Authorization" => auth_hash, 'Content-Type' => 'text/json'}, :body => request_body.to_json).parsed_response
      elsif method == "PUT"
        @response = HTTParty.put(base_uri + uri, :headers => {"Authorization" => auth_hash, 'Content-Type' => 'text/json'}, :body => request_body.to_json).parsed_response
      elsif method == "DELETE"
        @response = HTTParty.post(base_uri + uri, :headers => {"Authorization" => auth_hash, 'Content-Type' => 'text/json'}, :body => "").parsed_response
      end

      return @response
    end
  end
end

