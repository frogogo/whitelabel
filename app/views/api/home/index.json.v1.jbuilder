json.promotion do
  json.name 'Чайник электрический Sabatier'
  json.photo do
    json.thumb 'https://sboom.herokuapp.com/images/sboom_sabatier_thumb.jpg'
    json.large 'https://sboom.herokuapp.com/images/sboom_sabatier_large.jpg'
  end
  json.steps do
    json.array! ['Шаг 1', 'Шаг 2']
  end
end

json.coupon do
  json.name 'Чайник электрический Sabatier'
  json.photo do
    json.thumb 'https://sboom.herokuapp.com/images/sboom_sabatier_thumb.jpg'
    json.large 'https://sboom.herokuapp.com/images/sboom_sabatier_large.jpg'
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
