class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :specs
      t.integer :price
      t.integer :discounted_price
      t.string :image_url
      t.belongs_to :promotion, foreign_key: true

      t.timestamps
    end
  end
end
