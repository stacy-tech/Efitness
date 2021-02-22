class CreateExercise < ActiveRecord::Migration[5.2]
  def change
    create_table :exercise do |t|
      t.string :name
      t.string :bodypart

      t.timestamps null: false
    end
  end
end
