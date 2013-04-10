class Team < ActiveRecord::Base
  attr_accessible :dept_id, :team_name,:department,:depart
  belongs_to :department
  has_many :people
end
