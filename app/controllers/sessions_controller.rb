class SessionsController < ApplicationController
  skip_before_filter :require_login

  def index
    render layout: 'login'
  end

  def create
    session[:current_user] = params[:email_or_id]
    session[:current_user_club] = Club.find_by_member_id(session[:current_user]).oid
    redirect_to root_path
  end

  def destroy
    session.clear if logged_in?
    redirect_to login_screen_path
  end

  private
  def logged_in?
    session[:current_user]
  end
end