class StocksController < ApplicationController
  before_action :authenticate_user!

  def search
    if params[:stock].present?
      #params[:stock] returns user's input symbol from the search bar
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
    else
      nil
    end
  end

  def show 
    client = Stock.iex_api
    @stock = Stock.find(params[:id])
    @stock_quote = client.quote(@stock.symbol)
    @logo = client.logo(@stock.symbol)
    @company = client.company(@stock.symbol)
    @market_cap = @stock_quote.market_cap.to_s.chars.reverse.each_slice(3).map(&:join).join(",").reverse
    @beta = client.key_stats(@stock.symbol).beta.round(2)
  end
end
