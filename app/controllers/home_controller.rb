class HomeController < ApplicationController

  def index
    if  current_user&.admin?
        redirect_to users_admin_index_path
    else
        redirect_to my_portfolio_path
    end
  end
end
