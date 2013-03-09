class OfficesController < ApplicationController
  def update
    office = Office.where(leo_id: params[:id]).first
    office.update_attributes member_id: params[:value]
    binding.pry
    render json: nil
  end
end