require 'spec_helper'

describe Spree::Admin::ReviewSettingsController do
  stub_authorization!

  before { controller.stub spree_current_user: create(:user) }

  context "#update" do
    specify do
      # spree_get :update
      # response.should redirect_to(spree.edit_admin_review_settings_path)
    end
  end
end
