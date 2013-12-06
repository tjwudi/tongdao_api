class ProjectPostsController < ApplicationController
  skip_before_action :authenticate, :only => [:index, :show]

  def index
    @project = Project.find(params[:project_id])
    @project_posts = @project.project_posts.page(params[:page])

    render "project_posts/index"
  end

  def show
    @project = Project.find(params[:project_id])
    @project_post = @project.project_posts.find(params[:id])

    render "project_posts/show"
  end

  def show_featured
    @project = Project.find(params[:project_id])
    @project_post = @project.featured_post
    
    if @project_post.nil?
      render_blank(404)
    else
      render "project_posts/show"
    end
  end

  def create
    @project = Project.find(params[:project_id])
    @project_post = ProjectPost.new(params.permit(:title, :content))
    @project_post.project = @project
    @project_post.set_as_featured_post if params.include?(:featured) && params[:featured].to_s == "true"

    @project_post.save

    render "project_posts/show"
  end

  def update
    @project_post = ProjectPost.find(params[:id])

    @project_post.title = params[:title] if params.include?(:title)
    @project_post.content = params[:content] if params.include?(:content)
    @project_post.set_as_featured_post if params.include?(:featured) && params[:featured].to_s == "true"

    @project_post.save

    render "project_posts/show"
  end

  def destroy
    @project_post = ProjectPost.find(params[:id])
    @project_post.destroy
  end
end
