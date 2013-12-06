class ProjectsController < ApplicationController
  skip_before_action :authenticate, :only => [:index, :show, :count]
<<<<<<< HEAD
  before_action :owner_auth, :only => [:destroy, :update]
=======
  before_action :owner_auth, :only => [:destroy, :update, :toggle_membership]
>>>>>>> e2e77a326c34a4ec9975460cec9895ab96c88ba4


  def index 
    if params.include?(:tag)
      # view by tag
      @projects = Tag.find_by(name: params["tag"]).projects.order("id desc").page(params[:page])
    elsif params.include?(:user_id)
      # view by user 
      @projects = User.find(params[:user_id]).projects.order("id desc").page(params[:page])
    else
      # view all
      @projects = Project.order("id desc").page(params[:page])
    end

    @projects = @projects.per_page(params[:per_page].to_i) if params.include?(:per_page)

    render "projects/index"
  end

  def show
    @project = Project.find(params[:id])
    @project.count_of_views = @project.count_of_views + 1
    @project.save

    render "projects/show"
  end

  def create
    if (@project = Project.create(params.except(:tags).permit(:title, :school, :state, :summary, :feature_photo))).valid?
      # attach tags
      if params[:tags].length == 0
        @project.destroy           # rollback
        return render_blank(500)
      end

      params[:tags].each do |key, tagname|
        option = { name: tagname['name'].downcase }
        tag = Tag.find_by(name: option[:name])
        tag = Tag.create(option) if tag.nil?
        @project.tags << tag
        tag.save
      end

      # create membership
      @membership = Membership.new
      @membership.user_id = current_user.id
      @membership.project_id = @project.id
      @membership.is_owner = true
      @membership.save

      # save project 
      @project.save

      render "projects/show"
    else
      # project creation failed 
      return render_blank(500)
    end
  end

  def update
    @project = Project.find(params[:id])

    # update attributes
    @project.update_attributes(params.except(:tags).permit(:title,:category,:school,:state, :summary, :feature_photo))
    
    # attach tags
    if params[:tags]
      @project.tags.clear
      render_blank(500) unless params[:tags].length > 0

      params[:tags].each do |key, tagname|
        option = { name: tagname[:name].downcase }
        tag = Tag.find_by(option)
        tag = Tag.create(option) if tag.nil?
        @project.tags << tag
        tag.save
      end
    end

    # save project
    @project.save
    
    render "projects/show"
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    return render_blank
  end

  def count
    @count = Project.all.count

    render "shared/count"
  end

  def toggle_like
    @project = Project.find(params[:id]);
    current_user.toggle_like!(@project)
   
    @state = get_like_state(current_user, @project)

    render "shared/state"
  end

  def state_like
    @state = get_like_state(current_user, Project.find(params[:id]))

    render "shared/state"
  end

<<<<<<< HEAD
=======
  def toggle_membership
    @project = Project.find(params[:id])
    @user = User.find(params[:user_id])

    unless @user.nil? || @project.nil?
      @project.toggle_membership!(@user)
    end

    render "projects/show"
  end

>>>>>>> e2e77a326c34a4ec9975460cec9895ab96c88ba4
  private
  def get_like_state(current_user_cache, target_project)
    return current_user_cache.likes?(target_project) ? 0 : 1
  end

  def owner_auth
    membership = Membership.find_by(user_id: current_user.id, project_id: params[:id])
  
    return render_blank(401) if membership.nil? || membership.is_owner == false
  end
end
