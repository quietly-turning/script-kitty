class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.text :question

      t.timestamps
    end
  end
end
