# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'operationcode/slack/version'

Gem::Specification.new do |spec|
  spec.name          = 'operationcode-slack'
  spec.version       = Operationcode::Slack::VERSION
  spec.authors       = ['RickR']
  spec.email         = ["rrein@akamai.com"]

  spec.summary       = %q{Operation Code Slack library}
  spec.description   = %q{This is a gem to interact with the Slack for all apps on the Opeartion Code platform}
  spec.homepage      = 'https://github.com/OperationCode/operationcode-slack'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rb-readline'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'mocha'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'codeclimate-test-reporter', '~> 1.0.0'
  spec.add_dependency 'httparty'
  spec.add_dependency 'activesupport'
end
