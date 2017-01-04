module Operationcode
  module Slack
    class User
      attr_reader :id, :name

      def initialize(data)
        # If we get a string should we go look the users info up?
        if data.is_a? String
          @id = data
          populate_name!
        else
          @id = data['id']
          @name = data['name']
        end
      end

      def populate_name!
        res = Operationcode::Slack::Api::UsersInfo.post(with_data: { user: @id })
        @name = res['user']['real_name'] if res['user']
      end
    end
  end
end
