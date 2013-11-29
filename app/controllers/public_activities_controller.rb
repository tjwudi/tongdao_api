class PublicActivitiesController < ApplicationController
  def index
    @user_followings = current_user.followables_relation(User)
    @user_followings_ids = []
    
    @user_followings.each do |user|
      @user_followings_ids << user.id
    end
    @public_activities = PublicActivity.where(:user_id => @user_followings_ids).order('id desc').page(params[:page])

    render json: @public_activities
  end

  def user_public_activities
    @public_activities = PublicActivity.where(:user_id => params[:id]).order('id desc').page(params[:page])

    render json: @public_activities
  end
end
