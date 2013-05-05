class DistrictsController < ApplicationController

  def index
    @districts = District.all
  end

  def show
    @district = District.where(oid: params['id']).first
  end

  def my_district
    @district = District.find_by_member_id session[:current_user]
    render action: 'show'
  end
end