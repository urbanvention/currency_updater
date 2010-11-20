require 'iso_country_codes'
require 'yajl/json_gem'
require 'builder'

module CurrencyUpdater

  autoload :Currency, 'currency_updater/currency'
  autoload :Currencies, 'currency_updater/currencies'
  autoload :Updater, 'currency_updater/updater'

  # Default operation for fetching a currency
  mattr_accessor :rate_finder
  @@rate_finder = lambda {|currency|
    client = Net::HTTP.new("www.google.de")
    resp = client.get("/search?hl=de&q=1+EUR+to+#{currency}&btnG=Suche&meta=")
    text_only = resp.body.gsub(/<[^>]*>/, "")
    match = text_only.match(/1\s+Euro\s+=\s+([0-9\.\s]*)/mix)
    rate = if match
             match[1]
           else
             warn "currency #{currency} is unsupported"
             "1.00"
           end
    rate.gsub!(/\s+/, "").to_f
  }

  def self.setup
    yield self
  end
end
