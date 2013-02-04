class ApplicationController < ActionController::Base
  protect_from_forgery

   before_filter :set_cache_buster

  def after_sign_in_path_for(resource)

     people_path

   end
 

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end


  # def current_ability
  #    @current_ability ||= Ability.new(current_user)
  # end

#  unless ActionController::Base.consider_all_requests_local
#     rescue_from Exception, :with => :render_error
#     rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
#     rescue_from ActionController::RoutingError, :with => :render_not_found
#     rescue_from ActionController::UnknownController, :with => :render_not_found
#     rescue_from ActionController::UnknownAction, :with => :render_not_found
#  end


# private

#   def render_not_found(exception)
#     log_error(exception)
#     notify_hoptoad(exception)
#     render :template => "/error/404.html.erb", :status => 404
#   end

#   def render_error(exception)
#     log_error(exception)
#     notify_hoptoad(exception)
#     render :template => "/error/500.html.erb", :status => 500
#   end




end
