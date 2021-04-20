Administrator.create!(
  email: 'foo@bar.com',
  password: 'qwerty123',
  first_name: 'Foo',
  last_name: 'Bar'
)

distribution_network = DistributionNetwork.create!(
  account: '40702810110000089999 в АО «Тинькофф Банк»',
  business_address: 'ул. Профсоюзная, д. 99, корп. 66, г. Москва, Российская Федерация, 117456',
  chief_executive_officer: 'Леонидов Леонид Леонидович',
  constact_person: 'Иванов Иван Иванович',
  email: 'leonidov@bigcompany.ru',
  name: 'СуперМегаМаркет',
  tax_registration_reason_code: '783901001',
  taxpayer_identification_number: '7839078339'
)

promotion = Promotion.create!(
  api_token: '012345678',
  active: true,
  description: 'Демо промо',
  name: 'Демо',
  promo_id: 123,
  distribution_network: distribution_network
)

user = User.create!(
  email: 'developer@poprobuy.ru',
  first_name: 'Разработчик',
  phone_number: '+79991113344',
  role: :developer
)

receipt1 = user.receipts.build(
  qr_string: 't=20200923T0940&s=911.00&fn=9289000100597234&i=57908&fp=1791342888&n=1',
  state: :processing
)
receipt1.save!(validate: false)

receipt2 = user.receipts.build(
  created_at: 3.days.ago,
  qr_string: 't=20200116T0940&s=211.00&fn=9289000100597287&i=57975&fp=1791342857&n=1',
  state: :approved,
  promotion: promotion
)
receipt2.save!(validate: false)

receipt3 = user.receipts.build(
  created_at: 4.days.ago,
  qr_string: 't=20200126T1029&s=7826.00&fn=9287440300193327&i=17796&fp=1898624280&n=1',
  state: :completed,
  promotion: promotion
)
receipt3.save!(validate: false)

receipt4 = user.receipts.build(
  created_at: 10.days.ago,
  qr_string: 't=20170329T183600&s=2999.00&fn=8710000100082706&i=2933&fp=182531010&n=1',
  reject_reason: :invalid_date,
  state: :rejected
)
receipt4.save!(validate: false)

receipt5 = user.receipts.build(
  created_at: 8.days.ago,
  qr_string: 't=20190113T154800&s=127.00&fn=8716000100025116&i=114318&fp=3578721819&n=1',
  reject_reason: :invalid_sum,
  state: :rejected
)
receipt5.save!(validate: false)

receipt6 = user.receipts.build(
  created_at: 7.days.ago,
  qr_string: 't=20191118T2057&s=3541.82&fn=8710000100379116&i=28346&fp=2845887721&n=1',
  reject_reason: :invalid_data,
  state: :rejected
)
receipt6.save!(validate: false)
