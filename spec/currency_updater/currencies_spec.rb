require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

module CurrencyUpdater
  describe Currencies do
    context "Adding currencies" do
      before :each do
        Currencies.delete
      end
      it "should add usd" do
        Currencies.add("USD").should be_instance_of(Currency)
      end
      it "should include usd" do
        Currencies.add("USD")
        Currencies.should include("USD")
      end
      it "should include usd in #all" do
        Currencies.add("USD")
        Currencies.all.map(&:code).should include("USD")
      end

      it "should have no values initially" do
        Currencies.all.should == []
      end

      it "should have an xml output" do
        Currencies.add("USD")
        Currencies.new.to_xml.should == "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<currencies>\n  <currency name=\"usd\">\n    <code>USD</code>\n    <rate>1.0</rate>\n  </currency>\n</currencies>\n"
      end
    end
  end
end
