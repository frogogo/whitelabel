class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :phone_number, null: false, index: { unique: true }
      t.string :first_name
      t.string :email

      t.timestamps
    end
  end
end
