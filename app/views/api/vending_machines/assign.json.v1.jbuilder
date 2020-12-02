json.partial! @vending_machine, as: :vending_machine

json.assign_expires_in @vending_machine.assign_expires_in

json.vending_cells do
  json.array! @vending_machine.vending_cells do |vending_cell|
    json.partial! vending_cell, as: :vending_cell
    if vending_cell.item.present?
      json.item do
        json.partial! vending_cell.item, as: :item
        json.state vending_cell.item.state_for(@receipt)
      end
    end
  end
end
