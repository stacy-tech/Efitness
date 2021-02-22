class CreateEfits < ActiveRecord::Migration[5.2]
  def change
    create_table :efits do |t|
      t.string :name
      t.string :workout
      t.date :date

      t.timestamps null: false
    end
  end
end
