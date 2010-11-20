# Currency Updater

The currency updater loads currency rates based on google search.

## Description

All rates conversions are based on the Euro (EUR).
This version doesn't use a database.

## Installation

Standalone:

    gem install currency_updater

With bundler:

    gem "currency_updater"
    
## Usage

You have to include the CurrencyUpdater module. Here is a silly example:

    class DollarTodayController < ApplicationController
      include CurrencyUpdater
     def index
        @currencies = Updater.new("USD")
      end
    end

### Fetching Currencies

In order to fetch all currencies defined by ISO 4217 (*):

    currencies = Updater.new

or to fetch only one currency:

    currencies = Updater.new("USD")
    
or to fetch some currencies:

    currencies = Updater.new(["USD","GBP","RUB"])
    
### Accessing a currency

To access the currency rate, code or name:

    currencies.usd.rate # => 1.333
    currencies.usd.code # => "USD"
    currencies.usd.name # => I18n.t('currency.usd')
    
### Output currencies

You're able to convert the currencies into different formats:

    currencies.to_json
    currencies.to_yaml
    currencies.to_xml

Have a look at the remote specs to get an idea how the output looks like:

    ruby remote_spec/remote_spec.rb

## Unsupported currencies

Some currency rates are not available today. You could try to update them anyhow.

    # lib/currency_updater/currencies.rb
    # class Currencies
    # EUR is unsupported because it's our reference currency
    # TRY is unsupported because it's a method used in actionpack
    # the other currencies are not supported because of google
    
    UNSUPPORTED = %w(EUR TRY AFN ALL AMD AOA AZN BAM BIF BMD BSD BTN CDF CUP ETB FIM FKP GEL GNF GYD IMP JEP KGS KMF LRD LSL LYD MGA MMK MNT MRO MZN SBD SHP SOS STD TJS TMM TOP TVD VUV WST ZWD)
    
## Configure the updater

You are able to override the rate_finder behavior for your needs.
In case you'd like to find the rates in another way, you can change the rate finder simply like that:

    # config/initializers/currency_updater.rb
    
    CurrencyUpdater.setup do |config|
      config.rate_finder = lambda {|currency| 1.2345 }
    end

## Changelog

* Fixed a typo in my dependencies (1.0.3)
* Add all dependencies specified in Gemfile (1.0.2)
* 2010-11-20: Update Gemspec dependencies (1.0.1)
* 2010-11-19: Initial commit (1.0.0)

## Contributors

* Jan Riethmayer (@riethmayer, maintainer)

## Credits

Thanks to [Alex Rabarts](http://statelesssystems.com) for his [iso_country_codes](https://github.com/alexrabarts/iso_country_codes).

## LICENSE

(The MIT License)

Copyright (c) 2010 [urbanvention](http://urbanvention.com)

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
