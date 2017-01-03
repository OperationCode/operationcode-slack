module Operationcode
  module Slack
    class Im
      def initialize(user:)
        @user = user
      end

      def deliver(text)
        im = Operationcode::Slack::Api::ImOpen.post(with_data: { token: ENV.fetch('SLACK_TOKEN'), user: @user })
        Operationcode::Slack::Api::ChatPostMessage.post with_data: api_params.merge({ channel: im['channel']['id'], text: text })
      end

      def api_params
        {
          token: ENV.fetch('SLACK_TOKEN'),
          as_user: true,
          username: 'OperationCodeBot'
        }
      end
    end
  end
end
