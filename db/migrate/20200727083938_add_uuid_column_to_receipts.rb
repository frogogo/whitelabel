class AddUuidColumnToReceipts < ActiveRecord::Migration[6.0]
  def change
    add_column :receipts, :uuid, :uuid
    add_index :receipts, :uuid, unique: true
  end
end
