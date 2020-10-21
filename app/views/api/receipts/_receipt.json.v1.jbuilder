json.cache! receipt do
  json.extract! receipt, :number, :qr_string, :sum, :state, :timestamp

  json.reject_reason receipt.reject_reason if receipt.reject_reason.present?

  if receipt.approved? || receipt.completed?
    json.promotion do
      json.partial! receipt.promotion, as: :promotion
    end
  end

  if receipt.completed?
    json.item do
      json.partial! receipt.item, as: :item
    end
  end
end
