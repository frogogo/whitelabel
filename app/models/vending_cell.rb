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
#  item_id            :bigint
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

  scope :full, -> { where(quantity: 1..) }
  scope :empty, -> { where(quantity: 0) }

  after_update_commit :update_quantity_in_item, if: :saved_change_to_quantity?

  def take_item
    return if empty?

    decrement(:quantity) && save
  end

  def empty?
    quantity.zero?
  end

  private

  def update_quantity_in_item
    item.update_quantity
  end
end
