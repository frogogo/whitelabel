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
#  vending_machine_id :bigint
#
# Indexes
#
#  index_vending_cells_on_vending_machine_id  (vending_machine_id)
#
# Foreign Keys
#
#  fk_rails_...  (vending_machine_id => vending_machines.id)
#
require 'rails_helper'

RSpec.describe VendingCell, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
