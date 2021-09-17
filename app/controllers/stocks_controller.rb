class StocksController < ApplicationController
  before_action :authenticate_user!

  def search
    if params[:stock].present?
      # params[:stock] returns user's input symbol from the search bar
      @stock = Stock.new_lookup(params[:stock])
      if @stock
        respond_to do |format|
          format.js { render partial: 'stocks/search_result' }
        end
      else
        respond_to do |format|
          flash.now[:notice] = 'Please enter a valid stock symbol'
          format.html
          format.js { render partial: 'stocks/search_result' }
        end
      end
    end
  end

  def show
    client = Stock.iex_api
    @stock = Stock.find(params[:id])
    @stock_quote = client.quote(@stock.symbol)
    @logo = client.logo(@stock.symbol)
    @company = client.company(@stock.symbol)
    @market_cap = @stock_quote.market_cap
    @beta = client.key_stats(@stock.symbol).beta.round(2)
    @broker_stocks = User.find_by(role_id: 2, approved: true).stocks.where(id: params[:id])
  end
end
