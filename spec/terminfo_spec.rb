# -*- coding: utf-8 -*-
require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

# dummy classes
module Jpmobile::Mobile
  class Docomo; end
  class Au; end
  class Softbank; end
  class Vodafone; end
end

describe Jpmobile::Mobile::Terminfo do
  def mock_carrier(carrier, stubs={ })
    @mock_carrier = eval("Jpmobile::Mobile::#{carrier}").new
    @mock_carrier.stub(stubs)
    @mock_carrier
  end

  context "docomoの場合" do
    it "端末情報を取得できること" do
      terminfo = Jpmobile::Mobile::Terminfo.new(mock_carrier("Docomo", {:model_name => 'SH906i'}), {})
      terminfo.color?.should be_true
      terminfo.colors.should == 16777216
      terminfo.width.should  == 240
      terminfo.height.should == 320
    end
  end

  context "auの場合" do
    it "端末情報を取得できること" do
      terminfo = Jpmobile::Mobile::Terminfo.new(mock_carrier("Au"), {
          'HTTP_X_UP_DEVCAP_SCREENPIXELS' => "240,348",
          'HTTP_X_UP_DEVCAP_ISCOLOR'      => "1",
          'HTTP_X_UP_DEVCAP_SCREENDEPTH'  => "16,RGB565"
        })
      terminfo.color?.should be_true
      terminfo.colors.should == 65536
      terminfo.width.should  == 240
      terminfo.height.should == 348
    end
  end

  context "softbankの場合" do
    it "端末情報を取得できること" do
      terminfo = Jpmobile::Mobile::Terminfo.new(mock_carrier("Softbank", {:model_name => '911T'}), {
          'HTTP_X_JPHONE_DISPLAY' => "480*800",
          'HTTP_X_JPHONE_COLOR'   => "C262144"
        })
      terminfo.color?.should be_true
      terminfo.colors.should == 262144
      terminfo.physical_width.should  == 480
      terminfo.physical_height.should == 800
      terminfo.width.should == 234
      terminfo.height.should == 339
      terminfo.browser_width.should == 234
      terminfo.browser_height.should == 339
    end
  end

  context "vodafoneの場合" do
    it "端末情報を取得できること" do
      terminfo = Jpmobile::Mobile::Terminfo.new(mock_carrier("Vodafone", {:model_name => 'V705SH'}), {
          'HTTP_X_JPHONE_DISPLAY' => "240*320",
          'HTTP_X_JPHONE_COLOR'   => "C262144"
        })
      terminfo.color?.should be_true
      terminfo.colors.should == 262144
      terminfo.physical_width.should  == 240
      terminfo.physical_height.should == 320
      terminfo.width.should == 240
      terminfo.height.should == 270
      terminfo.browser_width.should == 240
      terminfo.browser_height.should == 270
    end
  end
end
