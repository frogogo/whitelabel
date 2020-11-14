# == Schema Information
#
# Table name: items
#
#  id              :bigint           not null, primary key
#  active          :boolean          default(FALSE)
#  bar_code        :string           not null
#  name            :string           not null
#  quantity        :integer
#  size            :string           not null
#  start_quantity  :integer
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

  has_many :vending_cells, dependent: :nullify
  has_many :receipts, dependent: :destroy

  has_one_attached :image

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :out_of_stock, -> { where(quantity: 0) }

  def available_to_take?(receipt)
    active? &&
      promotion.active? &&
      receipt.approved? &&
      receipt.promotion == promotion &&
      receipt.user.receipts.completed.where(item: self).none?
  end

  def update_quantity
    # TODO: move to background?
    update!(quantity: vending_cells.sum(:quantity))
  end
end
