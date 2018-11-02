class CreateFigureTitles < ActiveRecord::Migration
  def change
    create_table :figure_tables do |t|
      t.belongs_to :title, index: true
      t.belongs_to :figure, index: true
    end
  end
end
