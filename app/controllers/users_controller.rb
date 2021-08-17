class UsersController < ApplicationController
  before_action :set_user, only: %i[show]
  before_action :authenticate_user!
  before_action do
    redirect_to root_path unless current_user.admin?
  end

  def index
    # admin users are not displayed
    @users = User.select { |user| user.broker? || user.buyer? }
  end

  def new
    @user = User.new
  end

  def show; end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      :first_name,
      :last_name,
      :role_id
    )
  end
end
