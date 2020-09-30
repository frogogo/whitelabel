# == Schema Information
#
# Table name: vending_machines
#
#  id                      :bigint           not null, primary key
#  active                  :boolean          default(FALSE), not null
#  address                 :string           not null
#  vending_cells_columns   :integer          not null
#  vending_cells_rows      :integer          not null
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
  ASSIGN_TIME = 60.seconds
  PUBLIC_ID_LENGTH = 8
  PUBLIC_ID_MAX_NUMBER = 99_999_999

  belongs_to :distribution_network

  has_many :vending_cells, dependent: :destroy

  before_create :set_public_id, if: -> { public_id.blank? }

  after_create_commit :create_vending_cells

  def assign(user)
    Rails.cache.write(assign_key, user.id, expires_in: ASSIGN_TIME)
  end

  def assigned?(user)
    assign_value == user.id
  end

  def busy?
    assign_value.positive?
  end

  def place_item(item, quantity, column, row)
    vending_cells.find_by(column: column, row: row).update!(item: item, quantity: quantity)
  end

  def take_item(item, column: nil, row: nil)
    options = { item: item, column: column, row: row }.compact
    vending_cell = vending_cells.active.find_by!(options)

    vending_cell.take_item
  end

  private

  def assign_key
    "venidng-machine:#{id}:assigned"
  end

  def assign_value
    @assign_value ||= Rails.cache.read(assign_key) || 0
  end

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
