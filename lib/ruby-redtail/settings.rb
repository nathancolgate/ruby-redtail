module RubyRedtail
  class Settings
    METHODS = {:activity_types => 'activitytypes', :master_categories => 'mcl', :salutations => 'salutations', :user_defined_fields => 'udf', :tag_groups => 'taggroups'}
    METHODS_WITH_DELETE = {:contact_statuses => 'csl', :contact_categories => 'mccl', :contact_sources => 'mcsl', :servicing_advisors => 'sal', :writing_advisors => 'wal'}

    def initialize api_hash
      @api_hash = api_hash
    end

    METHODS.each do |name, uri|
      define_method(name) { RubyRedtail::Query.run("settings/#{uri}", @api_hash, "GET") }
    end

    METHODS_WITH_DELETE.each do |name, uri|
      define_method(name) { |deleted=false| RubyRedtail::Query.run("settings/#{uri}?deleted=#{deleted ? 1 : 0}", @api_hash, "GET")}
    end

  end
end