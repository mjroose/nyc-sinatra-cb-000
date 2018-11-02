require_relative './../models/concerns/helpers.rb'

class FiguresController < ApplicationController
  set :views, proc { File.join(root, '../views/') }
  register Sinatra::Twitter::Bootstrap::Assets

  get '/figures/:id' do
    @figure = Figure.find_by(id: params[:id])
    erb :'/figures/show'
  end
end
