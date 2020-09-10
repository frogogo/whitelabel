class AddRefreshTokenToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :refresh_token, :string, null: false
    add_index :users, :refresh_token, unique: true
  end
end
