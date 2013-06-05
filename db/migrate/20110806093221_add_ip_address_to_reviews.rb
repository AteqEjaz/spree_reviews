class AddIpAddressToReviews < ActiveRecord::Migration
  def up
    add_column :reviews, :ip_address, :string
  end

  def down
    remove_column :reviews, :ip_address
  end
end
