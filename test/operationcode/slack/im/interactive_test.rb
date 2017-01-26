require 'test_helper'

class Operationcode::Slack::Im::InteractiveTest < Minitest::Test
  def test_returns_a_payload
    i = Operationcode::Slack::Im::Interactive.new(text: 'interactive message text', id: 'test_id', actions: [{name: 'action1_name', text: 'action1_text', value: 'action1_value'}])
    assert_equal mock_payload, i.payload
  end

  def mock_payload
    [
      {
        text: 'interactive message text',
        fallback: 'interactive message text',
        callback_id: 'test_id',
        color: '#3AA3E3',
        attachment_type: 'default',
        actions:
          [
            {
              name: 'action1_name',
              text: 'action1_text',
              value: 'action1_value',
              style: :default,
              type: :button
            }
          ]
      }
    ]
  end
end
