class BirthdayController < ApplicationController
	before_filter :authenticate_user!
end
