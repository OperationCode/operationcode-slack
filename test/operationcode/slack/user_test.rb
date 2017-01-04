require 'test_helper'

class Operationcode::Slack::UserTest < Minitest::Test
  def test_can_be_instantiated
    user = Operationcode::Slack::User.new({id: 'fakeid', name: 'fakename' })
    assert_instance_of Operationcode::Slack::User, user
  end

  def test_can_be_passed_a_hash_or_string
    Operationcode::Slack::Api::UsersInfo.expects(:post)
      .with(with_data: { user: 'JUST_A_USER_ID' }).once
      .returns({ 'ok' => 'true', 'user' => { 'real_name' => 'RETURNED_NAME' } })

    user = Operationcode::Slack::User.new({ 'id' => 'FAKE_ID', 'name' => 'FAKE_NAME' })
    assert_equal 'FAKE_ID', user.id
    assert_equal 'FAKE_NAME', user.name

    user = Operationcode::Slack::User.new('JUST_A_USER_ID')
    assert_equal 'JUST_A_USER_ID', user.id
    assert_equal 'RETURNED_NAME', user.name
  end
end
