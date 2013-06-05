class AddLocaleToFeedbackReviews < ActiveRecord::Migration
  def up
    add_column :spree_feedback_reviews, :locale, :string, default: 'en'
  end

  def down
    remove_column :spree_feedback_reviews, :locale
  end
end
