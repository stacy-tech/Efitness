class EfitsController < ApplicationController

  get '/efits' do
    erb :'efits/index.html'
  end

end