class LandmarksController < ApplicationController
  set :views, proc { File.join(root, '../views/') }
  register Sinatra::Twitter::Bootstrap::Assets

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'/landmarks/index'
  end
end
