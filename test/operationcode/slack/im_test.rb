require 'test_helper'

class Operationcode::Slack::ImTest < Minitest::Test
  def test_can_be_instantiated
    im = Operationcode::Slack::Im.new(user: 'test_user_id')
    assert_instance_of Operationcode::Slack::Im, im
  end

  def test_can_im_a_user
    ENV.stubs(:fetch).returns('mock_token')
    HTTParty.expects(:post).once.with(
      'https://slack.com/api/im.open',
       body: { token: 'mock_token', user: 'TEST_USER_ID' }
    ).returns(mock_post_message_response)

    HTTParty.expects(:post).once.with(
      'https://slack.com/api/chat.postMessage',
       body: { token: 'mock_token', channel: mock_im_open_response['channel']['id'], text: 'this is a test message', as_user: false, username: 'operationcodebot' }
    )

    im = Operationcode::Slack::Im.new(user: 'TEST_USER_ID')
    im.deliver('this is a test message')
  end

  def test_can_provide_a_channel_to_use
    ENV.stubs(:fetch).returns('mock_token')

    HTTParty.expects(:post).never.with(
      'https://slack.com/api/im.open',
       body: { token: 'mock_token', user: 'TEST_USER_ID' }
    )

    HTTParty.expects(:post).once.with(
      'https://slack.com/api/chat.postMessage',
       body: { token: 'mock_token', channel: 'SPECIFIED_CHAN', text: 'this is a test message', as_user: false, username: 'operationcodebot' }
    )

    im = Operationcode::Slack::Im.new(user: 'TEST_USER_ID', channel: 'SPECIFIED_CHAN')
    im.deliver('this is a test message')
  end

  def mock_im_open_response
    {
      'ok' => true,
      'no_op' => true,
      'already_open'=> true,
      'channel'=> {
        'id' => 'D024BFF1M'
      }
    }
  end

  def mock_post_message_response
    {
      'ok' => true,
      'ts' => '1405895017.000506',
      'channel' => { 'id' => 'D024BFF1M' },
      'message' => { 'text' => 'this is a test message' }
    }
  end
end
