module RubyRedtail
  class Activities

    def initialize api_hash
      @api_hash = api_hash
    end

    # Fetch Activity By User Id, Start Date and End Date
    def fetch_by_user (user_id, start_date, end_date, basic = true, page = 1)
      RubyRedtail::Query.run("calendar/#{user_id}#{"/basic" if basic}?startdate=#{start_date}&enddate=#{end_date}&page=#{page}", @api_hash, "GET")
    end

    # Fetch Activity By Activity Id
    def fetch (activity_id)
      RubyRedtail::Query.run("calendar/activities/#{activity_id}", @api_hash, "GET")
    end

    # Update Activity
    def update(activity_id, params)
      RubyRedtail::Query.run("calendar/activities/#{activity_id}", @api_hash, 'PUT', params)
    end

    # Create new Activity
    def create(params)
      update(0, params)
    end

    # Mark Activity as Complete
    def mark_complete(activity_id)
      RubyRedtail::Query.run("calendar/activities/#{activity_id}/complete", @api_hash, "PUT")
    end

    # Fetch List of Recent Activities
    def recent(start_date, page = 1)
      RubyRedtail::Query.run("calendar/activities/recent?startdate=#{start_date}&page=#{page}", @api_hash, "GET")
    end

    # Fetch Activities By Contact Id
    def fetch_by_contact (contact_id, start_date, end_date, basic = true, page = 1)
      RubyRedtail::Query.run("contacts/#{contact_id}/activities#{"/basic" if basic}?startdate=#{start_date}&enddate=#{end_date}&page=#{page}", @api_hash, "GET")
    end

  end
end