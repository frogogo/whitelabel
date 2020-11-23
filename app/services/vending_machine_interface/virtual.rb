# frozen_string_literal: true

class VendingMachineInterface::Virtual < VendingMachineInterface::Default
  def assign
    send_message("Assigned to #{user.phone_number}")
  end

  def take_item
    if vending_cell.empty?
      send_message("Unable to take item #{item.name} from cell " \
        "#{vending_cell.column}x#{vending_cell.row}. Quantity is #{vending_cell.quantity}")

      return
    end
    send_message("Taking item #{item.name} from cell #{vending_cell.row}x#{vending_cell.column}. " \
      "Quantity is #{vending_cell.quantity}")

    take_item_from_cell
    update_receipt

    send_message("Done. Now quantity is #{vending_cell.quantity}")

    true
  rescue StandardError => e
    send_message("Something went wrong – #{e}")
  end

  private

  def send_message(message)
    MessageSender.send_message(
      "Vending Machine: #{vending_machine.public_id}. Status: #{message}",
      vending_machine
    )
  end
end
