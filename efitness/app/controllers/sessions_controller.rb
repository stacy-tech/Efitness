class SessionsController < ApplicationController

  get '/login' do
    erb :'sessions/login.html'
  end

  post '/login' do
    user = User.find_by_email(params["email"])
    if user && user.authenticate(params["password"])
      session["user_id"] = user.id
      flash[:success] = "sucessfully logged in"
      redirect '/efits'
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

  