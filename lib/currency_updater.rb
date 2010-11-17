class CurrencyUpdater
  def initialize
    @currencies = Currencies.new
  end

  def currencies
    @currencies
  end

  def currencies=(a)
    a.each do |currency|
      @currencies.add(currency)
    end
  end

  def method_missing(method,*args,&block)
    return from_currencies(method,*args,&block) if @currencies.respond_to?(method)
    super
  end

  def from_currencies(method,*args,&block)
    @currencies.send(method,*args,&block)
  end

  def start
    @currencies.all.each do |currency|
      begin
        rate = search_rate_for(currency.code)
        currency.rate = rate
      rescue Exception
        error("currency #{currency.code} has not been updated!")
      end
    end
  end

  def search_rate_for(currency)
    client = Net::HTTP.new("www.google.de")
    resp = client.get("/search?hl=de&q=1+EUR+to+#{currency}&btnG=Suche&meta=")
    rate = resp.body.gsub(/<[^>]*>/, "").match(/1\s+Euro\s+=\s+([0-9\s\.]*)/mix)[1]
    rate.gsub!(/\s+/, "").to_f
  end

  def error(msg)
    puts msg
  end
end
