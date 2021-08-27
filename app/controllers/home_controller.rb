class HomeController < ApplicationController

  def index
    if current_user&.admin?
      redirect_to users_admin_index_path
    end
  end
end
