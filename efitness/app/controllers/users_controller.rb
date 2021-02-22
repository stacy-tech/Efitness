class UsersController < ApplicationController

  get '/signup' do
    erb :'users/signup.html'
  end

  post '/signup' do
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    session[:user_id] = @user.id
    if @user.valid?
      flash[:success]="sucessfully created a user"
      redirect '/workouts'
    else
      flash[:error]=@user.errors.full_messages.to_sentence
      redirect '/signup'
    end
  end
end