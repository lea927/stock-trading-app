class AddStockPriceToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :stock_price, :decimal
  end
end
