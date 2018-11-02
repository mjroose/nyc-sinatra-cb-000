require_relative './../models/concerns/helpers.rb'

class FiguresController < ApplicationController
  set :views, proc { File.join(root, '../views/') }
  register Sinatra::Twitter::Bootstrap::Assets

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/new'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by(id: params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/edit'
  end

  get '/figures/:id' do
    @figure = Figure.find_by(id: params[:id])
    erb :'/figures/show'
  end

  post '/figures' do
    @figure = Figure.create(name: params[:figure][:name])

    if @figure
      @figure.titles = Helpers.collect_titles(params[:titles])
      @figure.landmarks = Helpers.collect_landmarks(params[:landmarks])
      @figure.save

      redirect to :"/figures/#{@figure.id}"
    else
      @titles = Title.all
      @landmarks = Landmark.all
      @error_message = "You must give the landmark a name!"
      erb :'/figures/new'
    end
  end

  patch '/figures/:id' do
    binding.pry
  end
end
