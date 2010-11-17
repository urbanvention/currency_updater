require File.expand_path(File.dirname(__FILE__) +  '/spec_helper.rb')
describe Currencies do
  context "Adding currencies" do
    before :each do
      @c = Currencies.new
    end

    it "should add usd" do
      @c.add("USD").should be_instance_of(Currency)
    end

    it "should include usd" do
      @c.add("USD")
      @c.should include("USD")
    end
  end
end
