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
      Spree::Review.any_instance.stub(:update_attribute).and_return(false)
      spree_get :approve, id: review.id
      flash[:error].should eql Spree.t(:error_approve_review)
    end
  end

  context "#edit" do
    specify do
      spree_get :edit, id: review.id
      response.status.should eq 200
    end

    context ":product is nil" do
      before { review.product = nil; review.save! }

      it "flash error: no-product" do
        spree_get :edit, id: review.id
        flash[:error].should eql Spree.t(:error_no_product)
      end

      it "redirect to admin-reviews page" do
        spree_get :edit, id: review.id
        response.should redirect_to spree.admin_reviews_path
      end
    end
  end
end
