class AddLocaleToFeedbackReviews < ActiveRecord::Migration
  def change
    add_column :spree_feedback_reviews, :locale, :string, default: 'en'
  end
end
