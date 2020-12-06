class SetDefaultValueToDataInReceipts < ActiveRecord::Migration[6.0]
  def change
    change_column_default :receipts, :data, {}
  end
end
