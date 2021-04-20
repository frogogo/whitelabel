json.cache! receipt do
  json.extract! receipt, :id, :number, :sum, :state, :timestamp

  if receipt.reject_reason.present?
    json.reject_reason do
      json.reason receipt.reject_reason
      json.reason_text receipt.reject_reason_text
    end
  end
end
