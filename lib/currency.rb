require 'i18n'
class Currency
  attr_accessor :rate
  attr_accessor :currency
  attr_accessor :code
  def initialize(currency)
    raise "Need a 3LC for currency #{currency}" unless currency.length == 3
    @currency = currency
    @code = currency.upcase
    @rate = 1.0
  end

  def name
    ::I18n.t("currency.#{@currency}")
  end

end
