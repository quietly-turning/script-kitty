class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.integer :dummy_id
      t.text :raw_sql
	  t.boolean :correct, :default => false
      t.text :html_table, :limit => 4294967295
      t.references :user, index: true
      t.references :exercise, index: true
      
      t.timestamps
    end
  end
end
