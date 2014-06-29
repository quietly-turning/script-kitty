class CreateInstitutions < ActiveRecord::Migration
  def change
    create_table :institutions do |t|
      t.string :name
      t.string :city
      t.string :state
      t.string :zip
      t.string :chief
      t.references :control, index: true
      t.references :level, index: true
      t.references :locale, index: true

      t.timestamps
    end
  end
end
