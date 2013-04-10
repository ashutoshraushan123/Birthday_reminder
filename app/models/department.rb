class Department < ActiveRecord::Base
  attr_accessible :dept

  has_many :people
  has_many :teams
end
