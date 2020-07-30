if @receipt.present?
  json.receipt do
    json.partial! 'api/receipts/receipt', receipt: @receipt
  end
end
