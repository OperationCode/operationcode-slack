module Operationcode
  module Slack
    class Im
      def initialize(user:, channel: nil)
        @user = user
        @channel = channel
      end

      def deliver(text)
        resolve_channel!
        Operationcode::Slack::Api::ChatPostMessage.post with_data: api_params.merge({ channel: @channel, text: text })
      end

      private

      def resolve_channel!
        if @channel.nil?
          im = Operationcode::Slack::Api::ImOpen.post(with_data: { token: ENV.fetch('SLACK_TOKEN'), user: @user })
          @channel = im['channel']['id']
        end
      end

      def api_params
        {
          token: ENV.fetch('SLACK_TOKEN'),
          as_user: false,
          username: 'operationcodebot'
        }
      end
    end
  end
end
