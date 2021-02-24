class WorkoutsController < ApplicationController

  get '/workouts' do
    redirect_if_not_logged_in
    @workouts = current_user.workouts
    erb :'workouts/index.html'

  end

  get '/workouts/new' do
    redirect_if_not_logged_in
    erb :'workouts/new.html'
  end

  get '/workouts/:id' do
    redirect_if_not_logged_in
    @workouts = Workouts.find(params[:id])
    if current_user == @workouts.user && @workouts
      erb :'workouts/show.html'
    else
      # flash[:error]="Authorization denied"
      redirect to '/login'
    end
    
  end

  # get '/workouts/:id/edit' do 
  #   redirect_if_not_logged_in
  #   @workouts = Workouts.find(params[:id])
  #   if current_user == @workouts.user && @workouts
  #   erb :'workouts/edit.html'
  #   else
  #     redirect '/login'
  #   end
  # end

  post '/workouts' do
    redirect_if_not_logged_in
    workout = current_user.workouts.build(params["workout"])
    params[:exercises].each do |hash|
      if  hash[:name] != nil && hash[:name] != ""
        exercise = Exercise.find_or_create_by(name: hash["name"])
        exercise.bodypart = hash["bodypart"] if hash["bodypart"] && hash["bodypart"] != ""
        exercise.save
        ExerciseWorkout.create(exercise: exercise, workout: workout)
      end

    end
    if workout.save
      # flash[:sucess]="Successfully save new workout." 
      redirect to '/workouts/show.html'
    else
      # flash[:error]= workout.errors.full_messages.to_sentence
      redirect to '/workouts/new'
    end
    
  end
end