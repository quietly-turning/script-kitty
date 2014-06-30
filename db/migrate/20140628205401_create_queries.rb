class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.integer :dummy_id
      t.text :formatted_sql
      t.text :raw_sql
      t.text :html_table
      t.references :user, index: true
      t.references :exercise, index: true
      
      t.timestamps
    end
  end
end
