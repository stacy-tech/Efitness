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
       flash[:error]="Authorization denied."
      redirect to '/login'
    end
    
  end

  get '/workouts/:id/edit' do 
    redirect_if_not_logged_in
    @workout = Workout.find(params[:id])
    if current_user == @workout.user
    erb :'workouts/edit.html'
    else
      redirect '/workouts'
    end
  end

  patch "/workouts/:id" do 
    redirect_if_not_logged_in
    workout = Workout.find(params[:id])
    if current_user == workout.user && workout.update(params[:workout])
      workout.exercise_workouts.delete_all
      params[:exercises].each do |hash|
        if  hash[:name] != "nil" && hash[:name] != ""
          exercise = Exercise.find_or_create_by(name: hash["name"])
            exercise.bodypart = hash["bodypart"] if hash["bodypart"] && hash["bodypart"] != ""
            exercise.save
            ExerciseWorkout.create(exercise: exercise, workout: workout)
        end
      end
      flash[:success] = "Successfully updated."
      redirect "/workouts/#{workout.id}"
    else
      flash[:error] = workout.errors.full_messages.to_sentence
      redirect "/workouts/#{workout.id}/edit"
    
    end
  end
    
  delete "/workouts/:id" do
    redirect_if_not_logged_in
    workout = Workout.find(params[:id])
    if current_user == workout.user
      workout.destroy
      flash[:sucess]="Successfully deleted."
    else
      flash[:error]= workout.errors.full_messages.to_sentence
    end
    redirect '/workouts'
  end

  post '/workouts' do
    redirect_if_not_logged_in
    workout = current_user.workouts.build(params["workout"])
    params[:exercises].each do |hash|
      if  hash[:name] != "nil" && hash[:name] != ""
        exercise = Exercise.find_or_create_by(name: hash["name"])
        exercise.bodypart = hash["bodypart"] if hash["bodypart"] && hash["bodypart"] != ""
        exercise.save
        ExerciseWorkout.create(exercise: exercise, workout: workout)
      end

    end
    if workout.save
      flash[:sucess]="Successfully save new workout." 
      redirect to "/workouts/#{workout.id}"
    else
      flash[:error]= workout.errors.full_messages.to_sentence
      redirect to '/workouts/new'
    end
  end
end