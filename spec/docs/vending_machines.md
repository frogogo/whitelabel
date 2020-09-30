## Show vending machine

- id - public_id

```http
GET http://localhost:3000/api/vending_machines/75576448 HTTP/1.1
API-Version: 1
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2MDE5ODYzNDEsInN1YiI6MX0.HkHZ7bS3Oi9pcTtkY5H9xVRT05XUexAIvZdSzxMNJCQ
Accept: application/json

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
      "column": 5,
      "quantity": 0,
      "row": 1
    },
    {
      "column": 6,
      "quantity": 0,
      "row": 1
    },
    {
      "column": 1,
      "quantity": 1,
      "row": 6,
      "item": {
        "id": 1,
        "name": "Сырок творожный глазированный в тёмном шоколаде",
        "image": "https://poprobuy.ru.s3.eu-central-1.amazonaws.com/9c9ea8235133f80b879221adc82eeb94eafbd347/glazed_dark_vanilla.jpg",
        "avaliable_to_take": false
      }
    },
    {
      "column": 2,
      "quantity": 2,
      "row": 1,
      "item": {
        "id": 2,
        "name": "Сырок творожный глазированный в белом шоколаде с карамелью",
        "image": "https://poprobuy.ru.s3.eu-central-1.amazonaws.com/bcb0784f0f7c2f741ea3ccd49d47b47f2d5969cb/glazed_milk_caramel.jpg",
        "avaliable_to_take": true
      }
    }
  ]
}
```
- 401: Unauthorized
- 422: Unprocessable Entity
