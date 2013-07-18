require 'spec_helper'

describe Spree::ReviewsController do
  let(:user) { create(:user) }
  let(:approved_review) { create(:review, approved: true) }
  let(:product){ create(:product) }
  let(:review_params) do
    { product_id: product.permalink,
      review:   { rating: "3 stars",
                  name:   "Abhishek",
                  title:  "Great Product",
                  review: "some big review text" }}
  end

  context "#terms" do
    specify do
      controller.stub(current_spree_user: nil)   # Fails with exception without this
      spree_get :terms, product_id: product.permalink
      response.should render_template :terms
    end
  end

  context "#index" do
    it "list approved reviews" do
      controller.stub(current_spree_user: user)
      approved_reviews = [
        create(:review, product_id: product.id, approved: true),
        create(:review, product_id: product.id, approved: true)
      ]
      spree_get :index, product_id: product.permalink
      assigns[:approved_reviews].should =~ approved_reviews
    end
  end

  context "#new" do
    it "render the new template" do
      controller.stub(current_spree_user: user)
      spree_get :new, product_id: product.permalink
      response.should render_template :new
    end

    it "redirect to login if the user is not logged in" do
      controller.stub(current_spree_user: nil)
      spree_get :new, product_id: product.permalink
      response.should redirect_to spree.login_path
    end

    it "fail if the user is not authorized to create a review" do
      controller.stub(:authorize!){ raise }
      expect{
        spree_post :new, product_id: product.permalink
      }.to raise_error
    end
  end

  context "#create" do
    before { controller.stub(current_spree_user: user) }

    it "creates a new review" do
      expect {
        spree_post :create, review_params
      }.to change{ Spree::Review.count }.from(0).by(1)
    end

    it "sets the ip-address of the remote" do
      request.stub(remote_ip: "127.0.0.1")
      spree_post :create, review_params
      assigns[:review].ip_address.should eq("127.0.0.1")
    end

    it "fails if the user is not authorized to create a review" do
      controller.stub(:authorize!){ raise }
      expect{
        spree_post :create, review_params
      }.to raise_error
    end

    it "flashes the notice 'review successfully submitted'" do
      spree_post :create, review_params
      flash[:notice].should eq("Review was successfully submitted")
    end

    it "redirects to product page" do
      spree_post :create, review_params
      response.should redirect_to spree.product_path(product)
    end

    it "removes all non-numbers from ratings param" do
      spree_post :create, review_params
      controller.params[:review][:rating].should eq("3")
    end

    it "sets the current spree user as review's user" do
      spree_post :create, review_params
      assigns[:review].user.should eq(user)
    end

    it "renders new when review.save fails" do
      Spree::Review.any_instance.stub(:save).and_return(false)
      spree_post :create, review_params
      response.should render_template :new
    end

    context "when config requires locale tracking:" do
      it "sets the locale" do
        Spree::Reviews::Config.preferred_track_locale = true
        spree_post :create, review_params
        assigns[:review].locale.should eq("en")
      end
    end
  end
end
