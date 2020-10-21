Trestle.resource(:vending_machines) do
  menu do
    item :vending_machines, icon: 'fa fa-star'
  end

  scopes do
    scope :all
    scope :active, -> { VendingMachine.active }
    scope :inactive, -> { VendingMachine.inactive }
  end

  search do |query|
    if query
      VendingMachine.where('public_id = ?', query)
    else
      VendingMachine.all
    end
  end

  # Customize the table columns shown on the index view.

  table do
    column :public_id, label: 'Public ID'
    column :active
    column :address
    column :distribution_network
    column :created_at, align: :center
    actions
  end

  # Customize the form fields shown on the new/edit views.

  form do |_vending_machine|
    check_box :active
    text_field :address
    text_field :vending_cells_columns
    text_field :vending_cells_rows
    text_field :public_id, label: 'Public ID'
    select :vm_type, VendingMachine.vm_types.keys
    select :distribution_network_id, DistributionNetwork.all, include_blank: true
  end

  params do |params|
    params.require(:vending_machine)
          .permit(:active, :address, :vending_cells_columns, :vending_cells_rows,
                  :distribution_network_id, :public_id)
  end
end
