require 'helper'

class UserSettingsTest < Test::Unit::TestCase
  def setup
    setup_redtail
    @user = RubyRedtail::User.new('UserKey',@redtail_user_key)
  end
  
  should "be able to fetch user activitytypes" do
    activitytypes = @user.settings.activitytypes
    assert_equal(Array, activitytypes.class)
    assert_equal(RubyRedtail::Setting, activitytypes.first.class)
  end
  
  should "be able to fetch user mcl" do
    mcl = @user.settings.mcl
    assert_equal(Array, mcl.class)
    assert_equal(RubyRedtail::Setting, mcl.first.class)
  end
  
  should "be able to fetch user salutations" do
    salutations = @user.settings.salutations
    assert_equal(Array, salutations.class)
    assert_equal(RubyRedtail::Setting, salutations.first.class)
  end
  
  should "be able to fetch user udf" do
    udf = @user.settings.udf
    assert_equal(Array, udf.class)
    assert_equal(RubyRedtail::Setting, udf.first.class)
  end
  
  should "be able to fetch user tag groups" do
    tag_groups = @user.settings.tag_groups
    assert_equal(Array, tag_groups.class)
    assert_equal(RubyRedtail::TagGroup, tag_groups.first.class)
  end
  
  should "be able to fetch user csl" do
    csl = @user.settings.csl
    assert_equal(Array, csl.class)
    assert_equal(RubyRedtail::Setting, csl.first.class)
  end
  
  should "be able to fetch user mccl" do
    mccl = @user.settings.mccl
    assert_equal(Array, mccl.class)
    assert_equal(RubyRedtail::Setting, mccl.first.class)
  end
  
  should "be able to fetch user mcsl" do
    mcsl = @user.settings.mcsl
    assert_equal(Array, mcsl.class)
    assert_equal(RubyRedtail::Setting, mcsl.first.class)
  end
  
  should "be able to fetch user sal" do
    sal = @user.settings.sal
    assert_equal(Array, sal.class)
    assert_equal(RubyRedtail::Setting, sal.first.class)
  end
  
  should "be able to fetch user wal" do
    wal = @user.settings.wal
    assert_equal(Array, wal.class)
    assert_equal(RubyRedtail::Setting, wal.first.class)
  end

  
end
