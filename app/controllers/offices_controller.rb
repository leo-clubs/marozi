class OfficesController < ApplicationController
  def update
    office = Office.where(oid: params[:id]).first
    office.update_attributes member_id: params[:value]
    render json: nil
  end
end