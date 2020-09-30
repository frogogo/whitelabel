json.partial! @vending_machine, as: :vending_machine

json.vending_cells do
  json.array! @vending_machine.vending_cells do |vending_cell|
    json.partial! vending_cell, as: :vending_cell
    if vending_cell.item.present?
      json.item do
        json.partial! vending_cell.item, as: :item
        json.avaliable_to_take vending_cell.item.avaliable_to_take?(@user)
      end
    end
  end
end
