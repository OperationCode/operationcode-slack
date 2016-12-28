module Operationcode
  module Slack
    class User
      attr_reader :id, :name

      def initialize(data)
        # If we get a string should we go look the users info up?
        if data.is_a? String
          @id = data
        else
          @id = data['id']
          @name = data['name']
        end
      end
    end
  end
end
