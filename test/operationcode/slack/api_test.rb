require 'test_helper'

class Operationcode::Slack::ApiTest < Minitest::Test
  def test_it_raises_if_not_given_a_url
    assert_raises(ArgumentError){ Operationcode::Slack::Api.post }
  end

  def test_it_can_invite_to_a_channel
    test_data = { test_key: 'test_value' }
    HTTParty.expects(:post).with('https://slack.com/api/channels.invite', body: test_data)
    Operationcode::Slack::Api::ChannelsInvite.post with_data: test_data
  end

  def test_it_can_do_o_auth
    ENV.stubs(:fetch).with('SLACK_CLIENT_ID').returns('TEST_ID')
    ENV.stubs(:fetch).with('SLACK_CLIENT_SECRET').returns('TEST_SECRET')
    HTTParty.expects(:post).with('https://slack.com/api/oauth.access', body: { client_id: 'TEST_ID', client_secret: 'TEST_SECRET', code: '1234' })
    Operationcode::Slack::Api::OauthAccess.post with_data: { code: '1234' }
  end

  def test_it_can_fetch_user_data
    test_data = { test_key: 'test_value' }
    HTTParty.expects(:post).with('https://slack.com/api/users.info', body: test_data)
    Operationcode::Slack::Api::UsersInfo.post with_data: test_data
  end

  def test_it_can_open_an_im
    test_data = { test_key: 'test_value' }
    HTTParty.expects(:post).with('https://slack.com/api/im.open', body: test_data)
    Operationcode::Slack::Api::ImOpen.post with_data: test_data
  end

  def test_it_can_send_a_message
    test_data = { test_key: 'test_value' }
    HTTParty.expects(:post).with('https://slack.com/api/chat.postMessage', body: test_data)
    Operationcode::Slack::Api::ChatPostMessage.post with_data: test_data
  end
end
