require 'spec_helper'

describe Spree::ReviewsController do
  stub_authorization!

  let!(:approved_review) { create(:review, approved: true) }

  before { controller.stub spree_current_user: create(:user) }

  context "#terms" do
    specify do
      spree_get :terms
      response.should render_template :terms
    end
  end
end
