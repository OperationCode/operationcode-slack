$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'operationcode/slack'

require "simplecov"
SimpleCov.start

require 'minitest/autorun'

ENV['SLACK_CLIENT_ID'] = 'TEST_ID'
ENV['SLACK_CLIENT_SECRET'] = 'TEST_SECRET'
ENV['SLACK_TOKEN'] = 'mock_token'

require 'minitest/unit'
require 'mocha/mini_test'

