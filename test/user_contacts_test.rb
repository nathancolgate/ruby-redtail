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
  end  
  
  should "be able to search contacts by letter" do
    contacts = @user.contacts.search_by_letter('m')
    assert_equal(Array, contacts.class)
    assert_equal(RubyRedtail::Contact, contacts.first.class)
  end
  
  should "be able to search with that fancy method" do
    clients = @user.contacts.search([
      ['FirstName','=',"Mary"],
      ['LastName','=',"Investor"]
    ])
    assert_equal(Array, clients.class)
    assert_equal(RubyRedtail::Client, clients.first.class)
  end
  
end
