class WorkoutsController < ApplicationController

  get '/workouts' do
    @workouts = Workout.all
    erb :'workouts/index.html'
  end

  get '/workouts/:id' do
    @workout = Workout.find(params[:id])
    erb :'workouts/show.html'
  end

end