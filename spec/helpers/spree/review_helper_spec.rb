require 'spec_helper'

describe Spree::ReviewsHelper do
  context "star" do
    specify do
      helper.star("a_class").should eq "<span class=\"a_class\"> &#10030; </span>"
    end
  end

  context "txt_stars" do
    specify do
      helper.txt_stars(2, true).should eq "2 out of 5"
    end

    specify do
      helper.txt_stars(3, false).should be_a String
      helper.txt_stars(3, false).should eq("3")
    end
  end
end
