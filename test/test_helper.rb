$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'operationcode/slack'

require "simplecov"
SimpleCov.start

require 'minitest/autorun'
require "mocha/test_unit"
