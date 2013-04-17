class Department < ActiveRecord::Base
  attr_accessible :dept
  validates_presence_of :dept  
  validates :dept, :uniqueness => true 
  has_many :people
  has_many :teams
end
