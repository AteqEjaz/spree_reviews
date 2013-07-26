class AddLocaleToReviews < ActiveRecord::Migration
  def change
    add_column :spree_reviews, :locale, :string, default: 'en'
  end
end
