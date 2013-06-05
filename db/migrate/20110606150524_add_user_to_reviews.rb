class AddUserToReviews < ActiveRecord::Migration
  def up
    add_column :reviews, :user_id, :integer, null: true
  end

  def down
    remove_column :reviews, :user_id
  end
end
