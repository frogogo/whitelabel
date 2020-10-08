class AddActiveFiledsToItemsAndPromotions < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :active, :boolean, default: false
    add_column :promotions, :active, :boolean, default: false
  end
end
