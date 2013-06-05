class CreateReviews < ActiveRecord::Migration
  def up
    create_table :reviews do |t|
      t.integer :product_id
      t.string  :name
      t.string  :location
      t.integer :rating
      t.text    :title
      t.text    :review
      t.boolean :approved, default: false
      t.timestamps
    end
  end

  def down
    drop_table :reviews
  end
end
