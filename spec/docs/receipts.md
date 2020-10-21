## Index receipts

- limit(num) - optional param. Default: 100
- start_from(id) - optonal param.

States:
- processing
- approved
- completed
- rejected

Reject reasosnes:
- invalid_date (Неверная дата покупки)
- invalid_sum (Неверная сумма покупки)
- invalid_type (Неверный тип чека: ФСН, и т.д.)
- invalid_data (Не соответствует условиям акции)
- duplicate (Дубликат чека)
- system_error (Ошибка на сервере. Повторите позже или обратитесь в поддержку)

```http
GET https://poprobuy.ru/api/receipts?start_from=20&limit=50 HTTP/1.1
API-Version: 1
Accept: application/json
```

### Response:

- 200: OK

```json
[
  {
    "number": 57908,
    "qr_string": "t=20200923T0940&s=911.00&fn=9289000100597234&i=57908&fp=1791342888&n=1",
    "sum": 911,
    "state": "processing",
    "timestamp": "2020-09-23T09:40:00+03:00"
  },
  {
    "number": 57975,
    "qr_string": "t=20200116T0940&s=211.00&fn=9289000100597287&i=57975&fp=1791342857&n=1",
    "sum": 211,
    "state": "approved",
    "timestamp": "2020-01-16T09:40:00+03:00",
    "promotion": {
      "name": "Демо",
      "description": "Демо промо"
    }
  },
  {
    "number": 17796,
    "qr_string": "t=20200126T1029&s=7826.00&fn=9287440300193327&i=17796&fp=1898624280&n=1",
    "sum": 7826,
    "state": "completed",
    "timestamp": "2020-01-26T10:29:00+03:00",
    "promotion": {
      "name": "Демо",
      "description": "Демо промо"
    },
    "item": {
      "id": 1,
      "name": "Сырок творожный глазированный в тёмном шоколаде",
      "image_url": "https://poprobuy.ru/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19/glazed_dark_vanilla.jpg"
    }
  },
  {
    "number": 28346,
    "qr_string": "t=20191118T2057&s=3541.82&fn=8710000100379116&i=28346&fp=2845887721&n=1",
    "sum": 3541,
    "state": "rejected",
    "timestamp": "2019-11-18T20:57:00+03:00",
    "reject_reason": "invalid_data"
  },
  {
    "number": 114318,
    "qr_string": "t=20190113T154800&s=127.00&fn=8716000100025116&i=114318&fp=3578721819&n=1",
    "sum": 127,
    "state": "rejected",
    "timestamp": "2019-01-13T15:48:00+03:00",
    "reject_reason": "invalid_sum"
  },
  {
    "number": 2933,
    "qr_string": "t=20170329T183600&s=2999.00&fn=8710000100082706&i=2933&fp=182531010&n=1",
    "sum": 2999,
    "state": "rejected",
    "timestamp": "2017-03-29T18:36:00+03:00",
    "reject_reason": "invalid_date"
  }
]
```
- 401: Unauthorized

## Create receipt

```http
POST https://poprobuy.ru/api/receipts HTTP/1.1
API-Version: 1
Accept: application/json
Content-Type: application/json

{
  "qr_string": "t=20190113T154800&s=127.00&fn=8716000100025114&i=114318&fp=3578721879&n=1"
}
```

### Response:

- 201: Created
```json
{
  "number": 114318,
  "qr_string": "t=20200923T0940&s=911.00&fn=9289000100597234&i=57908&fp=1791342888&n=1",
  "sum": 127,
  "state": "processing",
  "timestamp": "2019-01-13T15:48:00+07:00"
}
```
- 422: Unprocessable Entity
```json
{
  "error": "qr_string_invalid"
}
```

- 422: Unprocessable Entity
```json
{
  "error": "qr_string_not_unique"
}
```

- 422: Unprocessable Entity
```json
{
  "error": "user_daily_limit_reached"
}
```
