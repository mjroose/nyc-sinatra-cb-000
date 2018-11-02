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

  def self.collect_landmarks(landmarks_data)
    name = landmarks_data[:name]
    year_completed = landmarks_data[:year]
    ids = landmarks_data[:ids] || []

    if name
      ids << Landmark.find_or_create_by(name: name, year_completed: year_completed).id
    end

    ids.uniq.collect do |id|
      Landmark.find_by(id: id)
    end.compact
  end

end
