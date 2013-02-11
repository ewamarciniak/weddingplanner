class SessionsController < ApplicationController
  # reference https://github.com/railscasts/270-authentication-in-rails-3-1/tree/master/auth-after/app
  #  #reference http://railscasts.com/episodes/274-remember-me-reset-password accessed 20/11/2012
  skip_before_filter :authorize

  def new
  end

  def create
    user = User.find_by_login_name(params[:login_name])
    if user && user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      if user.admin
        redirect_to admin_url, :notice => "logged in"
      elsif user.type=="Vendor"
        redirect_to vendors_dashboard_path , :notice => "Logged in!"
      else
        redirect_to dashboard_url, :notice => "Logged in!"
      end
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to root_url, :notice => "Logged out!"
  end
end

