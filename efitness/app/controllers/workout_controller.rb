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
    @workout = Workout.find(params[:id])
    if current_user == @workout.user
      erb :'workouts/show.html'
    else
      # flash[:error]="Authorization denied"
      redirect to '/workouts'
    end
  end

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
      # flash[:sucess]="Sucess workout"
      redirect to '/workouts'
    else
      # flash[:error]= workout.errors.full_messages.to_sentence
      redirect to '/workouts/new'
    end
    
  end
end