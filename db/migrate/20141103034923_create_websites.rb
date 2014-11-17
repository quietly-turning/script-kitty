class CreateWebsites < ActiveRecord::Migration
  def change
    create_table :websites do |t|
      t.string :url
	  t.string :classification
      t.references :school, index: true

	  # t.timestamps
    end
  end
end