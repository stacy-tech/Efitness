class UsersController < ApplicationController

  get '/signup' do
    erb :'users/signup.html'
  end

  post '/signup' do
    user = User.create(params)
    if user.valid?
      flash[:success]="sucessfully created a user"
      redirect '/login'
    else
      flash[:error]=user.errors.full_messages.to_sentence
      redirect '/signup'
    end
  end
end