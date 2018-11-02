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
    @figure = LandmarkHelpers.find_or_create_figure(name: params[:figures][:name], id: params[:figures][:id])
    @landmark = Landmark.find_or_create_by(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed]) unless params[:landmark][:name] == ""
    @figure.titles = LandmarkHelpers.collect_titles(name: params[:titles][:name], ids: params[:titles][:ids])

    if @figure
      @figure.landmarks << @landmark unless @landmark == nil
      @figure.save
    end

    redirect to :"/landmarks/#{@landmark.id}"
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
