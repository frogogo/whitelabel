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
  name: 'Большая компания',
  phone_number: '+7999221133',
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
  description: 'Демо промо',
  name: 'Демо',
  distribution_network: distribution_network
)

user = User.create!(
  email: 'developer@poprobuy.ru',
  first_name: 'Разработчик',
  phone_number: '+7999113344',
  role: :developer
)

item1 = Item.create!(
  bar_code: '012345671',
  name: 'Сырок глазированный с клубникой',
  size: '10x6x3',
  image: File.open('specs/images/glazed_milk.png', 'rb'),
  manufacturer: manufacturer,
  promotion: promotion
)

item2 = Item.create!(
  bar_code: '012345672',
  name: 'Сырок глазированный со сгущенным молоком и орехом',
  size: '10x6x3',
  image: File.open('specs/images/glazed_strawberry.png', 'rb'),
  manufacturer: manufacturer,
  promotion: promotion
)

item3 = Item.create!(
  bar_code: '012345673',
  name: 'Сырок глазированный с клубникой',
  size: '10x6x3',
  image: File.open('specs/images/glazed_milk.png', 'rb'),
  manufacturer: manufacturer,
  promotion: promotion
)

item4 = Item.create!(
  bar_code: '012345674',
  name: 'Сырок глазированный со сгущенным молоком и орехом',
  size: '10x6x3',
  image: File.open('specs/images/glazed_strawberry.png', 'rb'),
  manufacturer: manufacturer,
  promotion: promotion
)

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

Receipt.create!(
  qr_string: '',
  user: user,
  state: :processing
)

Receipt.create!(
  qr_string: '',
  user: user,
  state: :approved,
  promotion: promotion
)

Receipt.create!(
  qr_string: '',
  user: user,
  state: :completed,
  item: item1,
  promotion: promotion
)

Receipt.create!(
  qr_string: '',
  user: user,
  reject_reason: :invalid_date,
  state: :rejected
)

Receipt.create!(
  qr_string: '',
  user: user,
  reject_reason: :invalid_sum,
  state: :rejected
)

Receipt.create!(
  qr_string: '',
  user: user,
  reject_reason: :invalid_distribution_network,
  state: :rejected
)
