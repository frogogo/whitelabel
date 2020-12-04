# == Schema Information
#
# Table name: items
#
#  id              :bigint           not null, primary key
#  active          :boolean          default(FALSE)
#  bar_code        :string           not null
#  image           :string
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

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :out_of_stock, -> { where(quantity: 0) }

  mount_uploader :image, ImageUploader

  def empty?
    quantity.zero?
  end

  def state_for(receipt, vending_cell)
    return :unavailable unless active? && promotion.active?
    return :unavailable unless receipt.approved?
    return :out_of_stock if empty? && vending_cell.empty?

    # TODO: change to :wrong_promotion later
    return :unavailable unless receipt.promotion == promotion
    return :already_received unless receipt.user.receipts.completed.where(item: self).none?

    :available
  end

  def update_quantity
    # TODO: move to background?
    update!(quantity: vending_cells.sum(:quantity))
  end
end
