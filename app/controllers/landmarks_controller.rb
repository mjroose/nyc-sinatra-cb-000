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
    @figure_name = params[:figures][:name]
    @figure_id = params[:figures][:id]
    @landmark = Landmark.find_or_create_by(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed]) unless params[:landmark][:name] == ""
    @title_name = params[:titles][:name]
    @title_ids = params[:titles][:ids] || []

    if @figure_name
      @figure = Figure.find_or_create_by(name: @figure_name)
    elsif @figure_id
      @figure = Figure.find_by(id: @figure_id)
    end

    if @title_name
      @title_ids << Title.find_or_create_by(name: @title_name).id
      @title_ids.uniq!
    end

    if @figure
      @figure.landmarks << @landmark
      @figure.titles = @title_ids.collect do |title_id|
        title = Title.find_by(id: title_id)
      end.compact

      @figure.save
    end

    redirect to :"/landmarks/#{@landmark.id}"
  end
end
