class PendingBrokersController < ApplicationController
  before_action :authenticate_user!
  before_action do
    redirect_to brokers_path unless current_user.admin?
  end

  def index
    @unapproved_users = User.where(approved: false)
  end

  def update 
    @user = User.find(params[:id])
    @user.update(:approved=>true)
    redirect_to pending_brokers_path, notice: 'Broker was successfully approved.'
    UserMailer.with(user: @user).approved_email.deliver_now
  end

  private

  def user_params
    params.require(:user).permit(:approved) 
  end
end
