class CreatePromotions < ActiveRecord::Migration[6.0]
  def change
    create_table :promotions do |t|
      t.string :api_token, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
