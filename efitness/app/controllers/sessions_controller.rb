class SessionsController < ApplicationController

  get '/login' do
    if session[:user_id]
      redirect to '/workouts'
    else
      erb :'sessions/login.html'
    end
  end

  post '/login' do
    @user = User.find_by_email(params["email"])
    if @user && @user.authenticate(params["password"])
      session["user_id"] = @user.id
      flash[:success] = "sucessfully logged in"
      redirect '/workouts'
    else
      flash[:error] = "invalid credentials"
      redirect '/login'
    end
  end

  get '/logout' do 
    session.clear 
    redirect '/'
  end

end

  