require 'rspec'
project_root = File.expand_path(File.dirname(__FILE__) + "/..")
require "#{project_root}/currency_updater"
Dir[project_root + "/spec/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :mocha
end
