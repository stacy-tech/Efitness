class EfitsController < ApplicationController

  # GET: /efits
  get "/efits" do
    erb :"/efits/index.html"
  end

  # GET: /efits/new
  get "/efits/new" do
    erb :"/efits/new.html"
  end

  # POST: /efits
  post "/efits" do
    redirect "/efits"
  end

  # GET: /efits/5
  get "/efits/:id" do
    erb :"/efits/show.html"
  end

  # GET: /efits/5/edit
  get "/efits/:id/edit" do
    erb :"/efits/edit.html"
  end

  # PATCH: /efits/5
  patch "/efits/:id" do
    redirect "/efits/:id"
  end

  # DELETE: /efits/5/delete
  delete "/efits/:id/delete" do
    redirect "/efits"
  end
end
