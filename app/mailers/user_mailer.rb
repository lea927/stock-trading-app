class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Welcome to Stockit')
  end

  def approved_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Your account had been approved')
  end
end
