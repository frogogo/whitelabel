class AddUuidFieldToUsers < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'pgcrypto'
    add_column :users, :uuid, :uuid, default: 'gen_random_uuid()', null: false
  end
end
