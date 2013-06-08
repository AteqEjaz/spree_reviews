class CreateReviews < ActiveRecord::Migration
  def up
    create_table :spree_reviews do |t|
      t.integer :product_id
      t.integer :user_id
      t.string  :ip_address
      t.string  :name
      t.string  :location
      t.integer :rating
      t.text    :title
      t.text    :review
      t.boolean :approved, default: false
      t.string  :locale,   default: 'en'
      t.timestamps
    end

    add_column :spree_products, :avg_rating, :decimal, default: 0.0, null: false, precision: 7, scale: 5
    add_column :spree_products, :reviews_count, :integer, default: 0, null: false

    create_table :spree_feedback_reviews do |t|
      t.integer :user_id
      t.integer :review_id, null: false
      t.integer :rating,    default: 0
      t.string  :locale,    default: 'en'
      t.text    :comment
      t.timestamps
    end
    add_index :spree_feedback_reviews, :review_id
    add_index :spree_feedback_reviews, :user_id
  end

  def down
    drop_table    :spree_feedback_reviews
    remove_column :spree_products, :reviews_count
    remove_column :spree_products, :avg_rating
    drop_table    :spree_reviews
  end
end
