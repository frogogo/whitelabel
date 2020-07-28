class CreateManufacturers < ActiveRecord::Migration[6.0]
  def change
    create_table :manufacturers do |t|
      t.string :name, null: false, index: { unique: true }

      t.string :account
      t.string :business_address
      t.string :chief_executive_officer
      t.string :constact_person
      t.string :taxpayer_identification_number
      t.string :tax_registration_reason_code

      t.string :email
      t.string :phone_number

      t.timestamps
    end
  end
end
