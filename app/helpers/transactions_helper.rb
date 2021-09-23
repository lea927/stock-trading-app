module TransactionsHelper
  def display_balance
    current_user.balance
  end
end
