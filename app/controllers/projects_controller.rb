class ProjectsController < ApplicationController
  skip_before_action :authenticate, :only => [:index, :show, :count]
  before_action :owner_auth, :only => [:destroy, :update]


  def index
    return render_blank(500) unless params.include?(:offset) && params.include?(:count)
    
    if params.include?(:tag)
      # view by tag
      projects = Tag.find_by(name: params["tag"]).projects.offset(params[:offset]).limit(params[:count]).order("id desc")
    elsif params.include?(:user_id)
      # view by user 
      projects = User.find(params[:user_id]).projects.offset(params[:offset]).limit(params[:count]).order("id desc")
    else
      # view all
      projects = Project.offset(params[:offset]).limit(params[:count]).order("id desc")
    end

    return render json: projects
  end

  def show
    return render json: Project.find(params[:id])
  end

  def create
    if (project = Project.create(params.except(:tags).permit(:title, :school, :state, :summary, :feature_photo))).valid?
      # attach tags
      if params[:tags].length == 0
        project.destroy           # rollback
        return render_blank(500)
      end
      params[:tags].each do |tagname|
        option = { name: tagname[:name].downcase }
        tag = Tag.find_by(option)
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

      params[:tags].each do |tagname|
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



  private

  def owner_auth
    membership = Membership.find_by(user_id: current_user.id, project_id: params[:id])
    p "membership"
    p membership
    return render_blank(401) if membership.nil? || membership.is_owner == false
  end
end
