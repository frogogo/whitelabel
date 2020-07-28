class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.belongs_to :manufacturer, foreign_key: true
      t.belongs_to :promotion, foreign_key: true

      t.string :name, null: false
      t.string :bar_code, null: false
      t.string :size, null: false

      t.timestamps
    end
    add_column :vending_cells, :item_id, :bigint, null: false
    add_index :vending_cells, :item_id
    add_foreign_key :vending_cells, :items
  end
end
