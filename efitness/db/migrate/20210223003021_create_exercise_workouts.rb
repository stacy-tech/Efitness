class CreateExerciseWorkouts < ActiveRecord::Migration[5.2]
  def change
    create_table :exercise_workouts do |t|
      t.references :workout
      t.references :exercise
      t.integer :series
      t.integer :reps

      t.timestamps null: false
    end
  end
end
