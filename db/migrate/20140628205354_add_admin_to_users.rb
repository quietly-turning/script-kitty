class AddAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean, :default => false
	add_column :users, :educator, :boolean, :default => false
	add_column :users, :active, :boolean, :default => true
  end
end
