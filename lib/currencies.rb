class Currencies
  # EUR is unsupported because it's our reference currency
  # the other currencies are not supported
  UNSUPPORTED = %w(EUR AFN ALL AMD AOA AZN BAM BIF BMD BSD BTN CDF CUP ETB FIM FKP GEL GNF GYD IMP JEP KGS KMF LRD LSL LYD MGA MMK MNT MRO MZN SBD SHP SOS STD TJS TMM TOP TVD VUV WST ZWD)

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
end
