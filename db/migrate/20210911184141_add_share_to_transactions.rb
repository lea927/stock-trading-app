class AddShareToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :share, :integer
  end
end
