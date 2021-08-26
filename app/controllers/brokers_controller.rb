class BrokersController < ApplicationController
  before_action :authenticate_user!

  def index
    # if params[:approved] == "false"
    @unapproved_users = User.where(approved: false)
  end

  def edit; end

  def update 
    @user = User.find(params[:id])
    @user.update(:approved=>true)
    redirect_to brokers_path, notice: "Broker was successfully approved."
  end

  private

  def user_params
    params.require(:user).permit(:approved) 
  end
end
