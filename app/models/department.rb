class Department < ActiveRecord::Base
  attr_accessible :dept

  has_many :department
end
