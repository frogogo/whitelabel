# == Schema Information
#
# Table name: promotions
#
#  id                      :bigint           not null, primary key
#  api_token               :string           not null
#  description             :string
#  name                    :string           not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  distribution_network_id :bigint           not null
#  promo_id                :integer          not null
#
# Indexes
#
#  index_promotions_on_distribution_network_id  (distribution_network_id)
#
# Foreign Keys
#
#  fk_rails_...  (distribution_network_id => distribution_networks.id)
#
class Promotion < ApplicationRecord
  belongs_to :distribution_network

  has_many :receipts, dependent: :destroy

  validates :api_token, presence: true
  validates :name, presence: true
  validates :promo_id, presence: true
end
