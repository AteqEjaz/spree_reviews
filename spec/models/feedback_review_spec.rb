require 'spec_helper'

describe Spree::FeedbackReview do
  context "relations" do
    it { should belong_to(:review) }
    it { should belong_to(:user) }
  end

  context "validation" do
    it { should validate_presence_of(:review_id) }
    it { should validate_numericality_of(:rating).with_message(Spree.t(:you_must_enter_value_for_rating)) }
  end
end
