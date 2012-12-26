class ClubsController < ApplicationController

  def index
    #TODO has to go in elastic search
    h = Club.all.inject({}) do |hash, club|
      key = club.district.name
      hash.merge({key => [club]}){|key, oldval, newval| oldval + newval}
    end
    @clubs = Hash[h.sort]
  end

  def my_club
    @club = Club.find_by_member_id session[:current_user]
    render action: 'show'
  end
end