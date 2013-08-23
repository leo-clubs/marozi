class ClubsController < ApplicationController
  include Finders
  include Converters

  def index
    h = Club.order(:name).inject({}) do |hash, club|
      hash.merge({club.district.name => [club]}){|key, oldval, newval| oldval + newval}
    end
    @clubs = Hash[h.sort]
    @districts = @clubs.keys
  end

  def members
    @club = club_by_club_id(params[:id])
    result = nil
    members = @club.members.sort{|a, b| a.last_name <=> b.last_name}
    if params[:type] == 'xeditable_names_only'
      result = person_array_to_xeditable(
        members,
        lambda{|p| I18n.translate(:'members.name', first_name: p.first_name, last_name: p.last_name)})
    end
    render json: result
  end

  def show
    @club = club_by_club_id(params[:id])
  end

  def my_club
    @club = Club.find_by_member_id session[:current_user]
    render action: 'show'
  end
end