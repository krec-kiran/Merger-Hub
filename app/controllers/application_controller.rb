class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_filter :set_default_url
  before_filter :trial_expired?
  skip_before_filter :trial_expired?, if: :devise_controller?
  after_filter :set_csrf_cookie_for_ng
  respond_to :html, :json
  # helper :all
  # helper :remaining_days

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def render_json(success, message, status)
    render :json => {:success => success, :response => message}, :status => status
  end

  def trial_expired?
    if current_user.remaining_days <= 0 && !current_user.is_paid_user
      if current_user.subscription == "trial"
        flash[:alert] = "Your trial period is expired.\n Please subscribe to continue."
      elsif current_user.subscription == "cancelled"
        flash[:alert] = "Your account deactived.\n \nPlease subscribe to continue."
      end
      if flash[:alert]
        redirect_to pricing_path
      end
    end

 end

  protected

  def set_default_url
     ActionMailer::Base.default_url_options = {:host => request.host_with_port}
  end

  def verified_request?
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end

end
