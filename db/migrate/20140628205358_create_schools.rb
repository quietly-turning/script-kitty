class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.string :city
      t.string :state, :limit => 2
      t.string :zip, :limit => 10
      t.string :chief
      t.references :locale, index: true

      # t.timestamps
    end
  end
end