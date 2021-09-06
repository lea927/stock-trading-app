class TransactionsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_stock, only: [:new,:show]

    def my_portfolio
      @stocks = current_user.stocks
    end

    def create 
      if current_user&.broker?
        #only create a new lookup of stock if it doesn't exist in the current database
        @stock = Stock.search_db(params[:symbol]) || Stock.new_lookup(params[:symbol])
        save_transaction
      elsif current_user&.buyer?
        @stock = Stock.find_by(params[:id])
        save_transaction
      end 
    end

    def buyer_stock_market
      @stocks = User.find_by(role_id: 2, approved: true).stocks
    end

    def show
      @transaction = Transaction.new
    end

    def find_stock
      @stock = Stock.find(params[:id])
    end

    def save_transaction
      @stock.save if current_user&.broker?
      @transaction = Transaction.create!(user: current_user, stock: @stock)
      flash[:notice] = "#{@stock.company_name} was successfully added to your portfolio"
      redirect_to my_portfolio_path
    end
end
