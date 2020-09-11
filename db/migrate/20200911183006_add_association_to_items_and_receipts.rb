class AddAssociationToItemsAndReceipts < ActiveRecord::Migration[6.0]
  def change
    add_reference :receipts, :item
    add_foreign_key :receipts, :items
  end
end
