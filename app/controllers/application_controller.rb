class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  #   private
  # def current_user
  #   @current_user ||= User.find_by_auth_token( cookies[:auth_token]) if cookies[:auth_token]
  # end
  # helper_method :current_user
# before_filter :authenticate_user, :only => [:home, :profile, :setting]
# before_filter :save_login_state, :only => [:login, :login_attempt]
# protected 
# def authenticate_user
#   if session[:user_id]
#      # set current user object to @current_user object variable
#     @current_user = User.find session[:user_id] 
#     return true	
#   else
#     redirect_to(:controller => 'sessions', :action => 'login')
#     return false
#   end
# end
# def save_login_state
#   if session[:user_id]
#     redirect_to(:controller => 'sessions', :action => 'home')
#     return false
#   else
#     return true
#   end
# end

end