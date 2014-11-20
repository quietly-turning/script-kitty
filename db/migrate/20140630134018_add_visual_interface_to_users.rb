class AddVisualInterfaceToUsers < ActiveRecord::Migration
  def change
	add_column :users, :done, :boolean, :default => 0
    add_column :users, :visual_interface, :boolean, :default => 0
  end
end
