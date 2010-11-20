require File.join(File.dirname(__FILE__), '..','spec_helper.rb')

module CurrencyUpdater
  describe Updater do
    # mock the http_access (comment it out to see actual values)
    def Updater.search_rate_for(foo)
      return 1.3333
    end

    describe "Fetching only USD" do
      before :each do
        @cu = Updater.new("USD")
      end

      it "should respond to USD" do
        currency = @cu.usd
        currency.rate.should_not == 1.000
        currency.code.should == "USD"
      end

      it "should not respond to RUB" do
        lambda {@cu.rub}.should raise_error(NoMethodError)
      end
    end

    describe "Fetching multiple currencies" do
      before :each do
        @cu = Updater.new(["USD", "GBP"])
      end

      it "should respond to USD" do
        @cu.usd.rate.should == 1.3333
      end

      it "should respond to GBP" do
        @cu.gbp.rate.should == 1.3333
      end

      it "should not respond to RUB" do
        lambda {@cu.rub}.should raise_error(NoMethodError)
      end
    end

    describe "Fetching all currencies" do

      before :each do
        @cu = Updater.new
        @codes = Currencies.all_codes
      end

      # to avoid bad method_missing behaviour
      it "should not include all" do
        @codes.should_not include("all")
      end

      it "should fetch all currencies defined by ISO 4217" do
        @codes.each do |code|
          currency = @cu.send code.downcase
          currency.should_not be_nil
        end
      end

      it "should override all default rates" do
        @codes.each do |code|
          currency = @cu.send code.downcase
          currency.rate.should_not == 1.0000
        end
      end

      it "should set all three letter codes properly" do
        @codes.each do |code|
          currency = @cu.send code.downcase
          currency.code.should == code
        end
      end

      it "should translate all names" do
        @codes.each do |code|
          code_name = code.downcase
          currency = @cu.send code_name
          currency.name.should == I18n.t("currency.#{code_name}")
        end
      end

      it "should always include USD" do
        @cu.usd.rate.should == 1.3333
      end

      it "should always include RUB" do
        @cu.rub.rate.should == 1.3333
      end

      it "should always include GBP" do
        @cu.gbp.rate.should == 1.3333
      end
    end

    describe "Output Currencies" do
      context "to_json" do
        it "should output one currency" do
          cu = Updater.new("USD")
          cu.to_json.should == "{\"usd\":{\"rate\":1.3333,\"code\":\"USD\",\"currency\":\"usd\"}}"
        end

        it "should output multiple currencies" do
          cu = Updater.new(["USD", "GBP"])
          cu.to_json.should == "{\"usd\":{\"rate\":1.3333,\"code\":\"USD\",\"currency\":\"usd\"},\"gbp\":{\"rate\":1.3333,\"code\":\"GBP\",\"currency\":\"gbp\"}}"
        end

        it "should output all currencies" do
          cu = Updater.new
          cu.to_json.should match(/\"rub\":{\"rate\":1\.3333,\"code\":\"RUB\",\"currency\":\"rub\"}/)
        end
      end

      context "to_xml" do
        it "should output one currency" do
          cu = Updater.new("USD")
          cu.to_xml.should == "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<currencies>\n  <currency name=\"usd\">\n    <code>USD</code>\n    <rate>1.3333</rate>\n  </currency>\n</currencies>\n"
        end

        it "should output multiple currencies" do
          cu = Updater.new(["USD","GBP"])

          cu.to_xml.should == "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<currencies>\n  <currency name=\"usd\">\n    <code>USD</code>\n    <rate>1.3333</rate>\n  </currency>\n  <currency name=\"gbp\">\n    <code>GBP</code>\n    <rate>1.3333</rate>\n  </currency>\n</currencies>\n"
        end

        it "should output all currencies" do
          cu = Updater.new
          cu.to_xml.should match(/rub/)
        end
      end

      context "to_yaml" do
        it "should output one currency" do
          Currencies.clear
          cu = Updater.new("USD")
          cu.to_yaml.should == "--- \nusd: !ruby/object:CurrencyUpdater::Currency \n  code: USD\n  currency: usd\n  rate: 1.3333\n"
        end

        it "should output multiple currencies" do
          cu = Updater.new(["USD","GBP"])

          cu.to_yaml.should == "--- \nusd: !ruby/object:CurrencyUpdater::Currency \n  code: USD\n  currency: usd\n  rate: 1.3333\ngbp: !ruby/object:CurrencyUpdater::Currency \n  code: GBP\n  currency: gbp\n  rate: 1.3333\n"
        end

        it "should output all currencies" do
          cu = Updater.new
          cu.to_yaml.should match(/rub/)
        end
      end
    end
  end
end
