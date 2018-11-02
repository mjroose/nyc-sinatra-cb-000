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
    if @title_name
      ids << Title.find_or_create_by(name: @title_name).id
    end
    ids.uniq
  end
end
