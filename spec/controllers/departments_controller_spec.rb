require 'rails_helper'

RSpec.describe DepartmentsController, :type => :controller do
	render_views
	before :each do
		    @dept= FactoryGirl.create(:department)
			@request.env["devise.mapping"] = Devise.mappings[:user]
		    @user=User.create(:email => 'user@example.com', :password => 'caplin')
		    sign_in @user
	end


	describe "GET #index" do

		it "index department" do
          get :index
          response.should be_success

		end

		it "new department" do
          get :new
          response.should be_success

		end

	    it "create department" do 
	     post :create, :department => {:dept => "My name"}
	     flash[:notice].should =~ /Department was successfully created./i
	     response.should redirect_to(department_path(assigns(:department))) 
	    end 

	    it "show department" do
          get :show,:id=>@dept
          response.should be_success
		end

		it "edit department" do
		  get :edit,:id=>@dept
          response.should be_success
		end


		it "update department" do
		  @attr = {:dept => Faker::Lorem.word}
		  put :update,:id=>@dept,:department=>@attr 
		  @dept.reload
          @dept.dept.should === @attr[:dept]
		end

	    it "delete department" do 
	     expect { delete :destroy, :id => @dept }.to change(Department, :count).by(-1)
		end

		it "should test show page" do
			visit department_url(:id => @dept)
			find('p').should have_content("Department:")
		end
    end
end
