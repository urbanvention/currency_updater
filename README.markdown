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

### Fetching Currencies

In order to fetch all currencies defined by ISO 4217:

    currencies = CurrencyUpdater.new

or to fetch only one currency:

    currencies = CurrencyUpdater.new(USD)
    
or to fetch some currencies:

    currencies = CurrencyUpdater.new([USD,GBP,RUB])
    
### Accessing a currency

To access the currency rate, code or name:

    currencies.usd.rate # => 1.333
    currencies.usd.code # => "USD"
    currencies.usd.name # => I18n.t('currency.usd')
    
### Accessing all currencies

You're able to convert the currencies into different formats:

    currencies.to_json
    currencies.to_yaml
    currencies.to_xml
    currencies.to_csv

Have a look at the `examples` folder for sample outputs.

## Changelog

* 2010-11-19: Initial commit

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
