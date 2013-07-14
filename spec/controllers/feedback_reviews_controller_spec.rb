require 'spec_helper'

describe Spree::FeedbackReviewsController do
  stub_authorization!

  let(:user) { create(:user) }
  let(:review) { create(:review, user: user) }
  let(:valid_attributes) { build(:feedback_review, review: review, user: review.user) }

  before { controller.stub spree_current_user: user }

  describe "#create" do
  end
end
