require 'spec_helper'

describe Spree::Product do
  context "relations" do
    it { should have_many(:reviews) }
  end

  context "mass assingment" do
    it { should allow_mass_assignment_of(:avg_rating) }
    it { should allow_mass_assignment_of(:reviews_count) }
  end

  context "#star" do
    let(:product) { create(:product, avg_rating: 3, reviews_count: 5) }

    it "returns avg rating" do
      product.avg_rating.should eq(3)
    end
  end
end
