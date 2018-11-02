class LandmarkHelpers
  def self.find_or_create_figure(figure_data)
    name = figure_data[:name]
    id = figure_data[:id]

    if name
      figure = Figure.find_or_create_by(name: name)
    elsif id
      figure = Figure.find_by(id: id)
    else
      figure = nil
    end
    figure
  end

  def self.collect_titles(titles_data)
    name = titles_data[:name]
    ids = titles_data[:ids] || []

    if name
      ids << Title.find_or_create_by(name: name).id
    end

    ids.uniq.collect do |id|
      Title.find_by(id: id)
    end.compact
  end


end
