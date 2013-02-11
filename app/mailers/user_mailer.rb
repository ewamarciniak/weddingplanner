class UserMailer < ActionMailer::Base
#reference http://railscasts.com/episodes/274-remember-me-reset-password accessed 20/11/2012
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset"
  end
end
