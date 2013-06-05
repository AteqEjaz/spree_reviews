class AddLocaleToReviews < ActiveRecord::Migration
  def up
    add_column :spree_reviews, :locale, :string, default: 'en'
  end

  def down
    remove_column :spree_reviews, :locale
  end
end
