require "rubygems"
require 'rspec'

gem "actionpack", "3.0.3"
gem "activemodel", "3.0.3"

require 'active_model'
require 'action_controller'

$:.unshift File.join(File.dirname(__FILE__), '..', 'lib', 'currency_updater')
require 'currency_updater'

begin
  require 'ruby-debug'
rescue LoadError
end

Dir["#{File.dirname(__FILE__)}/support/*.rb"].each { |f| require f }
I18n.default_locale = :en

RSpec.configure do |config|
  config.mock_with :mocha
end
