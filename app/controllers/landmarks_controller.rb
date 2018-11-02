require_relative './../models/concerns/helpers.rb'

class LandmarksController < ApplicationController
  set :views, proc { File.join(root, '../views/') }
  register Sinatra::Twitter::Bootstrap::Assets

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'/landmarks/index'
  end

  get '/landmarks/new' do
    @titles = Title.all
    @figures = Figure.all
    erb :'/landmarks/new'
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find_by(id: params[:id])
    @titles = Title.all
    @figures = Figure.all
    erb :'/landmarks/edit'
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find_by(id: params[:id])
    erb :'/landmarks/show'
  end

  post '/landmarks' do
    @figure = Helpers.find_or_create_figure(params[:figures])
    @landmark = Landmark.find_or_create_by(params[:landmark])

    if @landmark
      @figure.titles = Helpers.collect_titles(params[:titles])
      @landmark.figure = @figure
      @landmark.save

      redirect to :"/landmarks/#{@landmark.id}"
    else
      @titles = Title.all
      @figures = Figure.all
      @error_message = "You must give the landmark a name!"
      erb :'/landmarks/new'
    end
  end

  patch '/landmarks/:id' do
    @landmark = Landmark.find_by(id: params[:id])

    name = params[:landmark][:name]
    year_completed = params[:landmark][:year_completed]
    figure = Helpers.find_or_create_figure(params[:figures])
    figure.titles = Helpers.collect_titles(params[:titles])

    if @landmark
      @landmark.update(name: name, year_completed: year_completed, figure: figure)

      redirect to :"/landmarks/#{@landmark.id}"
    else
      redirect to :'/landmarks'
    end
  end
end
