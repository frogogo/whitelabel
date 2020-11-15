## Index home


```http
GET https://poprobuy.ru/api/home HTTP/1.1
API-Version: 1
Accept: application/json
Accept-Language: ru-RU;q=1.0, en-RU;q=0.9
```

### Response:

- 200: OK

```json
{
  "receipt": {
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
}
```

- 200: OK, but receipt is missing
```json
{}
```
- 401: Unauthorized

