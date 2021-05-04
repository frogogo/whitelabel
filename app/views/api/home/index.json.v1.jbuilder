json.promotion do
  json.name 'Ножеточка Lion Sabatier'
  json.photo_url 'https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png'
  json.steps do
    json.array! ['Шаг 1', 'Шаг 2']
  end
end

json.coupon_progress do
  json.current_progress 0
  json.target_progress 3300
end

json.receipts do
  json.array! @receipts, partial: 'api/receipts/receipt', as: :receipt
end

json.coupons do
  json.array! @coupons, partial: 'api/coupons/coupon', as: :coupon
end
