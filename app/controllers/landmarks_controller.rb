class LandmarksController < ApplicationController
  set :views, proc { File.join(root, '../views/') }
  register Sinatra::Twitter::Bootstrap::Assets

  get '/' do
    @landmarks = Landmark.all
    erb :'/landmarks/index'
  end
end
