Trestle.resource(:vending_cells) do
  menu do
    item :vending_cells, icon: 'fa fa-star'
  end

  scopes do
    scope :all
    scope :full, -> { VendingCell.full }
    scope :empty, -> { VendingCell.empty }
  end

  search do |query|
    if query
      VendingCell.joins(:vending_machine).where('vending_machines.public_id = ?', query)
    else
      VendingCell.all
    end
  end

  # Customize the table columns shown on the index view.

  table do
    column :vending_machine do |vending_cell|
      admin_link_to vending_cell.vending_machine.public_id, vending_cell.vending_machine
    end
    column :column
    column :row
    column :item
    column :quantity
    actions
  end

  # Customize the form fields shown on the new/edit views.

  form do |vending_cell|
    text_field :vending_machine, value: vending_cell.vending_machine.public_id, disabled: true
    text_field :column, disabled: true
    text_field :row, disabled: true
    text_field :quantity
    select :item_id, Item.all, include_blank: true
  end

  params do |params|
    params.require(:vending_cell).permit(:quantity, :item_id)
  end
end
