class RemoveItemFromReceipts < ActiveRecord::Migration[6.1]
  def change
    remove_reference :receipts, :item, foreign_key: true
  end
end
