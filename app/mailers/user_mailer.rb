class UserMailer < ApplicationMailer

  def welcome_email
    @user = params[:user]
    @login_url = root_url
    mail(to: @user.email, subject: 'Welcome to Austinbook')
  end
end
