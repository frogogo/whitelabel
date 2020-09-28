# == Schema Information
#
# Table name: vending_cells
#
#  id                 :bigint           not null, primary key
#  column             :integer          not null
#  quantity           :integer          default(0), not null
#  row                :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  item_id            :bigint           not null
#  vending_machine_id :bigint
#
# Indexes
#
#  index_vending_cells_on_item_id             (item_id)
#  index_vending_cells_on_vending_machine_id  (vending_machine_id)
#
# Foreign Keys
#
#  fk_rails_...  (item_id => items.id)
#  fk_rails_...  (vending_machine_id => vending_machines.id)
#
class VendingCell < ApplicationRecord
  belongs_to :item, optional: true
  belongs_to :vending_machine

  scope :active, -> { where(quantity: 1..) }

  def take_item
    return unless quantity.positive?

    decrement(:quantity)
  end

  def empty?
    quantity.zero?
  end
end
