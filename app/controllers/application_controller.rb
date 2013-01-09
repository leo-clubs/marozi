class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :require_login

  private

  def require_login
    puts "here I am with session: #{session[:current_user]}"
    redirect_to login_path unless session[:current_user]
  end
end
