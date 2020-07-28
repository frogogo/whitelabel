## Index receipts

- limit(num) - optional param. Default: 50
- start_from(id) - optonal param.

```http
GET https://poprobuy.ru/api/receipts HTTP/1.1
API-Version: 1
Accept: application/json
Content-Type: application/json

{
  "limit": 50,
  "start_from": 1
}
```

### Response:

- 200: OK

```json
{
  "phone_number": "+7999112233",
  "password_refresh_rate": 60
}
```
- 422: Unprocessable Entity
- 429: Too Many Requests

## Create receipt

States:
- processing
- approved
- completed
- rejected

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
[
  {
    "id": 1,
    "number": 114318,
    "sum": 127,
    "state": "processing",
    "timestamp": "2019-01-13T15:48:00+07:00"
  }
]
```
- 422: Unprocessable Entity
-