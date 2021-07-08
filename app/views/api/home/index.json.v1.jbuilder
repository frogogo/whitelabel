json.promotion do
  json.name 'Электрический чайник Lion Sabatier International'
  json.price 1999
  json.discounted_price 1
  json.photo do
    json.thumb 'https://sboom.herokuapp.com/images/sboom_sabatier_thumb.jpg'
    json.large 'https://sboom.herokuapp.com/images/sboom_sabatier_large.jpg'
  end
  json.steps do
    json.array!(
      [
        'Сканируй чеки из магазинов «Семья», в которых есть любые товары из акционной коллекции Lion Sabatier International',
        'После того, как ты соберешь товаров на 3 300 ₽, ты получишь купон для покупки электрического чайника Lion Sabatier International за 1 ₽'
      ]
    )
  end
end

json.coupon do
  json.name 'Электрический чайник Lion Sabatier International'
  json.photo do
    json.thumb 'https://sboom.herokuapp.com/images/sboom_sabatier_thumb.jpg'
    json.large 'https://sboom.herokuapp.com/images/sboom_sabatier_large.jpg'
  end
  json.steps do
    json.array!(
      [
        'Предъявите кассиру полученный Вами купон в момент расчета за покупку акционного электрочайника',
        'После активации скидки Вы сможете приобрести изделие всего за 1 ₽',
        'Полученная Вами скидка не заменяется денежной компенсацией',
        'В период проведения акции возможно временное отсутствие в торговом зале полного ассортимента акционного товара, в этом случае претензии не принимаются',
        'Внимание! Количество товаров, участвующих в акции, ограничено'
      ]
    )
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
