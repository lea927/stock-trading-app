class TransactionsController < ApplicationController
    before_action :authenticate_user!

    def my_portfolio
      @stocks = current_user.stocks
    end
end
