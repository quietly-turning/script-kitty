class AddVisualInterfaceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :visual_interface, :boolean
  end
end
