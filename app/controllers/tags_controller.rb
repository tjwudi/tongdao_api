# -*- encoding : utf-8 -*-
class TagsController < ApplicationController
  skip_before_action :authenticate, only: [:index]

  def index
    return render_blank(500) unless params.include?(:auto_complete_word) && params.include?(:count)
    unless params.include?(:match) && params[:match].to_s == "1"
      return render json: Tag.where("name LIKE '%#{params[:auto_complete_word]}%'").limit(params[:count])
    else 
      return render json: Tag.where(name: params[:auto_complete_word]).limit(params[:count])
    end
  end

end
