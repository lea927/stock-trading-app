class AddBalanceToUsers < ActiveRecord::Migration[6.0]
  def up
    add_column :users, :balance, :decimal, :precision => 8, :scale => 2
  end

  def down
    remove_column :users, :balance
  end
end
