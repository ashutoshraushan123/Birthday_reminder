require 'rails_helper'

RSpec.describe Department, :type => :model do
  it "is invalid without a firstname" do 
  	FactoryGirl.create(:department).should be_valid
  end 
end
