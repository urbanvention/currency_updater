class Currency
  attr_accessor :rate
  attr_accessor :currency
  attr_accessor :code
  def initialize(currency)
    raise "Need a 3LC for currency #{currency}" unless currency.length == 3
    @code = currency.upcase
    @rate = 1.0
  end
end
