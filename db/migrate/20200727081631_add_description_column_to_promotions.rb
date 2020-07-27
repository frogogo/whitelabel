class AddDescriptionColumnToPromotions < ActiveRecord::Migration[6.0]
  def change
    add_column :promotions, :description, :string
  end
end
