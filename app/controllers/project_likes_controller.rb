# -*- encoding : utf-8 -*-
class ProjectLikesController < ApplicationController
  def toggle_like
    target_project = Project.find(params[:id]);

    current_user.toggle_like!(target_project)
    return render json: get_like_state(current_user, target_project)
  end

  def state_like
    return render json: get_like_state(current_user, Project.find(params[:id]))
  end

  private
  def get_like_state(current_user_cache, target_project)
    result = {}
    result[:state] = current_user_cache.likes?(target_project) ? 0 : 1
    return result
  end
end
