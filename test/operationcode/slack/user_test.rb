require 'test_helper'

class Operationcode::Slack::UserTest < Minitest::Test
  def test_can_be_instantiated
    user = Operationcode::Slack::User.new('some data')
    assert_instance_of Operationcode::Slack::User, user
  end

  def test_can_be_passed_a_hash_or_string
    user = Operationcode::Slack::User.new({ 'id' => 'FAKE_ID', 'name' => 'FAKE_NAME' })
    assert_equal 'FAKE_ID', user.id
    assert_equal 'FAKE_NAME', user.name

    user = Operationcode::Slack::User.new('JUST_A_USER_ID')
    assert_equal 'JUST_A_USER_ID', user.id
    assert_nil user.name
  end
end
