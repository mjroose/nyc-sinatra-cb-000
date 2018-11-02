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
    title_ids = params[:figure][:title_ids]
    title_name = params[:title][:name]
    landmark_ids = params[:figure][:landmark_ids]
    landmark_name = params[:landmark][:name]
    landmark_year = params[:figure][:landmark_year]

    if @figure
      @figure.titles = Helpers.collect_titles(name: title_name, ids: title_ids)
      @figure.landmarks = Helpers.collect_landmarks(name: landmark_name, year: landmark_year, ids: landmark_ids)
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
    @figure = Figure.find_by(params[:id])
    name = params[:figure][:name]
    titles = Helpers.collect_titles(params[:titles])
    landmarks = Helpers.collect_landmarks(params[:landmarks])

    if @figure
      @figure.update(name: params[:figure][:name], titles: titles, landmarks: landmarks)

      redirect to :"/figures/#{@figure.id}"
    else
      @figures = Figure.all
      erb :'/figures/index'
    end
  end
end
