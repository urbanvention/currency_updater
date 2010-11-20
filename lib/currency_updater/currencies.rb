module CurrencyUpdater

  class Currencies
    # EUR is unsupported because it's our reference currency
    # TRY is unsupported because it's a method used in actionpack
    # the other currencies are not supported because of google
    UNSUPPORTED = %w(EUR TRY AFN ALL AMD AOA AZN BAM BIF BMD BSD BTN CDF CUP ETB FIM FKP GEL GNF GYD IMP JEP KGS KMF LRD LSL LYD MGA MMK MNT MRO MZN SBD SHP SOS STD TJS TMM TOP TVD VUV WST ZWD)

    @@currencies = {}

    class << self
      def add(currency)
        currency = currency.to_s.downcase
        result = @@currencies[currency] = Currency.new(currency)
        define_currency(currency)
        result
      end

      def all
        @@currencies.values
      end

      def include?(currency)
        @@currencies.keys.include?(currency.downcase)
      end

      def delete
        @@currencies = {}
      end

      # for better guessing
      alias_method :clear, :delete

      def all_codes
        result = IsoCountryCodes.all.map(&:currency).sort
        result = result - UNSUPPORTED
        result.uniq
      end

      def define_currency(currency)
        define_method(currency) do
          @@currencies[currency]
        end
      end

      def unsupported?(currency)
        UNSUPPORTED.include?(currency)
      end
    end

    def to_json
      @@currencies.to_json
    end

    def to_xml
      xml = Builder::XmlMarkup.new(:indent=>2)
      xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
      xml.currencies do
        @@currencies.values.each do |currency|
          xml.currency(:name => currency.currency) do
            xml.code(currency.code)
            xml.rate(currency.rate)
          end
        end
      end
      xml.target!
    end

    def to_yaml
      @@currencies.to_yaml
    end
  end
end
