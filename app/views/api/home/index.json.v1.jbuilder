if @receipt.present? && !@receipt.completed?
  json.receipt do
    json.partial! 'api/receipts/receipt', receipt: @receipt
  end
end
