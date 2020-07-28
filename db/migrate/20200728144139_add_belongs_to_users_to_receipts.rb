class AddBelongsToUsersToReceipts < ActiveRecord::Migration[6.0]
  def change
    add_column :receipts, :user_id, :bigint, null: false
    add_index :receipts, :user_id
    add_foreign_key :receipts, :users
  end
end
