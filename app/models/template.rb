class Template < ActiveRecord::Base
  
  attr_accessible :html 

  belongs_to :person
end
