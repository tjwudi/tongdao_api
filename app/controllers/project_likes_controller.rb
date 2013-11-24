class ProjectLikesController < ApplicationController
  def toggle_like
    current_user.toggle_like!(Project.find(params[:id]))
    return render_blank(200)
  end

  def status_like
    result = {}
    result[:state] = current_user.likes?(Project.find(params[:id])) ? 0 : 1
    return render json: result
  end
end
