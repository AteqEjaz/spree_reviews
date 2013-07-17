require 'spec_helper'

describe Spree::FeedbackReviewsController do
  stub_authorization!

  let(:user) { create(:user) }
  let(:review) { create(:review, user: user) }
  let(:valid_attributes) do
    { review_id: review.id,
      user_id: user.id,
      feedback_review: {
        rating:  "4 stars",
        comment: "some comment"
      }}
  end

  before do
    controller.stub spree_current_user: user
    request.env["HTTP_REFERER"] = "/"
  end

  describe "#create" do
    it "creates a feedback-review" do
      expect {
        spree_post :create, valid_attributes
      }.to change{ Spree::FeedbackReview.count }.from(0).to(1)
    end

    it "redirects back to the calling page" do
      spree_post :create, valid_attributes
      response.should redirect_to "/"
    end

    it "sets locale on feedback-review if required by config" do
      Spree::Reviews::Config.preferred_track_locale=true
      spree_post :create, valid_attributes
      assigns[:review].locale.should eq("en")
    end

    it "fails when user is not authorized" do
      controller.stub(:authorize!){ raise }
      expect{ spree_post :create, valid_attributes }.to raise_error
    end

    it "removes all non-numbers from ratings parameter" do
      feedback_review_params = valid_attributes
      feedback_review_params[:feedback_review][:rating] = "3 stars"
      spree_post :create, feedback_review_params
      controller.params[:feedback_review][:rating].should eq("3")
    end

    it "doesn't create feedback-review if review doesn't exist" do
      feedback_review_params = valid_attributes
      feedback_review_params[:review_id]=nil
      expect {
        spree_post :create, feedback_review_params
      }.to change{ Spree::FeedbackReview.count }.by(0)
    end
  end
end
