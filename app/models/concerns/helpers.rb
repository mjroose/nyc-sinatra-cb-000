class Helpers
  def self.find_or_create_figure(figure_data)
    Figure.find_or_create_by(name: figure_data[:name]) || Figure.find_by(id: figure_data[:id]) || nil
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
