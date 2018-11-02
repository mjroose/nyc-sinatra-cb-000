class LandmarksController < ApplicationController
  set :views, proc { File.join(root, '../views/') }
  register Sinatra::Twitter::Bootstrap::Assets

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'/landmarks/index'
  end

  get '/landmarks/new' do
    @titles = Title.all
    erb :'/landmarks/new'
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find_by(id: params[:id])
    erb :'/landmarks/edit'
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find_by(id: params[:id])
    erb :'/landmarks/show'
  end

  post '/landmarks' do

  end
end
