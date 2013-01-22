require "#{Rails.root}/lib/refinements/xeditbable_converter"

using XEditableConverter

class MembersController < ApplicationController
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
    m = Member.create(member_params(true))
    render json: m
  end

  private

  def member_and_club member_id
    m = Member.where(leo_id: member_id).first
    [m, m.club]
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