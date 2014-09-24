require 'rails_helper'

RSpec.describe TeamsController, :type => :controller do
	render_views
	before :each do
	    @team = FactoryGirl.create(:team)	
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = User.create(:email=>"user@example.com",:password=>"caplin")
      sign_in @user
	end

    describe "test team" do

    	it "team index" do
    	 get :index
         response.should be_success 
    	end
        
        it "new team" do
          get :new
          response.should be_success 
        end

    	it "create team" do
         post :create, :team=>{:team_name =>"ROR"}
         flash[:notice].should =~ /Team was successfully created./i
	     response.should redirect_to(team_path(assigns(:team))) 
    	end

    	it "show team" do
         get :show,:id=>@team
         response.should be_success
    	end

      it "edit team" do
        get :edit,:id=>@team
        response.should be_success
      end

      it "update team" do
        @attr = {:team_name => Faker::Lorem.word}
        put :update,:id=>@team,:team=>@attr
        @team.reload
        @team.team_name.should === @attr[:team_name]
      end

      it "delete team" do
        expect{delete :destroy,:id=>@team}.to change(Team, :count).by(-1)
      end
   
    end
end
