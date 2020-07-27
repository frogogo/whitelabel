class CreateReceipts < ActiveRecord::Migration[6.0]
  def change
    create_table :receipts do |t|
      t.string :qr_string, null: false
      t.integer :state, null: false, default: 0
      t.integer :reject_reason

      t.belongs_to :promotion, foreign_key: true
      t.timestamps
    end
  end
end
