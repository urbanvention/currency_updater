module CurrencyUpdater
  class Updater
    class << self
      def select_country_codes(currency)
        @@currency_codes = if currency.nil?
                             Currencies.all_codes
                           else
                             Array.new([currency]).flatten
                           end
        initialize_currencies
        update_currencies
      end

      def initialize_currencies
        Currencies.clear
        @@currency_codes.each do |currency|
          Currencies.add(currency)
        end
      end

      def update_currencies
        currencies = Currencies.all
        currencies.each do |currency|
          rate = search_rate_for(currency.code)
          currency.rate = rate
        end
      end

      def search_rate_for(currency)
        raise "invalid currency" unless currency
        CurrencyUpdater.rate_finder.call(currency)
      end
    end
    #----------------------------------------------------------------------#
    # instance methods
    #----------------------------------------------------------------------#
    def initialize(currency = nil)
      @currencies = Currencies.new
      Updater.select_country_codes(currency)
    end

    def method_missing(method,*args,&block)
      if @currencies.respond_to?(method)
        @currencies.send(method,*args,&block)
      else
        super
      end
    end

    def to_json
      @currencies.to_json
    end

    def to_xml
      @currencies.to_xml
    end

    def to_yaml
      @currencies.to_yaml
    end
  end
end
