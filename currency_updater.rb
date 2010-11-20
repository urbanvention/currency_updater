require "rubygems"

# Set up gems listed in the Gemfile.
gemfile = File.expand_path('Gemfile', __FILE__)
begin
  ENV['BUNDLE_GEMFILE'] = gemfile
  require 'bundler'
  Bundler.setup
rescue Bundler::GemNotFound => e
  STDERR.puts e.message
  STDERR.puts "Try running `bundle install`."
  exit!
end if File.exist?(gemfile)

current = File.dirname(__FILE__)
currency_updater     = File.expand_path(File.join(current, 'lib', 'currency_updater'))
$LOAD_PATH << current << currency_updater

require 'iso_country_codes'
require 'currency_updater/currency'
require 'currency_updater/currencies'
require 'currency_updater/updater'
require 'yajl/json_gem'
require 'builder'
