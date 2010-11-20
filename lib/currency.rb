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

  def to_json
    { :rate => rate,
      :code => code,
      :currency => currency }.to_json
  end

  def to_xml
    xml = Builder::XmlMarkup.new(:indent => 2)
    xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
    xml.currency(:name => currency) do
      xml.code(code)
      xml.rate(rate)
    end
    xml.target!
  end
end
