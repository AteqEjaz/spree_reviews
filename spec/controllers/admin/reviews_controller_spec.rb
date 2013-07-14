require 'spec_helper'

describe Spree::Admin::ReviewsController do
  stub_authorization!

  let (:review) { create(:review, approved: false) }

  before { controller.stub spree_current_user: create(:user) }

  context "#approve" do
    it "show notice message when approved" do
      review.update_attribute(:approved, true)
      spree_get :approve, id: review.id
      response.should redirect_to spree.admin_reviews_path
      flash[:notice].should eql Spree.t(:info_approve_review)
    end

    it "show error message when not approved" do
      spree_get :approve, id: review.id
      response.should redirect_to spree.admin_reviews_path
      # flash[:error].should eql Spree.t(:error_approve_review)
    end
  end

  context "#edit" do
    specify do
      review.product = nil
      spree_get :edit, id: review.id
      review.product.should be_nil
      response.status.should eq 200
      # flash[:error].should eql Spree.t(:error_no_product)
    end
  end
end
