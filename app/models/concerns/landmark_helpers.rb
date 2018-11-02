class LandmarkHelpers

  def self.find_or_create_figure(name: nil, id: nil)
    if name
      figure = Figure.find_or_create_by(name: name)
    elsif id
      figure = Figure.find_by(id: id)
    else
      figure = nil
    end
    figure
  end

  def self.parse_titles(name: nil, ids: [])
    @title_name = params[:titles][:name]
    @title_ids = params[:titles][:ids] || []
  
    if @title_name
      @title_ids << Title.find_or_create_by(name: @title_name).id
      @title_ids.uniq!
    end
  end
end
