module Operationcode
  module Slack
    class Im
      class Interactive
        REQUIRED_ACTION_KEYS = %i(name text value)
        VALID_STYLES = %i(default primary danger)

        def initialize(text:, id:, color: '#3AA3E3', actions:)
          @text = text
          @id = id
          @color = color
          @actions = actions

          validate_actions!
        end

        def validate_actions!
          raise(ArgumentError, 'actions must be an array') unless @actions.is_a? Array
          raise(ArgumentError, 'actions cannot be empty') if @actions.empty?
          @actions.each { |a| raise ArgumentError, "action #{a} is invalid" unless a.keys == REQUIRED_ACTION_KEYS }
        end

        def payload
          [
            {
              text: @text,
              fallback: @text,
              callback_id: @id,
              color: @color,
              attachment_type: 'default',
              actions: action_payload
            }
          ]
        end

        def action_payload
          @actions.map do |action|
            action[:style] = :default if action[:style].nil?
            {
              name: action[:name],
              text: action[:text],
              value: action[:value],
              style: action[:style],
              type: :button
            }
          end
        end
      end
    end
  end
end
