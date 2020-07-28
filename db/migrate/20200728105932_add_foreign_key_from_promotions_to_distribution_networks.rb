class AddForeignKeyFromPromotionsToDistributionNetworks < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :promotions, :distribution_networks
  end
end
