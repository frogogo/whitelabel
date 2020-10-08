Trestle.resource(:manufacturers) do
  menu do
    item :manufacturers, icon: 'fa fa-star'
  end

  # Customize the table columns shown on the index view.

  table do
    column :name
    column :created_at, align: :center
    actions
  end

  # Customize the form fields shown on the new/edit views.

  form do |_manufacturer|
    text_field :account
    text_field :business_address
    text_field :chief_executive_officer
    text_field :constact_person
    text_field :email
    text_field :name
    text_field :phone_number
    text_field :tax_registration_reason_code
    text_field :taxpayer_identification_number
  end

  params do |params|
    params.require(:manufacturer)
          .permit(:account, :business_address, :chief_executive_officer, :constact_person,
                  :email, :name, :phone_number, :tax_registration_reason_code,
                  :taxpayer_identification_number)
  end
end
