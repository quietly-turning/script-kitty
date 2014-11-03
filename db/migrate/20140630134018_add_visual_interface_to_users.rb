class AddVisualInterfaceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :visual_interface, :boolean, :default => 0
  end
end
