## Assign vending machine

- id - public_id

```http
POST http://localhost:3000/api/vending_machines/75576448/assign HTTP/1.1
API-Version: 1
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2MDE5ODYzNDEsInN1YiI6MX0.HkHZ7bS3Oi9pcTtkY5H9xVRT05XUexAIvZdSzxMNJCQ
Accept: application/json
Accept-Language: ru
Content-Type: application/json

{
  "receipt_id": 2
}

```

### Response:

- 200: OK

```json
{
  "address": "Виртуальный аппарат",
  "vending_cells_columns": 6,
  "vending_cells_rows": 10,
  "vending_cells": [
    {
      "column": 1,
      "quantity": 0,
      "row": 1,
      "item": {
        "id": 1,
        "name": "Сырок творожный глазированный в тёмном шоколаде",
        "image_url": "https://poprobuy.ru/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19/glazed_dark_vanilla.jpg",
        "avaliable_to_take": false
      }
    },
    {
      "column": 2,
      "quantity": 4,
      "row": 1,
      "item": {
        "id": 2,
        "name": "Сырок творожный глазированный в белом шоколаде с карамелью",
        "image_url": "https://poprobuy.ru/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19/glazed_milk_caramel.jpg",
        "avaliable_to_take": true
      }
    },
    {
      "column": 3,
      "quantity": 4,
      "row": 1,
      "item": {
        "id": 3,
        "name": "Сырок нежный с творожным зерном в молочном шоколаде",
        "image_url": "https://poprobuy.ru/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19/glazed_milk_curd.jpg",
        "avaliable_to_take": true
      }
    },
    {
      "column": 4,
      "quantity": 0,
      "row": 1,
      "item": {
        "id": 4,
        "name": "Сырок нежный с творожным зерном в тёмном шоколаде",
        "image_url": "https://poprobuy.ru/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19/glazed_dark_curd.jpg.jpg",
        "avaliable_to_take": true
      }
    },
    {
      "column": 5,
      "quantity": 0,
      "row": 1
    },
    {
      "column": 6,
      "quantity": 0,
      "row": 1
    }
  ]
}
```
- 401: Unauthorized
- 422: Unprocessable Entity

## Take item from vending machine

- id - public_id

```http
POST http://localhost:3000/api/vending_machines/75576448/take_item HTTP/1.1
API-Version: 1
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2MDE5ODYzNDEsInN1YiI6MX0.HkHZ7bS3Oi9pcTtkY5H9xVRT05XUexAIvZdSzxMNJCQ
Accept: application/json
Accept-Language: ru
Content-Type: application/json

{
  "column": 1,
  "row": 1,
  "item_id": 1,
  "receipt_id": 2
}
```

### Response:

- 200: OK
- 401: Unauthorized
- 422: Unprocessable Entity
