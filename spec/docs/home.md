## Index home


```http
GET https://poprobuy.ru/api/home HTTP/1.1
API-Version: 1
Accept: application/json
Accept-Language: ru-RU;q=1.0, en-RU;q=0.9
```

### Response:

- 200: OK

```jsonc
{
  "promotion": {
    "name": "Ножеточка Lion Sabatier",
    "photo": {
      "thumb": "logo.png",
      "large": "logon.png"
    },
    "steps": [
      "1. Минимальная сумма…",
      "2. С момента покупки…"
    ]
  },
  "coupon_progress": {
    "current_progress": 0,
    "target_progress": 3300
  },
  "receipts": [
    {
      "id": 1,
      "number": 57908,
      "sum": 911,
      "state": "processing",
      "timestamp": "2020-09-23T09:40:00Z",
      "reject_reason": {
        "reason": "duplicate",
        "reason_text": "Please try another receipt."
      }
    }
  ],
  "coupons": [
    {
      "id": 12321321,
      "qr_string": "kek=puk"
    }
  ]
}
```

- 200: OK, but receipt is missing
```json
{}
```
- 401: Unauthorized
