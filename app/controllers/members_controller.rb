class MembersController < ApplicationController
  def show
    @member, @club = member_and_club(params[:id])
  end

  def me
    @member, @club = member_and_club(session[:current_user])
    render action: 'show'
  end

  private

  def member_and_club member_id
    m = Member.where(leo_id: member_id).first
    [m, m.club]
  end
end