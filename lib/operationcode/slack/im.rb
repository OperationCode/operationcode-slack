module Operationcode
  module Slack
    class Im
      attr_reader :payload

      def initialize(user: nil, channel: nil, text: '')
        @user = user
        @channel = channel
        @text = text

        @payload = api_params

        raise(ArgumentError, 'either user or channel must be provided') if @user.nil? && @channel.nil?
      end

      def deliver(text = @text)
        resolve_channel!
        set_payload_for!(text)
        Operationcode::Slack::Api::ChatPostMessage.post(with_data: @payload)
      end

      def make_interactive_with!(interactive_message)
        @payload['attachments'] = interactive_message.payload.to_json
      end

      private

      def set_payload_for!(text)
        @payload[:text] = text
      end

      def resolve_channel!
        if @channel.nil?
          im = Operationcode::Slack::Api::ImOpen.post(with_data: { token: ENV.fetch('SLACK_TOKEN'), user: @user })
          raise("Resolving channel failed: #{im}") if im['ok'] == false
          @payload['channel'] = im['channel']['id']
        end
      end

      def api_params
        {
          token: ENV.fetch('SLACK_TOKEN'),
          as_user: false,
          username: 'operationcodebot',
          'channel' => @channel
        }
      end
    end
  end
end
