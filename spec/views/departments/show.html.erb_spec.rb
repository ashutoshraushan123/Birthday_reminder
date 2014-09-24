require 'spec_helper'

describe 'departments/show.html.erb' do
  it 'displays department details correctly' do
     @dept= FactoryGirl.create(:department) 
     visit department_url(:id => @dept)
     
     page.should have_content('Department:')
    
  end
end