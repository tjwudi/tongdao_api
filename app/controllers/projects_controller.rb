class ProjectsController < ApplicationController
  skip_before_action :authenticate, :only => [:index, :show, :count]
  before_action :owner_auth, :only => [:destroy, :update]


  def index 
    if params.include?(:tag)
      # view by tag
      projects = Tag.find_by(name: params["tag"]).projects.order("id desc").page(params[:page])
    elsif params.include?(:user_id)
      # view by user 
      projects = User.find(params[:user_id]).projects.order("id desc").page(params[:page])
    else
      # view all
      projects = Project.order("id desc").page(params[:page])
    end

    projects = projects.per_page(params[:per_page].to_i) if params.include?(:per_page)

    return render json: projects
  end

  def show
    project = Project.find(params[:id])
    project.count_of_views = project.count_of_views + 1
    project.save

    return render json: project
  end

  def create
    if (project = Project.create(params.except(:tags).permit(:title, :school, :state, :summary, :feature_photo))).valid?
      # attach tags
      if params[:tags].length == 0
        project.destroy           # rollback
        return render_blank(500)
      end
      p params[:tags]
      params[:tags].each do |key, tagname|
        option = { name: tagname['name'].downcase }
        tag = Tag.find_by(name: option[:name])
        tag = Tag.create(option) if tag.nil?
        project.tags << tag
        tag.save
      end

      # create membership
      membership = Membership.new
      membership.user_id = current_user.id
      membership.project_id = project.id
      membership.is_owner = true
      membership.save

      # save project 
      project.save

      return render json: project
    else
      # project creation failed 

      return render_blank(500)
    end
  end

  def update
    project = Project.find(params[:id])

    # update attributes
    project.update_attributes(params.except(:tags).permit(:title,:category,:school,:state, :summary, :feature_photo))
    
    # attach tags
    if params[:tags]
      project.tags.clear
      render_blank(500) unless params[:tags].length > 0

      params[:tags].each do |key, tagname|
        option = { name: tagname[:name].downcase }
        tag = Tag.find_by(option)
        tag = Tag.create(option) if tag.nil?
        project.tags << tag
        tag.save
      end
    end

    # save project
    project.save
    
    return render json: project
  end

  def destroy
    project = Project.find(params[:id])
    project.destroy

    return render_blank
  end

  def count
    return render json: {"count" => Project.all.count} 
  end

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

  def owner_auth
    membership = Membership.find_by(user_id: current_user.id, project_id: params[:id])
    p "membership"
    p membership
    return render_blank(401) if membership.nil? || membership.is_owner == false
  end
end
