class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :require_login

  private

  def require_login
    #TODO replace with login
    session[:current_user] = app_config['prototype']['logged_in_user'] rescue nil
  end
end
