json.promotion do
  json.name 'Ножеточка Lion Sabatier'
  json.photo do
    json.thumb 'https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png'
    json.large 'https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png'
  end
  json.steps do
    json.array! ['Шаг 1', 'Шаг 2']
  end
end

json.coupon do
  json.name 'Ножеточка Lion Sabatier'
  json.photo do
    json.thumb 'https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png'
    json.large 'https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png'
  end
  json.steps do
    json.array! ['Шаг 1', 'Шаг 2']
  end
end

json.progress do
  json.current current_user.total_sum % Coupon::GIFT_THRESHOLD
  json.target Coupon::GIFT_THRESHOLD
end

json.receipts do
  json.array! @receipts, partial: 'api/receipts/receipt', as: :receipt
end

json.coupons do
  json.array! @coupons, partial: 'api/coupons/coupon', as: :coupon
end
