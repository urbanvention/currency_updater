class Currencies
  def initialize
    @@currencies = {}
  end

  def add(currency)
    currency = currency.to_s.downcase
    result = @@currencies[currency] = Currency.new(currency)
    self.class.class_eval do
      define_method currency do
        @@currencies[currency]
      end
    end
    result
  end

  def all
    @@currencies.values
  end

  def include?(currency)
    @@currencies.keys.include?(currency.downcase)
  end
end
