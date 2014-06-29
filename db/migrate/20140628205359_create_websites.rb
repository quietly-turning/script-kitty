class CreateWebsites < ActiveRecord::Migration
  def change
    create_table :websites do |t|
      t.string :classification
      t.string :url
      t.references :institution, index: true

      t.timestamps
    end
  end
end
