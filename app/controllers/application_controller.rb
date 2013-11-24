class ApplicationController < ActionController::API

  ##################################################
  # Constants
  MAX_AUTH_INTERVAL = 604800
  

  ##################################################
  # Filters & Actions
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


  protected 

  def render_blank(status_code = 200)
    return render :json => [], :status => status_code
  end

  def current_user
    unless request.headers[:HTTP_AUTH_TOKEN].nil?
      return User.find_by(auth_token: request.headers[:HTTP_AUTH_TOKEN])
    end
  end

  def refresh_auth_time
    if current_user
      current_user.last_auth_time = DateTime.now
      current_user.save()
    end
  end

  def authenticate
    return render_blank(401) unless request.headers.include?("HTTP_AUTH_TOKEN") && request.headers.include?("HTTP_AUTH_EMAIL") 
    user = User.find_by(email: request.headers[:HTTP_AUTH_EMAIL], auth_token: request.headers[:HTTP_AUTH_TOKEN])
    if user.nil?
      return render_blank(401)
    end
    if ((DateTime.now.to_f - user.last_auth_time.to_f).to_i > MAX_AUTH_INTERVAL)
      user.deauthorize
      return render_blank(401)
    end
  end
end
