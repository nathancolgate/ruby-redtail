require 'helper'

class UserContactsTest < Test::Unit::TestCase
  def setup
    setup_redtail
    @user = RubyRedtail::User.new('UserKey',@redtail_user_key)
  end
  
  should "be able to search contacts by name" do
    contacts = @user.contacts.search_by_name('Investor')
    assert_equal(Array, contacts.class)
    assert_equal(RubyRedtail::Contact, contacts.first.class)
    puts contacts.first.inspect
  end
  
end
