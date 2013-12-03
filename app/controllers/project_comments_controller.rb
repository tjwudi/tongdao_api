class ProjectCommentsController < ApplicationController
  skip_before_action :authenticate, :only => [:index]

  def index
    @project = Project.find(params["project_id"])
    @project_comments = @project.project_comments

    render "project_comments/index"
  end

  def create
    @project = Project.find(params["project_id"])

    @project_comment = ProjectComment.new(params.permit(:content, :emotion))
    @project_comment.user = current_user
    @project_comment.project = @project
    @project_comment.project_post = nil

    @project_comment.save

    render "project_comments/show"
  end
end
