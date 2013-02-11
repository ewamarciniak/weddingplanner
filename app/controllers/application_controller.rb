class ApplicationController < ActionController::Base
#reference http://railscasts.com/episodes/274-remember-me-reset-password accessed 20/11/2012
  protect_from_forgery
  before_filter :authorize

  private
  def current_user
    @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end

  helper_method :current_user

  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end

  protected

  def authorize
    unless current_user
      redirect_to login_url, notice: "Please log in"
    end
  end

  def is_admin?
    unless current_user.admin
      redirect_to login_url, :alert => "You are not authorized to access the requested page"
    end
  end

  def is_vendor?
    unless current_user.admin || current_user.type=="Vendor"
      redirect_to login_url, :alert => "Requested page is available to vendors only"
    end
  end
end