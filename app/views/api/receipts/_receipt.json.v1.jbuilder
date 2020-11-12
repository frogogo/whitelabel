json.cache! receipt do
  json.extract! receipt, :id, :number, :sum, :state, :timestamp

  if receipt.reject_reason.present?
    json.reject_reason do
      json.reason receipt.reject_reason
      json.reason_text receipt.reject_reason_text
    end
  end

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
