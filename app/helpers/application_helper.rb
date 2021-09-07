module ApplicationHelper
  def get_balance
    @user_balance = current_user.balance
  end
end
