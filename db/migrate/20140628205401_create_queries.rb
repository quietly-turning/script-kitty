class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.integer :dummy_id
      t.text :raw_sql
	  t.integer :status, :limit => 1, :default => 0
	  t.integer :truncated_results, :limit => 1, :default => 0
	  t.integer :result_size, :limit => 2
      t.text :html_table, :limit => 4294967295
      t.references :user, index: true
      t.references :exercise, index: true

      t.timestamps
    end
  end
end