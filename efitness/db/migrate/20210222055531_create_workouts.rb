class CreateWorkouts < ActiveRecord::Migration[5.2]
  def change
    create_table :workouts do |t|
      t.integer :user_id, foreign_key: {on_delete: true}
      t.string :name
      t.string :notes

      t.timestamps null: false
    end
  end
end
