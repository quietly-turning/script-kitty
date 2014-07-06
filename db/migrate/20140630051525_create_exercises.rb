class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.text :question
	  t.text :answer
	  t.text :description
	  t.text :lesson
	  t.text :response_correct
	  t.text :response_incorrect
	  
      t.timestamps
    end
  end
end
