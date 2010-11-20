require 'ruby-debug'
class CurrencyUpdater
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

    # TODO maybe delete all codes first?
    def initialize_currencies
      @@currency_codes.each do |currency|
        Currencies.add(currency)
      end
    end

    def update_currencies
      currencies = Currencies.all
      currencies.each do |currency|
        begin
          rate = search_rate_for(currency.code)
          currency.rate = rate
          #       rescue Exception
          #         error("currency #{currency.code} has not been updated!")
        end
      end
    end

    def search_rate_for(currency)
      raise "invalid currency" unless currency
      client = Net::HTTP.new("www.google.de")
      resp = client.get("/search?hl=de&q=1+EUR+to+#{currency}&btnG=Suche&meta=") || raise("no connection available")
      text_only = resp.body.gsub(/<[^>]*>/, "")
      match = text_only.match(/1\s+Euro\s+=\s+([0-9\.]*)/mix)
      rate = if match
               match[1]
             else
               warn "currency #{currency} is unsupported"
               "1.00"
             end
      rate.gsub!(/\s+/, "").to_f
    end
  end
  #----------------------------------------------------------------------#
  # instance methods
  #----------------------------------------------------------------------#
  def initialize(currency = nil)
    @currencies = Currencies.new
    CurrencyUpdater.select_country_codes(currency)
  end

  def method_missing(method,*args,&block)
    if @currencies.respond_to?(method)
      @currencies.send(method,*args,&block)
    else
      super
    end
  end

  private
  def error(msg)
    puts msg
  end
end
