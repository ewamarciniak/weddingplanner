class PasswordResetsController < ApplicationController
#reference http://railscasts.com/episodes/274-remember-me-reset-password accessed 20/11/2012
  skip_before_filter :authorize
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to login_url, :notice => "Email sent with password reset instructions."
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    elsif @user.update_attributes(params[:user])
      redirect_to login_url, :notice => "Password has been reset!"
    else
      render :edit
    end
  end
end
