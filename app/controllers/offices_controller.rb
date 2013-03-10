class OfficesController < ApplicationController
  def update
    office = Office.where(leo_id: params[:id]).first
    office.update_attributes member_id: params[:value]
    render json: nil
  end
end