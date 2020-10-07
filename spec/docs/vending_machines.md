## Assign vending machine

- id - public_id

```http
POST http://localhost:3000/api/vending_machines/75576448/assign HTTP/1.1
API-Version: 1
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2MDE5ODYzNDEsInN1YiI6MX0.HkHZ7bS3Oi9pcTtkY5H9xVRT05XUexAIvZdSzxMNJCQ
Accept: application/json
Content-Type: application/json

{
  "qr_string": "t=20200923T0940&s=911.00&fn=9289000100597234&i=57908&fp=1791342888&n=1"
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
        "image": "https://poprobuy.ru.s3.eu-central-1.amazonaws.com/9c9ea8235133f80b879221adc82eeb94eafbd347/glazed_dark_vanilla.jpg",
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
        "image": "https://poprobuy.ru.s3.eu-central-1.amazonaws.com/bcb0784f0f7c2f741ea3ccd49d47b47f2d5969cb/glazed_milk_caramel.jpg",
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
        "image": "https://poprobuy.ru.s3.eu-central-1.amazonaws.com/e90a9e213fb112d8a050a365d4141d4f2bbb49d8/glazed_milk_curd.jpg",
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
        "image": "https://poprobuy.ru.s3.eu-central-1.amazonaws.com/d6895eed3785863607245aa0c9a23fe0875d3bf1/glazed_dark_curd.jpg.jpg",
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
Content-Type: application/json

{
  "item_id": 1,
  "column": 1,
  "row": 1,
  "qr_string": "t=20200923T0940&s=911.00&fn=9289000100597234&i=57908&fp=1791342888&n=1"
}
```

### Response:

- 200: OK
- 401: Unauthorized
- 422: Unprocessable Entity
