# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::API

  ##################################################
  # Constants
  MAX_AUTH_INTERVAL = 604800
  

  ##################################################
  # Filters & Actions
  before_action :before_log
  before_action :authenticate
  before_action :refresh_auth_time
  skip_before_action :authenticate, only: [:not_found]


  ##################################################
  # Global error hanlder registers
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_not_found


  ##################################################
  # Global error hanlders
  protected

  def rescue_not_found
    render_blank(404)
  end

  def rescue_global
    render_blank(500)
  end


  ##################################################
  # Global helper functions
  public

  def not_found
    return render_blank(404)
  end

  def before_log
    Rails.logger.info "REQUEST INSPECTOR"
    Rails.logger.info "  [REQUEST_URI] #{request.headers['REQUEST_URI'].inspect}"
    Rails.logger.info "  [RAW_POST]: #{request.raw_post.inspect}"
    Rails.logger.info "  [PARAMS]: #{request.params.inspect}"
    Rails.logger.info "  [HTTP_AUTHORIZATION] #{request.headers['HTTP_AUTHORIZATION'].inspect}"
    Rails.logger.info "  [CONTENT_TYPE]: #{request.headers['CONTENT_TYPE'].inspect}"
    Rails.logger.info "  [HTTP_ACCEPT] #{request.headers['HTTP_ACCEPT'].inspect}"
    Rails.logger.info "  [HTTP_HOST] #{request.headers['HTTP_HOST'].inspect}"
    Rails.logger.info "  [HTTP_USER_AGENT] #{request.headers['HTTP_USER_AGENT'].inspect}"
    Rails.logger.info "  [HTTP_AUTH_TOKEN] #{request.headers['HTTP_AUTH_TOKEN'].inspect}"
    Rails.logger.info "  [HTTP_AUTH_EMAIL] #{request.headers['HTTP_AUTH_EMAIL'].inspect}"
  end


  protected 

  def render_blank(status_code = 200)
    return render :json => [], :status => status_code
  end

  def current_user
    return @current_user
  end

  def refresh_auth_time
    if current_user
      current_user.last_auth_time = DateTime.now
      current_user.save()
    end
  end

  def authenticate
    return render_blank(401) unless request.headers.include?("HTTP_AUTH_TOKEN") && request.headers.include?("HTTP_AUTH_EMAIL") 

    @current_user = User.find_by(email: request.headers[:HTTP_AUTH_EMAIL], auth_token: request.headers[:HTTP_AUTH_TOKEN])
    if @current_user.nil?
      return render_blank(401)
    end

    if ((DateTime.now.to_f - @current_user.last_auth_time.to_f).to_i > MAX_AUTH_INTERVAL)
      @current_user.deauthorize
      return render_blank(401)
    end
  end
end
