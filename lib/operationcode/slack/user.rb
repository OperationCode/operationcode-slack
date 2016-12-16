module Operationcode
  module Slack
    class User
      attr_reader :id, :name

      def initialize(data)
        @id = data['id']
        @name = data['name']
      end
    end
  end
end
