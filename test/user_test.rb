require 'helper'

class UserTest < Test::Unit::TestCase
  def setup
    setup_redtail
  end
  
  should "be able to fetch UserKey via Basic authentication" do
    user = RubyRedtail::User.new('Basic', @redtail_user_name, @redtail_user_password)
    authentication = user.authentication
    assert_equal("Success", authentication.message)
    assert_equal(41974, authentication.user_id)
    assert_equal(@redtail_user_key, authentication.user_key)
  end
  
  should "be able to fetch user data via Basic authentication" do
    user = RubyRedtail::User.new('Basic', @redtail_user_name, @redtail_user_password)
    assert_nothing_raised(RubyRedtail::AuthenticationError) {taggroups = user.settings.taggroups }
  end
  
  should "be able to fetch user data via UserKey authentication" do
    user = RubyRedtail::User.new('UserKey', @redtail_user_key)
    assert_nothing_raised(RubyRedtail::AuthenticationError) {taggroups = user.settings.taggroups }
  end
  
  should "be able to fetch user data via UserToken authentication" do
    # TODO: We need a user token
    # user = RubyRedtail::User.new('UserToken',@redtail_user_token)
    # assert_nothing_raised(RubyRedtail::AuthenticationError) {taggroups = user.settings.taggroups }
  end
  
  should "be able to fetch user data via Basic authentication block" do
    RubyRedtail::User.authenticate_via_basic(@redtail_user_name, @redtail_user_password) do |user|
      assert_nothing_raised(RubyRedtail::AuthenticationError) {taggroups = user.settings.taggroups }
    end
  end
  
  should "be able to fetch user data via UserKey authentication block" do
    RubyRedtail::User.authenticate_via_user_key(@redtail_user_key) do |user|
      assert_nothing_raised(RubyRedtail::AuthenticationError) {taggroups = user.settings.taggroups }
    end
  end
  
  should "be able to fetch user data via UserToken authentication block" do
    # TODO: We need a user token
    # RubyRedtail::User.authenticate_via_user_token(@redtail_user_token) do |user|
    #   assert_nothing_raised(RubyRedtail::AuthenticationError) {taggroups = user.settings.taggroups }
    # end
  end
  
  should "not be able to fetch user data via faulty Basic authentication" do
    user = RubyRedtail::User.new('Basic', @redtail_user_name, 'hacker_hackity_hack')
    assert_raise(RubyRedtail::AuthenticationError) {taggroups = user.settings.taggroups }
  end
  
  should "not be able to fetch user data via faulty UserKey authentication" do
    user = RubyRedtail::User.new('UserKey', 'hacker_hackity_hack')
    assert_raise(RubyRedtail::AuthenticationError) {taggroups = user.settings.taggroups }
  end
  
  should "not be able to fetch user data via faulty UserToken authentication" do
    user = RubyRedtail::User.new('UserToken', 'hacker_hackity_hack')
    assert_raise(RubyRedtail::AuthenticationError) {taggroups = user.settings.taggroups }
  end
  
end
