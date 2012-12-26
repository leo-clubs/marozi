class MembersController < ApplicationController
  def show
    @member = Member.where(leo_id: params[:id]).first
    @club = @member.club
  end

  def me
    redirect_to member_path id: session[:current_user]
  end
end