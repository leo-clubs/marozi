class MultipleDistrictsController < ApplicationController

  def show
    @multiple_district = MultipleDistrict.where(leo_id: params['id'])
  end

  def my_multiple_district
    @multiple_district = MultipleDistrict.find_by_member_id session[:current_user]
    render action: 'show'
  end
end