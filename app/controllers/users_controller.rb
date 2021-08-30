class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]
  before_action :unapproved_users
  before_action :authenticate_user!
  before_action do
    redirect_to root_path unless current_user.admin?
  end

  def index
    # admin users are not displayed in table
    @users = User.where(approved: true).select { |user| user.broker? || user.buyer? }
  end

  def new
    @user = User.new
    @minimum_password_length = 6
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        UserMailer.with(user: @user).welcome_email.deliver_now
        format.html { redirect_to users_admin_path(@user), notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def show; end

  def edit; end

  def update
    if user_params[:password].blank?
      user_params.delete(:password)
      user_params.delete(:password_confirmation)
    end
    successfully_updated = if needs_password?(@user, user_params)
                             @user.update(user_params)
                           else
                             @user.update_without_password(user_params)
                           end

    if successfully_updated
      redirect_to users_admin_path(@user), notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def unapproved_users 
    @unapproved_users = User.where(approved: false)
  end

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

  def needs_password?(_user, params)
    params[:password].present?
  end

  
end
