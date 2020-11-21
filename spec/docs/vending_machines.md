## Item states
- available
- already_received
- out_of_stock
- unavailable

## Assign vending machine

- id - public_id

```http
POST http://localhost:3000/api/vending_machines/75576448/assign HTTP/1.1
API-Version: 1
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2MDE5ODYzNDEsInN1YiI6MX0.HkHZ7bS3Oi9pcTtkY5H9xVRT05XUexAIvZdSzxMNJCQ
Accept: application/json
Accept-Language: ru-RU;q=1.0, en-RU;q=0.9
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
      "id": 1,
      "column": 1,
      "quantity": 0,
      "row": 1,
      "item": {
        "id": 1,
        "name": "Сырок творожный глазированный в тёмном шоколаде",
        "image_url": "https://poprobuy-ru.s3.amazonaws.com/uploads/item/image/1/glazed_dark_vanilla.png",
        "image_medium_url": "https://poprobuy-ru.s3.amazonaws.com/uploads/item/image/1/medium_glazed_dark_vanilla.png",
        "state": "out_of_stock"
      }
    },
    {
      "id": 2,
      "column": 2,
      "quantity": 4,
      "row": 1,
      "item": {
        "id": 2,
        "name": "Сырок творожный глазированный в белом шоколаде с карамелью",
        "image_url": "https://poprobuy-ru.s3.amazonaws.com/uploads/item/image/2/glazed_milk_caramel.png",
        "image_medium_url": "https://poprobuy-ru.s3.amazonaws.com/uploads/item/image/2/medium_glazed_milk_caramel.png",
        "state": "available"
      }
    },
    {
      "id": 3,
      "column": 3,
      "quantity": 4,
      "row": 1,
      "item": {
        "id": 3,
        "name": "Сырок нежный с творожным зерном в молочном шоколаде",
        "image_url": "https://poprobuy-ru.s3.amazonaws.com/uploads/item/image/3/glazed_milk_curd.png",
        "image_medium_url": "https://poprobuy-ru.s3.amazonaws.com/uploads/item/image/3/medium_glazed_milk_curd.png",
        "state": "available"
      }
    },
    {
      "id": 4,
      "column": 4,
      "quantity": 0,
      "row": 1,
      "item": {
        "id": 4,
        "name": "Сырок нежный с творожным зерном в тёмном шоколаде",
        "image_url": "https://poprobuy-ru.s3.amazonaws.com/uploads/item/image/4/glazed_dark_curd.png",
        "image_medium_url": "https://poprobuy-ru.s3.amazonaws.com/uploads/item/image/4/medium_glazed_dark_curd.png",
        "state": "available"
      }
    },
    {
      "id": 5,
      "column": 5,
      "quantity": 0,
      "row": 1
    },
    {
      "id": 6,
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
Accept-Language: ru-RU;q=1.0, en-RU;q=0.9
Content-Type: application/json

{
  "item_id": 1,
  "receipt_id": 2,
  "vending_cell_id": 1
}
```

### Response:

- 200: OK
- 401: Unauthorized
- 422: Unprocessable Entity
