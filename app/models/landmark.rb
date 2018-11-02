class Landmark < ActiveRecord::Base
  belongs_to :figure
  validates_presense_of :name
end
