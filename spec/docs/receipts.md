## Index receipts

- limit(num) - optional param. Default: 100
- start_from(id) - optonal param.

States:
- processing
- approved
- completed
- rejected

Reject reasons:
- duplicate: Такой чек уже зарегистрирован в системе
- invalid_date: Дата покупки не соответствует условиям акции
- invalid_sum: Сумма покупки не соответствует условиям акции
- invalid_data: Содержимое чека не соответствует условиям акции
- limit_reached: Превышен лимит сканирования чеков
- system_error: Ошибка при обработке чека

```http
GET https://poprobuy.ru/api/receipts?start_from=20&limit=50 HTTP/1.1
API-Version: 1
Accept: application/json
Accept-Language: ru
```

### Response:

- 200: OK

```json
[
  {
    "id": 1,
    "number": 57908,
    "sum": 911,
    "state": "processing",
    "timestamp": "2020-09-23T09:40:00+03:00"
  },
  {
    "id": 2,
    "number": 57975,
    "sum": 211,
    "state": "approved",
    "timestamp": "2020-01-16T09:40:00+03:00",
    "distribution_network": {
      "name": "СуперМегаМаркет",
    },
    "promotion": {
      "name": "Демо",
    }
  },
  {
    "id": 3,
    "number": 17796,
    "sum": 7826,
    "state": "completed",
    "timestamp": "2020-01-26T10:29:00+03:00",
    "distribution_network": {
      "name": "СуперМегаМаркет",
    },
    "promotion": {
      "name": "Демо",
    },
    "item": {
      "id": 1,
      "name": "Сырок творожный глазированный в тёмном шоколаде",
      "image_url": "https://poprobuy-ru.s3.amazonaws.com/uploads/item/image/1/glazed_dark_vanilla.png",
      "image_medium_url": "https://poprobuy-ru.s3.amazonaws.com/uploads/item/image/1/medium_glazed_dark_vanilla.png"
    }
  },
  {
    "id": 4,
    "number": 28346,
    "sum": 3541,
    "state": "rejected",
    "timestamp": "2019-11-18T20:57:00+03:00",
    "reject_reason": {
      "reason": "invalid_data",
      "reason_text": "Содержимое чека не соответствует условиям акции"
    }
  },
  {
    "id": 5,
    "number": 114318,
    "sum": 127,
    "state": "rejected",
    "timestamp": "2019-01-13T15:48:00+03:00",
    "reject_reason": {
      "reason": "invalid_sum",
      "reason_text": "Сумма покупки не соответствует условиям акции"
    }
  },
  {
    "id": 6,
    "number": 2933,
    "sum": 2999,
    "state": "rejected",
    "timestamp": "2017-03-29T18:36:00+03:00",
    "reject_reason": {
      "reason": "invalid_date",
      "reason_text": "Дата покупки не соответствует условиям акции"
    }
  }
]
```
- 401: Unauthorized

## Create receipt

```http
POST https://poprobuy.ru/api/receipts HTTP/1.1
API-Version: 1
Accept: application/json
Accept-Language: ru
Content-Type: application/json

{
  "qr_string": "t=20190113T154800&s=127.00&fn=8716000100025114&i=114318&fp=3578721879&n=1"
}
```

### Response:

- 201: Created
```json
{
  "id": 7,
  "number": 114318,
  "sum": 127,
  "state": "processing",
  "timestamp": "2019-01-13T15:48:00+07:00"
}
```
- 422: Unprocessable Entity
```json
{
  "error": "blank",
  "error_text": "Отсутствует QR-код"
}
```

- 422: Unprocessable Entity
```json
{
  "error": "invalid",
  "error_text": "Данный QR-код не является чеком"
}
```

- 422: Unprocessable Entity
```json
{
  "error": "taken",
  "error_text": "Данный чек уже был отсканирован"
}
```

- 422: Unprocessable Entity
```json
{
  "error": "limit_reached",
  "error_text": "Превышен лимит сканирования чеков. Повторите через 23:46:31"
}
```

- 422: Unprocessable Entity
```json
{
  "error": "processing_receipt_exist",
  "error_text": "Один чек уже находится на проверке"
}
```
