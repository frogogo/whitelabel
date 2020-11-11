json.cache! receipt do
  json.extract! receipt, :id, :number, :sum, :state, :timestamp

  json.reject_reason receipt.reject_reason if receipt.reject_reason.present?

  if receipt.approved? || receipt.completed?
    json.distribution_network do
      json.partial! receipt.promotion.distribution_network, as: :distribution_network
    end

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
