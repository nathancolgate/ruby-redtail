require 'helper'

class ContactTest < Test::Unit::TestCase
  def setup
    setup_redtail
    @user = RubyRedtail::User.new('UserKey',@redtail_user_key)
    @contact = RubyRedtail::Contact.new({"ContactID" => @redtail_contact_id},@user.api_hash)
  end
  
  should "be able to fetch client details" do
    assert_equal(Hash, @contact.fetch.class)
  end
  
  should "be able to fetch basic client details" do
    assert_equal(Hash, @contact.fetch_basic.class)
  end
  
  should "be able to fetch master client details" do
    assert_equal(Hash, @contact.fetch_master.class)
  end
  


  
end
