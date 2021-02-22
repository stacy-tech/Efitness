class WorkoutsController < ApplicationController

  get '/workouts' do
    if session[:user_id]
      @user = User.find_by_id(session[:user_id])
      @workouts = Workout.all
     erb :'workouts/index.html'
    else 
      redirect to '/login'
    end
  end

  get '/workouts/:id' do
    @workout = Workout.find(params[:id])
    erb :'workouts/show.html'
  end
end