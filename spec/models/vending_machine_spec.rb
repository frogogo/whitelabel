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
require 'rails_helper'

RSpec.describe VendingMachine, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
