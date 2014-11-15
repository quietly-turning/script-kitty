class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :result_set_hash
      t.references :exercise, index: true

      t.timestamps
    end
  end
end
