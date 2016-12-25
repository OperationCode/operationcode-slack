require 'test_helper'

class Operationcode::Slack::ImTest < Minitest::Test
  def test_can_be_instantiated
    im = Operationcode::Slack::Im.new(user: 'test_user_id')
    assert_instance_of Operationcode::Slack::Im, im
  end

  def test_can_im_a_user
    ENV.stubs(:fetch).returns('mock_token')
    HTTParty.expects(:post).twice.with(
      'https://slack.com/api/chat.postMessage',
       body: { token: 'mock_token', channel: '@test_user_name', text: 'this is a test message', as_user: false, username: 'OperationCodeBot' }
    )

    im = Operationcode::Slack::Im.new(user: '@test_user_name')
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
      'channel' => 'D024BFF1M',
      'message' => { 'text' => 'this is a test message' }
    }
  end
end
