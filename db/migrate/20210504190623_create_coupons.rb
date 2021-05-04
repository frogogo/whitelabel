class CreateCoupons < ActiveRecord::Migration[6.1]
  def change
    create_table :coupons do |t|
      t.string :code
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
