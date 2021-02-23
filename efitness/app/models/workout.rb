class Workout < ActiveRecord::Base
    belongs_to :user 
    has_many :exercise_workouts
    has_many :exercises, through: :exercise_workouts
end
