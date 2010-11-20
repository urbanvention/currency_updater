require "rubygems"
require 'bundler'
Bundler.setup

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec', 'spec_helper.rb'))

## These test cases will fail because the conversion rate is wrong
## This is intentionall to let you see some output
describe "RemoteSpecs" do
    describe "Fetching only USD" do
    before :all do
      @cu = CurrencyUpdater.new("USD")
    end

    it "should respond to USD" do
      currency = @cu.usd
      currency.rate.should_not == 1.000
      currency.code.should == "USD"
    end
  end

  describe "Fetching multiple currencies" do
    before :all do
      @cu = CurrencyUpdater.new(["USD", "GBP"])
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

  describe "Output Currencies" do
    context "to_json" do
      it "should output one currency" do
        cu = CurrencyUpdater.new("USD")
        cu.to_json.should == "{\"usd\":{\"rate\":1.3333,\"code\":\"USD\",\"currency\":\"usd\"}}"
      end

      it "should output multiple currencies" do
        cu = CurrencyUpdater.new(["USD", "GBP"])
        cu.to_json.should == "{\"usd\":{\"rate\":1.3333,\"code\":\"USD\",\"currency\":\"usd\"},\"gbp\":{\"rate\":1.3333,\"code\":\"GBP\",\"currency\":\"gbp\"}}"
      end
    end

    context "to_xml" do
      it "should output one currency" do
        cu = CurrencyUpdater.new("USD")
        cu.to_xml.should == "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<currencies>\n  <currency name=\"usd\">\n    <code>USD</code>\n    <rate>1.3333</rate>\n  </currency>\n</currencies>\n"
      end

      it "should output multiple currencies" do
        cu = CurrencyUpdater.new(["USD","GBP"])

        cu.to_xml.should == "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<currencies>\n  <currency name=\"usd\">\n    <code>USD</code>\n    <rate>1.3333</rate>\n  </currency>\n  <currency name=\"gbp\">\n    <code>GBP</code>\n    <rate>1.3333</rate>\n  </currency>\n</currencies>\n"
      end
    end

    context "to_yaml" do
      it "should output one currency" do
        cu = CurrencyUpdater.new("USD")
        cu.to_yaml.should == "--- \nusd: !ruby/object:Currency \n  code: USD\n  currency: usd\n  rate: 1.3333\n"
      end

      it "should output multiple currencies" do
        cu = CurrencyUpdater.new(["USD","GBP"])

        cu.to_yaml.should == "--- \nusd: !ruby/object:Currency \n  code: USD\n  currency: usd\n  rate: 1.3333\ngbp: !ruby/object:Currency \n  code: GBP\n  currency: gbp\n  rate: 1.3333\n"
      end
    end
  end
end
