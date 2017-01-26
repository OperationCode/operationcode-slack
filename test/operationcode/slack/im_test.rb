require 'test_helper'

class Operationcode::Slack::ImTest < Minitest::Test
  def test_can_be_instantiated
    im = Operationcode::Slack::Im.new(user: 'test_user_id')
    assert_instance_of Operationcode::Slack::Im, im
  end

  def test_can_im_a_user
    HTTParty.expects(:post).once.with(
      'https://slack.com/api/im.open',
       body: { token: 'mock_token', user: 'TEST_USER_ID' }
    ).returns(mock_post_message_response)

    HTTParty.expects(:post).once.with(
      'https://slack.com/api/chat.postMessage',
       body: { token: 'mock_token', 'channel' =>  mock_im_open_response['channel']['id'], text: 'this is a test message', as_user: false, username: 'operationcodebot' }
    )

    im = Operationcode::Slack::Im.new(user: 'TEST_USER_ID')
    im.deliver('this is a test message')
  end

  def test_can_provide_a_channel_to_use
    HTTParty.expects(:post).never.with(
      'https://slack.com/api/im.open',
       body: { token: 'mock_token', user: 'TEST_USER_ID' }
    )

    HTTParty.expects(:post).once.with(
      'https://slack.com/api/chat.postMessage',
       body: { token: 'mock_token', 'channel' => 'SPECIFIED_CHAN', text: 'this is a test message', as_user: false, username: 'operationcodebot' }
    )

    im = Operationcode::Slack::Im.new(user: 'TEST_USER_ID', channel: 'SPECIFIED_CHAN')
    im.deliver('this is a test message')
  end

  def test_must_pass_user_or_channel
    Operationcode::Slack::Im.new(user: 'TEST_USER')
    Operationcode::Slack::Im.new(channel: 'TEST_CHAN')
    assert_raises { Operationcode::Slack::Im.new }
  end

  def test_can_be_made_interactive
    im  = Operationcode::Slack::Im.new(user: 'TEST_USER', text: 'regular message text')
    interactive_im = Operationcode::Slack::Im::Interactive.new(text: 'interactive message text', id: 'test_id', actions: [{name: 'action1_name', text: 'action1_text', value: 'action1_value'}])

    im.make_interactive_with! interactive_im

    assert_equal mock_interactive_message, im.payload

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

  def mock_interactive_message
    {:token=>"mock_token", :as_user=>false, :username=>"operationcodebot", "channel"=>nil, "attachments"=>"#{mock_interactive_message_attachments}"}
  end

  def mock_interactive_message_attachments
    '[' +
      '{' +
      '"text":"interactive message text",' +
      '"fallback":"interactive message text",' +
      '"callback_id":"test_id",' +
      '"color":"#3AA3E3",' +
      '"attachment_type":"default",' +
      '"actions":' +
        '[' +
          '{' +
            '"name":"action1_name",' +
            '"text":"action1_text",' +
            '"value":"action1_value",' +
            '"style":"default",' +
            '"type":"button"' +
          '}' +
        ']' +
      '}' +
    ']'
  end
end
