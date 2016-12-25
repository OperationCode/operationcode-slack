module Operationcode
  module Slack
    class Im
      def initialize(user:)
        @user = user
      end

      def deliver(text)
        Operationcode::Slack::Api::ChatPostMessage.post with_data: api_params.merge({ text: text })
      end

      def api_params
        {
          token: ENV.fetch('SLACK_TOKEN'),
          channel: @user,
          as_user: false,
          username: 'OperationCodeBot'
        }
      end
    end
  end
end
