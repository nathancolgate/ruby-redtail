require 'helper'

class UserTest < Test::Unit::TestCase
  
  should "be able to fetch UserKey via Basic authentication" do
    user = RubyRedtail::User.new('Basic', @redtail_user_name, @redtail_user_password)
    authentication = user.authentication
    assert_equal("Success", authentication["Message"])
    assert_equal(41974, authentication["UserID"])
    assert_equal(@redtail_user_key, authentication["UserKey"])
  end
  
  should "be able to fetch user data via Basic authentication" do
    user = RubyRedtail::User.new('Basic', @redtail_user_name, @redtail_user_password)
    tag_groups = user.settings.tag_groups
    assert_equal(Array, tag_groups.class)
  end
  
  should "be able to fetch user data via UserKey authentication" do
    user = RubyRedtail::User.new('UserKey', @redtail_user_key)
    tag_groups = user.settings.tag_groups
    assert_equal(Array, tag_groups.class)
  end
  
  should "be able to fetch user data via UserToken authentication" do
    # TODO: We need a user token
    # user = RubyRedtail::User.new('UserToken',@redtail_user_token)
    # tag_groups = user.settings.tag_groups
    # assert_equal(Array,tag_groups.class)
  end
  
  should "be able to fetch user data via Basic authentication block" do
    RubyRedtail::User.authenticate_via_basic(@redtail_user_name, @redtail_user_password) do |user|
      tag_groups = user.settings.tag_groups
      assert_equal(Array, tag_groups.class)
    end
  end
  
  should "be able to fetch user data via UserKey authentication block" do
    RubyRedtail::User.authenticate_via_user_key(@redtail_user_key) do |user|
      tag_groups = user.settings.tag_groups
      assert_equal(Array, tag_groups.class)
    end
  end
  
  should "be able to fetch user data via UserToken authentication block" do
    # TODO: We need a user token
    # RubyRedtail::User.authenticate_via_user_token(@redtail_user_token) do |user|
    #   tag_groups = user.settings.tag_groups
    #   assert_equal(Array,tag_groups.class)
    # end
  end
  
  should "not be able to fetch user data via faulty Basic authentication" do
    user = RubyRedtail::User.new('Basic', @redtail_user_name, 'hacker_hackity_hack')
    tag_groups = user.settings.tag_groups
    assert_equal(nil, tag_groups)
  end
  
  should "not be able to fetch user data via faulty UserKey authentication" do
    user = RubyRedtail::User.new('UserKey', 'hacker_hackity_hack')
    tag_groups = user.settings.tag_groups
    assert_equal(nil, tag_groups)
  end
  
  should "not be able to fetch user data via faulty UserToken authentication" do
    user = RubyRedtail::User.new('UserToken', 'hacker_hackity_hack')
    tag_groups = user.settings.tag_groups
    assert_equal(nil, tag_groups)
  end
  
end
