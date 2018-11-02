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
      if @figure
        @figure.titles = Helpers.collect_titles(params[:titles])
        @figure.landmarks << @landmark
        @figure.save
      end

      redirect to :"/landmarks/#{@landmark.id}"
    else
      @error_message = "You must give the landmark a name!"
      erb :'/landmarks/new'
    end
  end

  patch '/landmarks/:id' do
    @figure_name = params[:figures][:name]
    @figure_id = params[:figures][:id]
    @landmark = Landmark.find_by(params[:id])
    @title_name = params[:titles][:name]
    @title_ids = params[:titles][:ids] || []

    if @landmark

    end

  end
end
