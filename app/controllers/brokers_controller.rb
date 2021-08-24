class BrokersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    if params[:approved] == "false"
      @users = User.where(approved: false)
      binding.pry
    else
      @users = User.all
    end
  end
end
