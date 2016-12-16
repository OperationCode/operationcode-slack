module Operationcode
  module Slack
    class Api
      class OauthAccess < Operationcode::Slack::Api
        def self.post(with_data:)
          with_data[:client_secret] = ENV.fetch('SLACK_CLIENT_SECRET')
          with_data[:client_id] = ENV.fetch('SLACK_CLIENT_ID')
          super(with_data: with_data)
        end
      end
    end
  end
end
