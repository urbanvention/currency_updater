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
lib     = File.expand_path(File.join(current, 'lib'))
$LOAD_PATH << current << lib

require 'iso_country_codes'
require 'currency'
require 'currencies'
require 'currency_updater'
require 'yajl/json_gem'
require 'builder'
