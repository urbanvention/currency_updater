require File.join(File.dirname(__FILE__), 'spec_helper.rb')

describe "CurrencyUpdater" do
  before :each do
    @cu = CurrencyUpdater.new
    @cu.currencies = ["USD"]
  end
  it "should add the currencies" do
    @cu.currencies.should include("usd")
  end

  it "should let usd respond to rate" do
    @cu.currencies.usd.should respond_to(:rate)
  end

  it "should be istance of Currency" do
    @cu.currencies.usd.should be_instance_of(Currency)
  end

  describe "currency updates" do
    before :each do
      @cu.usd.rate = 1.0000
    end

    it "should update the rate" do
      @cu.start
      @cu.usd.rate.should_not == 1.0000
    end
  end
end
