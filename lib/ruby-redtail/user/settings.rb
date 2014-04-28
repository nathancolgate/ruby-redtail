require 'ruby-redtail/setting'

module RubyRedtail
  class User
    class Settings

      def initialize api_hash
        @api_hash = api_hash
      end
    
      # Activity Type List Fetch
      # returns a list of activity types with the corresponding Activity Code
      def activitytypes
        build_settings_array RubyRedtail::Query.run("settings/activitytypes", @api_hash, "GET")
      end
    
      # Master Category List Fetch
      # returns a Master Category List with the corresponding MCL Code.
      def mcl
        build_settings_array RubyRedtail::Query.run("settings/mcl", @api_hash, "GET")
      end
    
      # Salutation List Fetch
      # returns a list of Salutations with the corresponding Salutation Code
      def salutations
        build_settings_array RubyRedtail::Query.run("settings/salutations", @api_hash, "GET")
      end
    
      # User-Defined Fields Fetch
      # returns a list of User-defined fields with the corresponding UDF Code.
      def udf
        build_settings_array RubyRedtail::Query.run("settings/udf", @api_hash, "GET")
      end
    
      # Tag Groups Fetch
      # returns a list of Tag Groups for a user's Database.
      def taggroups
        build_settings_array RubyRedtail::Query.run("settings/taggroups", @api_hash, "GET")
      end

      # Contact Status List Fetch
      # returns a list of contact statuses with the corresponding Contact Status Code.
      # optional Parameter: {deleted}*
      # {0} shows current records, {1} shows deleted records
      def csl(deleted=false)
        build_settings_array RubyRedtail::Query.run("settings/csl?deleted=#{deleted ? 1 : 0}", @api_hash, "GET")
      end

      # Contact Category List Fetch
      # returns a list of Contact Categories with the corresponding Contact Category Code
      # optional Parameter: {deleted}*
      # {0} shows current records, {1} shows deleted records
      def mccl(deleted=false)
        build_settings_array RubyRedtail::Query.run("settings/mccl?deleted=#{deleted ? 1 : 0}", @api_hash, "GET")
      end

      # Contact Source List Fetch
      # returns a list of Contact Sources with the corresponding Contact Source Code
      # optional Parameter: {deleted}*
      # {0} shows current records, {1} shows deleted records
      def mcsl(deleted=false)
        build_settings_array RubyRedtail::Query.run("settings/mcsl?deleted=#{deleted ? 1 : 0}", @api_hash, "GET")
      end

      # Servicing Advisor List Fetch
      # returns a list of Servicing Advisors with the corresponding Servicing Advisor Code.
      # optional Parameter: {deleted}*
      # {0} shows current records, {1} shows deleted records
      def sal(deleted=false)
        build_settings_array RubyRedtail::Query.run("settings/sal?deleted=#{deleted ? 1 : 0}", @api_hash, "GET")
      end

      # Writing Advisor List Fetch
      # returns a list of Writing Advisors with the corresponding Writing Advisor Code.
      # optional Parameter: {deleted}*
      # {0} shows current records, {1} shows deleted records
      def wal(deleted=false)
        build_settings_array RubyRedtail::Query.run("settings/wal?deleted=#{deleted ? 1 : 0}", @api_hash, "GET")
      end
      
      protected
      
      def build_setting setting_hash
        RubyRedtail::Setting.new(setting_hash,@api_hash)
      end

      def build_settings_array setting_hashes
        if setting_hashes
          setting_hashes.collect { |setting_hash| self.build_setting setting_hash }
        else
          raise RubyRedtail::AuthenticationError
        end
      end
      
      def build_taggroup taggroup_hash
        RubyRedtail::Taggroup.new(taggroup_hash,@api_hash)
      end

      def build_taggroups_array taggroup_hashes
        if taggroup_hashes
          taggroup_hashes.collect { |taggroup_hash| self.build_taggroup taggroup_hash }
        else
          raise RubyRedtail::AuthenticationError
        end
      end

    end
  end
end