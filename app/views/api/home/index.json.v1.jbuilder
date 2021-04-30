json.receipts do
  json.array! @receipts, partial: 'api/receipts/receipt', as: :receipt
end
