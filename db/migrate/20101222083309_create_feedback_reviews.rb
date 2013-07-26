class CreateFeedbackReviews < ActiveRecord::Migration
  def change
    create_table :feedback_reviews do |t|
      t.integer :user_id
      t.integer :review_id, null: false
      t.integer :rating,    default: 0
      t.text    :comment
      t.timestamps
    end
    add_index :feedback_reviews, :review_id
    add_index :feedback_reviews, :user_id
  end
end
