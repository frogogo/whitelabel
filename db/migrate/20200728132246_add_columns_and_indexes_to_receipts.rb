class AddColumnsAndIndexesToReceipts < ActiveRecord::Migration[6.0]
  def change
    add_index :receipts, :qr_string, unique: true

    add_column :receipts, :data, :jsonb, null: false
  end
end
