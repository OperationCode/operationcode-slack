require 'test_helper'

class Operationcode::SlackTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Operationcode::Slack::VERSION
  end
end
