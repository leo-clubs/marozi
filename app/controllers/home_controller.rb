class HomeController < ApplicationController
  include MemberFinders

  def index
    @member, @club = member_and_club(session[:current_user])
  end
end