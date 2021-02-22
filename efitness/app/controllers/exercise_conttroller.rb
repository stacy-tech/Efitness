class ExercisesController < ApplicationController
    get '/exercises' do
        erb :'exercises/index.html'
    end
end