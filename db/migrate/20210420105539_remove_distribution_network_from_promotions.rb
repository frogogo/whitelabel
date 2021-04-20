class RemoveDistributionNetworkFromPromotions < ActiveRecord::Migration[6.1]
  def change
    remove_reference :promotions, :distribution_network, null: false, foreign_key: true
  end
end
