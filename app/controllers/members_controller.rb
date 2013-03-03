require "#{Rails.root}/lib/refinements/xeditbable_converter"

using XEditableConverter

class MembersController < ApplicationController
  include MemberFinders

  def show
    @member, @club = member_and_club(params[:id])
  end

  def me
    @member, @club = member_and_club(session[:current_user])
    render action: 'show'
  end

  def update
    member = Member.where(leo_id: params[:id]).first
    member.update_attributes member_params
    render json: nil
  end

  def create
    c = Club.where(leo_id: session[:current_user_club]).first
    m = Member.create(member_params(true).merge(year: '2012-2013', club: c))
    render json: m
  end

  private
    def member_params create = false
      permitted = [
        :first_name,
        :last_name,
        :member_since,
        :date_of_birth,
        :gender,
        :languages,
        :profession,
        :type,
      ]

      contact_infos = {
        contact_infos_attributes: [
          :_destroy,
          :id,
          :type,
          :street,
          :zip,
          :city,
          :country,
          :email_address,
          :phone_number,
          :mobile_phone_number,
          :fax_number,
          :homepage
        ]
      }
      params_to_process = create ? params : params.to_rails_params
      params_to_process.permit(*permitted, contact_infos).to_hash
    end
end