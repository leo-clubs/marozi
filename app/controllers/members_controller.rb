class MembersController < ApplicationController
  def show
    @member = Member.where(leo_id: params[:id]).first
    @club = @member.club
  end
end