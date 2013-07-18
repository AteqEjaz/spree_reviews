require 'spec_helper'

describe Spree::Admin::ReviewSettingsController do
  stub_authorization!

  before { controller.stub spree_current_user: create(:user) }

  context "#update" do
    it "redirects to edit-review-settings page" do
      spree_put :update, preferences: {preview_size: 4}
      response.should redirect_to spree.edit_admin_review_settings_path
    end

    context "For parameters:
            preview_size:       4,
            show_email:         false,
            feedback_rating:    false,
            require_login:      true,
            always_show_create: false,
            track_locale:       true" do

      it "sets preferred_preview_size to 4" do
        spree_put :update, preferences: {preview_size: 4}
        Spree::Reviews::Config.preferred_preview_size.should eq(4)
      end

      it "sets preferred_show_email to false" do
        spree_put :update, preferences: {show_email: false}
        Spree::Reviews::Config.preferred_show_email.should eq(false)
      end

      it "sets preferred_feedback_rating to false" do
        spree_put :update, preferences: {feedback_rating: false}
        Spree::Reviews::Config.preferred_feedback_rating.should eq(false)
      end

      it "sets preferred_require_login to true" do
        spree_put :update, preferences: {require_login: true}
        Spree::Reviews::Config.preferred_require_login.should eq(true)
      end

      it "sets preferred_always_show_create to false" do
        spree_put :update, preferences: {always_show_create: false}
        Spree::Reviews::Config.preferred_always_show_create.should eq(false)
      end

      it "sets preferred_track_locale to true" do
        spree_put :update, preferences: {track_locale: true}
        Spree::Reviews::Config.preferred_track_locale.should eq(true)
      end
    end
  end
end
