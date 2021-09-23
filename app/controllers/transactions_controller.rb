class TransactionsController < ApplicationController
  before_action :authenticate_user!
  include TransactionsHelper

  def my_portfolio
    @stocks = current_user.stocks
    @transactions = current_user.transactions
    display_balance
  end

  def create
    if current_user.broker?
      # only create a new lookup of stock if it doesn't exist in the current database
      @stock = Stock.search_db(params[:symbol]) || Stock.new_lookup(params[:symbol])
      save_transaction
    elsif current_user.buyer?
      @transaction = Transaction.new(transaction_params)
      @transaction.user_id = current_user.id
      @transaction.save
      flash[:notice] = "#{@transaction.stock.company_name} was successfully added to your portfolio"
      redirect_to my_portfolio_path
    end
  end

  def buyer_stock_market
    @stocks = User.find_by(role_id: 2, approved: true).stocks
  end

  def new
    @stock = Transaction.find_by(stock: params[:id]).stock
    @transaction = Transaction.new
  end

  def save_transaction
    @stock.save
    Transaction.create!(user: current_user, stock: @stock, price: @stock.price)
    flash[:notice] = "#{@stock.company_name} was successfully added to your portfolio"
    redirect_to my_portfolio_path
  end

  private

  def transaction_params
    params.require(:transaction).permit(:user_id, :stock_id, :stock_price, :share, :price, :symbol)
  end
end
