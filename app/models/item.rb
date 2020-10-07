# == Schema Information
#
# Table name: items
#
#  id              :bigint           not null, primary key
#  bar_code        :string           not null
#  name            :string           not null
#  size            :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  manufacturer_id :bigint
#  promotion_id    :bigint
#
# Indexes
#
#  index_items_on_manufacturer_id  (manufacturer_id)
#  index_items_on_promotion_id     (promotion_id)
#
# Foreign Keys
#
#  fk_rails_...  (manufacturer_id => manufacturers.id)
#  fk_rails_...  (promotion_id => promotions.id)
#
class Item < ApplicationRecord
  belongs_to :manufacturer
  belongs_to :promotion

  has_many :vending_cell, dependent: :nullify
  has_many :receipts, dependent: :destroy

  has_one_attached :image

  def avaliable_to_take?(receipt)
    receipt.approved? &&
      receipt.promotion_id == promotion_id &&
      receipt.user.receipts.completed.where(item: self).none?
  end
end
