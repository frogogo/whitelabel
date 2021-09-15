class ChangeColumnType < ActiveRecord::Migration[6.1]
  def change
    change_column :items, :price, :float
    change_column :items, :discounted_price, :float
  end
end
