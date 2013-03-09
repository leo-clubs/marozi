class HomeController < ApplicationController
  include Finders

  def index
    @member, @club = member_and_club_by_member_id(session[:current_user])
  end
end