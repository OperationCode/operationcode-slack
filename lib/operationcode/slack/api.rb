require 'httparty'

# Require all API classes
Dir[File.join(File.dirname(__FILE__), 'api', '**/*.rb')].sort.each { |file| require file }

module Operationcode
  module Slack
    class Api
      SLACK_API_BASE = 'https://slack.com/api/'

      # To add addtional API endpoints define a new class here. The class name should be capitalized based on the location of the
      # slack API path's '.' For example - the users info endpoint URL is https://slack.com/api/users.invite.
      # The class name should be `UsersInvite` If you just need to post data that should be  all you need.
      # If you'd like to add addtional methods to the class define it in its own file in the api dir (see OauthAccess)
      class ChannelsInvite < Operationcode::Slack::Api; end
      class UsersInfo < Operationcode::Slack::Api; end

      def self.post(with_data:)
        HTTParty.post(api_url, body: with_data)
      end

      def self.api_url
        SLACK_API_BASE + convert_class_name_to_api_name
      end

      def self.convert_class_name_to_api_name
        self.name.to_s.gsub!(/([a-z\d])([A-Z])/,'\1.\2').downcase.split('::').last
      end
    end
  end
end
