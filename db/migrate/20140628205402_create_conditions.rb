class CreateConditions < ActiveRecord::Migration
  def change
    create_table :conditions do |t|
      t.string :column
      t.string :parameter
      t.references :operator, index: true
      t.references :query, index: true
      t.string :complexOperator

      t.timestamps
    end
  end
end
