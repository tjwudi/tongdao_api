class ProjectLikesController < ApplicationController
  def create
    current_user.like!(Project.find(params[:id]))
    return render_blank(201)
  end

  def destroy
    current_user.unlike!(Project.find(params[:id]))
    return render_blank(200)
  end

  def index
    result = {}
    result[:state] = current_user.likes?(Project.find(params[:id])) ? 0 : 1
    return render json: result
  end
end
