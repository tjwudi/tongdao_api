class ProjectCommentsController < ApplicationController
  skip_before_action :authenticate, :only => [:index]

  def index
    if params.include?(:project_post_id) 
      @project_post = ProjectPost.find(params[:project_post_id])
      @project_comments = @project_post.project_comments
    else
      @project = Project.find(params["project_id"])
      @project_comments = @project.project_comments
    end
    
    @project_comments = @project_comments.page(params[:page])

    render "project_comments/index"
  end

  def create
    @project = Project.find(params["project_id"])

    @project_comment = ProjectComment.new(params.permit(:content, :emotion))
    @project_comment.user = current_user
    @project_comment.project = @project
    
    if params.include?("project_post_id")
      @project_comment.project_post = ProjectPost.find(params[:project_post_id])
    else
      @project_comment.project_post = nil
    end

    @project_comment.save

    render "project_comments/show"
  end
end
