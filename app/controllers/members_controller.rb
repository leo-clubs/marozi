class MembersController < ApplicationController
  def show
    @club = Club.where(leo_id: params[:club_id]).first
    @member = Member.where(club: @club).where(leo_id: params[:id]).first
  end
end