# == Schema Information
#
# Table name: manufacturers
#
#  id                             :bigint           not null, primary key
#  account                        :string
#  business_address               :string
#  chief_executive_officer        :string
#  constact_person                :string
#  email                          :string
#  name                           :string           not null
#  phone_number                   :string
#  tax_registration_reason_code   :string
#  taxpayer_identification_number :string
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#
# Indexes
#
#  index_manufacturers_on_name  (name) UNIQUE
#
require 'rails_helper'

RSpec.describe Manufacturer, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
