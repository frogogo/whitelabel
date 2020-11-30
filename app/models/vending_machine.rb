# == Schema Information
#
# Table name: vending_machines
#
#  id                      :bigint           not null, primary key
#  active                  :boolean          default(FALSE), not null
#  address                 :string           not null
#  vending_cells_columns   :integer          not null
#  vending_cells_rows      :integer          not null
#  vm_type                 :integer          default("virtual"), not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  distribution_network_id :bigint
#  public_id               :integer          not null
#
# Indexes
#
#  index_vending_machines_on_distribution_network_id  (distribution_network_id)
#  index_vending_machines_on_public_id                (public_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (distribution_network_id => distribution_networks.id)
#
class VendingMachine < ApplicationRecord
  include Assignable

  PUBLIC_ID_LENGTH = 8
  PUBLIC_ID_MAX_NUMBER = 99_999_999

  enum vm_type: {
    virtual: 0
  }

  belongs_to :distribution_network

  has_many :vending_cells, -> { order(row: :asc, column: :asc) },
           dependent: :destroy, inverse_of: :vending_machine
  has_many :items, through: :vending_cells

  before_create :set_public_id, if: -> { public_id.blank? }

  after_create_commit :create_vending_cells

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }

  def place_item(item, quantity, column, row)
    vending_cells.find_by(column: column, row: row).update!(item: item, quantity: quantity)
  end

  def take_item(item, receipt, vending_cell_id = nil)
    return :'item_not_taken.item_inactive' unless item.active?
    return :'item_not_taken.receipt_not_approved' unless receipt.approved?
    return :'item_not_taken.promotion_inactive' unless receipt.promotion.active?
    return :'item_not_taken.wrong_promotion' unless receipt.promotion == item.promotion

    if vending_cell_id.present?
      vending_cell = vending_cells.find(vending_cell_id)

      return :'item_not_taken.unavailable' if vending_cell.blank?
      return :'item_not_taken.out_of_stock' if vending_cell.empty?
      return :'item_not_taken.unavailable' if vending_cell.item != item
    end

    item_state_for_receipt = item.state_for(receipt)
    return :"item_not_taken.#{item_state_for_receipt}" unless item_state_for_receipt == :available

    options = { id: vending_cell_id, item: item }.compact
    VendingMachineInterface.take_item(self, receipt, options)

    :ok
  end

  private

  def create_vending_cells
    (1..vending_cells_rows).each do |row|
      (1..vending_cells_columns).each do |column|
        vending_cells.create!(column: column, row: row)
      end
    end
  end

  def generate_public_id
    SecureRandom.random_number(PUBLIC_ID_MAX_NUMBER).to_s.rjust(PUBLIC_ID_LENGTH, '0')
  end

  def set_public_id
    self.public_id = generate_public_id
  end
end
