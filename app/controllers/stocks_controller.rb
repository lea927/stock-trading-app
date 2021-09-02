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
end
