## Index home


```http
GET https://poprobuy.ru/api/home HTTP/1.1
API-Version: 1
Accept: application/json
```

### Response:

- 200: OK

```json
{
  "receipt": {
    "id": 1,
    "number": 114318,
    "sum": 127,
    "state": "processing",
    "timestamp": "2019-01-13T15:48:00+07:00"
  }
}
```

- 200: OK, but receipt is missing
```json
{}
```
- 401: Unauthorized

