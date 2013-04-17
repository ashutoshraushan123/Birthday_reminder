class Team < ActiveRecord::Base
  attr_accessible :dept_id, :team_name,:department,:depart
  validates_presence_of :team_name  
  validates :team_name, :uniqueness => true 
  belongs_to :department
  has_many :people
end
