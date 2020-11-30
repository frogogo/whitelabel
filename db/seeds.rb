Administrator.create!(
  email: 'admin@poprobuy.ru',
  password: 'qwerty123',
  first_name: 'Admin',
  last_name: 'poprobuy.ru'
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

manufacturer = Manufacturer.create!(
  account: '40702810110000087777 в АО «Тинькофф Банк»',
  business_address: 'ул. Профсоюзная, д. 77, корп. 44, г. Москва, Российская Федерация, 117444',
  chief_executive_officer: 'Максимов Максим Максимович',
  constact_person: 'Светлова Светлана Светлановна',
  email: 'maksimov@tvorogskazka.ru',
  name: 'Творожная сказка',
  phone_number: '+7999221144',
  tax_registration_reason_code: '783901035',
  taxpayer_identification_number: '7839078357'
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

item1 = Item.create!(
  active: true,
  bar_code: '012345671',
  name: 'Сырок творожный глазированный в тёмном шоколаде',
  size: '10x6x3',
  manufacturer: manufacturer,
  promotion: promotion
)

File.open('spec/images/glazed_dark_vanilla.jpg') do |image|
  item1.image = image
end
item1.save!

item2 = Item.create!(
  active: true,
  bar_code: '012345672',
  name: 'Сырок творожный глазированный в белом шоколаде с карамелью',
  size: '10x6x3',
  manufacturer: manufacturer,
  promotion: promotion
)

File.open('spec/images/glazed_milk_caramel.jpg') do |image|
  item2.image = image
end
item2.save!

item3 = Item.create!(
  active: true,
  bar_code: '012345673',
  name: 'Сырок нежный с творожным зерном в молочном шоколаде',
  size: '10x6x3',
  manufacturer: manufacturer,
  promotion: promotion
)

File.open('spec/images/glazed_milk_curd.jpg') do |image|
  item3.image = image
end
item3.save!

item4 = Item.create!(
  active: true,
  bar_code: '012345674',
  name: 'Сырок нежный с творожным зерном в тёмном шоколаде',
  size: '10x6x3',
  manufacturer: manufacturer,
  promotion: promotion
)

File.open('spec/images/glazed_dark_curd.jpg') do |image|
  item4.image = image
end
item4.save!

vending_machine = VendingMachine.create!(
  active: true,
  address: 'Виртуальный аппарат',
  vending_cells_columns: 6,
  vending_cells_rows: 10,
  distribution_network: distribution_network
)

vending_machine.place_item(item1, rand(0..10), 1, 1)
vending_machine.place_item(item1, rand(0..10), 1, 2)
vending_machine.place_item(item1, rand(0..10), 1, 3)
vending_machine.place_item(item1, rand(0..10), 1, 4)
vending_machine.place_item(item1, rand(0..10), 1, 5)
vending_machine.place_item(item1, rand(0..10), 1, 6)

vending_machine.place_item(item2, rand(0..10), 2, 1)
vending_machine.place_item(item2, rand(0..10), 2, 2)
vending_machine.place_item(item2, rand(0..10), 2, 3)
vending_machine.place_item(item2, rand(0..10), 2, 4)
vending_machine.place_item(item2, rand(0..10), 2, 5)
vending_machine.place_item(item2, rand(0..10), 2, 6)

vending_machine.place_item(item3, rand(0..10), 3, 1)
vending_machine.place_item(item3, rand(0..10), 3, 2)
vending_machine.place_item(item3, rand(0..10), 3, 3)
vending_machine.place_item(item3, rand(0..10), 3, 4)
vending_machine.place_item(item3, rand(0..10), 3, 5)
vending_machine.place_item(item3, rand(0..10), 3, 6)

vending_machine.place_item(item4, rand(0..10), 4, 1)
vending_machine.place_item(item4, rand(0..10), 4, 2)
vending_machine.place_item(item4, rand(0..10), 4, 3)
vending_machine.place_item(item4, rand(0..10), 4, 4)
vending_machine.place_item(item4, rand(0..10), 4, 5)
vending_machine.place_item(item4, rand(0..10), 4, 6)

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
  item: item1,
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
