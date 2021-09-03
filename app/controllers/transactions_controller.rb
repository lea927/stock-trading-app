class TransactionsController < ApplicationController
    before_action :authenticate_user!

    def my_portfolio
      @stocks = current_user.stocks
    end

    def create 
      #only create a new lookup of stock if it doesn't exist in the current database
      stock = Stock.search_db(params[:symbol]) || Stock.new_lookup(params[:symbol])
      stock.save
      @transaction = Transaction.create(user: current_user, stock: stock)
      flash[:notice] = "#{stock.company_name} was successfully added to your portfolio"
      redirect_to my_portfolio_path
    end

    def buyer_stock_market
      @stocks = User.find_by(role_id: 2, approved: true).stocks
    end
end
