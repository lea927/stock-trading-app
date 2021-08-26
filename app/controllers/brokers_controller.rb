class BrokersController < ApplicationController
  before_action :authenticate_user!

  def index
    # if params[:approved] == "false"
    @unapproved_users = User.where(approved: false)
  end
end
