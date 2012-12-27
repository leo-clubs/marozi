class ClubsController < ApplicationController

  def index
    h = Club.order_by(name: :asc).inject({}) do |hash, club|
      key = club.district.name
      hash.merge({key => [club]}){|key, oldval, newval| oldval + newval}
    end
    @clubs = Hash[h.sort]
  end

  def show
    @club = Club.where(leo_id: params['id']).first
  end

  def my_club
    @club = Club.find_by_member_id session[:current_user]
    render action: 'show'
  end
end