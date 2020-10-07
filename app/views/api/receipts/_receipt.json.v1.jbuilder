json.cache! receipt do
  json.extract! receipt, :id, :number, :sum, :state, :timestamp, :promotion_id
end
