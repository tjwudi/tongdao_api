class LikesController < ApplicationController
  def create
    current_user.like!(Project.find(params[:project_id]))
    return render_blank(201)
  end

  def destroy
    current_user.unlike!(Project.find(params[:id]))
    return render_blank(200)
  end

  def index
    result = {}
    result[:state] = current_user.likes?(Project.find(params[:project_id])) ? 1 : 0
    return render json: result
  end
end
