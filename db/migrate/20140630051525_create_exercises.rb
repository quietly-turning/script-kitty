class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.text :question
	  t.text :description
	  t.text :response_correct
	  t.references :lesson, index: true
	  t.integer :dummy_id
	  
      t.timestamps
    end
  end
end
