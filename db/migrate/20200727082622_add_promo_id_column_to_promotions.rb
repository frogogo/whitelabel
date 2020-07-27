class AddPromoIdColumnToPromotions < ActiveRecord::Migration[6.0]
  def change
    add_column :promotions, :promo_id, :integer, null: false
  end
end
