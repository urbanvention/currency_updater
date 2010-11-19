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

  it "should include USD" do
    @cu.codes.should include("USD")
  end

  it "should not include EUR" do
    @cu.codes.should_not include("EUR")
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
