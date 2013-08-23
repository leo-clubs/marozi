class StatisticsController < ApplicationController
  def gender_ratio
    type = params[:type]
    unless %w{clubs districts multiple_districts}.include?(type)
      render :status => :forbidden, :text => "Forbidden type: #{type.inspect}" \
        and return
    end
    constant = Kernel.const_get(type.singularize.camelize)
    instance = constant.find_by!(oid: params[:id])
    render json: instance.gender_ratio(:active)
  end
end