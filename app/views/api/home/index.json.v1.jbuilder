json.promotion do
  json.name I18n.t('home.index.name')
  json.price I18n.t('home.index.price')
  json.discounted_price I18n.t('home.index.discounted_price')
  json.photo do
    json.thumb I18n.t('home.index.photo_thumb_url')
    json.large I18n.t('home.index.photo_url')
  end
  json.steps do
    2.times do |index|
      json.array!([I18n.t("home.index.promotion_step#{index + 1}")])
    end
  end
end

json.coupon do
  json.name I18n.t('home.index.name')
  json.photo do
    json.thumb I18n.t('home.index.photo_thumb_url')
    json.large I18n.t('home.index.photo_url')
  end
  json.steps do
    5.times do |index|
      json.array!([I18n.t("home.index.coupon_step#{index + 1}")])
    end
  end
end

json.progress do
  json.current current_user.total_sum.round % I18n.t('home.index.gift_threshold')
  json.target I18n.t('home.index.gift_threshold')
end

json.receipts do
  json.array! @receipts, partial: 'api/receipts/receipt', as: :receipt
end

json.coupons do
  json.array! @coupons, partial: 'api/coupons/coupon', as: :coupon
end
