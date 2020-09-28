class RemoveNotNullConstraintFromItemIdInVendingCells < ActiveRecord::Migration[6.0]
  def change
    change_column_null :vending_cells, :item_id, true
  end
end
