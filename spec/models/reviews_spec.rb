require 'spec_helper'

describe Spree::Review do
  let(:review) { create(:review) }

  context "relations" do
    it { should belong_to(:product) }
    it { should belong_to(:user) }
    it { should have_many(:feedback_reviews) }
  end

  context "validation" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:review) }
    it { should validate_numericality_of(:rating) }
  end

  context "mass assingment" do
    %w(user_id product_id ip_address approved).each do |col|
      it { should_not allow_mass_assignment_of(col.to_sym) }
    end
  end

  context "creating a new review" do
    it "is valid with valid attributes" do
      review.should be_valid
    end

    it "is not valid without a rating" do
      review.rating = nil
      review.should_not be_valid
    end

    it "is not valid unless the rating is an integer" do
      review.rating = 2.0
      review.should_not be_valid
    end

    it "is not valid without a review body" do
      review.review = nil
      review.should_not be_valid
    end
  end

  context "#recalculate_product_rating" do
    let(:product) { create(:product) }

    before { product.reviews << review }

    it "if approved" do
      review.should_receive(:recalculate_product_rating)
      review.approved = true
      review.save!
    end

    it "if not approved" do
      review.should_not_receive(:recalculate_product_rating)
      review.save!
    end

    it "updates the product average rating" do
      review.approved = true
      review.save!
      review.product.reload.avg_rating.should == review.rating

      review.destroy
      product.reload.avg_rating.should == 0
    end
  end

  context "#feedback_stars" do
    before do
      review.save
      3.times do |i|
        f = Spree::FeedbackReview.new
        f.review = review
        f.rating = (i+1)
        f.save
      end
    end

    it "return the average rating from feedback reviews" do
      review.feedback_stars.should == 2
    end
  end

  describe "class methods" do
    let(:r1) { create(:review, approved:false) }
    let(:r2) { create(:review, approved:false) }
    let(:r3) { create(:review, approved:true) }

    context ".not_approved" do
      it "lists unapproved reviews" do
        Spree::Review.not_approved.should =~ [r1,r2]
      end
    end

    context ".approval_filter" do
      it "lists all reviews when Config.include_unapproved_reviews is true" do
        Spree::Reviews::Config[:include_unapproved_reviews] = true
        Spree::Review.approval_filter.should =~ [r1,r2,r3]
      end

      it "lists only approved reviews when Config.include_unapproved_reviews is false" do
        Spree::Reviews::Config[:include_unapproved_reviews] = true
        Spree::Review.approval_filter.should =~ [r1,r2]
      end
    end

    context ".preview" do
      it "lists 4 reviews when Config.preview_size is 2" do
        Spree::Reviews::Config[:preview_size] = 2
        reviews = r1,r2,r3                        ## To create the reviews
        Spree::Review.preview.size.should eq(2)
      end
    end

  end
end
