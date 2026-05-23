# Data dictionary - Billing domain

- `proforma_invoice`
- `invoice`
- `partial_payment`
- `invoice_detail`

## Table `proforma_invoice`

**Description:** Stores proforma invoices calculated for a stay or reservation.

| Field                   | Data type         | Required | Key    | Reference                | Default value         | Description                            |
| ----------------------- | ----------------- | -------: | ------ | ------------------------ | --------------------- | -------------------------------------- |
| `id`                  | `UUID`          |      Yes | PK     | -                        | `gen_random_uuid()` | Unique record identifier.              |
| `stay_id`             | `UUID`          |      Yes | FK, UK | `stay(id)`             | -                     | Related stay record.                   |
| `room_reservation_id` | `UUID`          |      Yes | FK     | `room_reservation(id)` | -                     | Related room_reservation record.       |
| `customer_id`         | `UUID`          |      Yes | FK     | `customer(id)`         | -                     | Related customer record.               |
| `subtotal`            | `NUMERIC(12,2)` |      Yes | -      | -                        | `0`                 | Subtotal.                              |
| `tax_amount`          | `NUMERIC(12,2)` |      Yes | -      | -                        | `0`                 | Tax amount.                            |
| `discount_amount`     | `NUMERIC(12,2)` |      Yes | -      | -                        | `0`                 | Discount amount.                       |
| `total_amount`        | `NUMERIC(12,2)` |      Yes | -      | -                        | `0`                 | Total amount.                          |
| `created_by`          | `UUID`          |       No | -      | -                        | -                     | User who created the record.           |
| `created_at`          | `TIMESTAMP`     |      Yes | -      | -                        | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by`          | `UUID`          |       No | -      | -                        | -                     | User who updated the record.           |
| `updated_at`          | `TIMESTAMP`     |       No | -      | -                        | -                     | Update date and time.                  |
| `deleted_by`          | `UUID`          |       No | -      | -                        | -                     | User who logically deleted the record. |
| `deleted_at`          | `TIMESTAMP`     |       No | -      | -                        | -                     | Logical deletion date and time.        |
| `status`              | `VARCHAR(30)`   |      Yes | -      | -                        | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT uk_proforma_invoice_stay UNIQUE (stay_id)`
- `CONSTRAINT fk_proforma_invoice_stay FOREIGN KEY (stay_id) REFERENCES stay (id)`
- `CONSTRAINT fk_proforma_invoice_reservation FOREIGN KEY (room_reservation_id) REFERENCES room_reservation (id)`
- `CONSTRAINT fk_proforma_invoice_customer FOREIGN KEY (customer_id) REFERENCES customer (id)`
- `CONSTRAINT ck_proforma_invoice_values CHECK (subtotal >= 0 AND tax_amount >= 0 AND discount_amount >= 0 AND total_amount >= 0)`

**Indexes:**

- `ix_proforma_invoice_reservation (room_reservation_id)`
- `ix_proforma_invoice_customer (customer_id)`

## Table `invoice`

**Description:** Stores invoices issued to customers.

| Field               | Data type         | Required | Key    | Reference        | Default value         | Description                            |
| ------------------- | ----------------- | -------: | ------ | ---------------- | --------------------- | -------------------------------------- |
| `id`              | `UUID`          |      Yes | PK     | -                | `gen_random_uuid()` | Unique record identifier.              |
| `customer_id`     | `UUID`          |      Yes | FK     | `customer(id)` | -                     | Related customer record.               |
| `stay_id`         | `UUID`          |      Yes | FK, UK | `stay(id)`     | -                     | Related stay record.                   |
| `invoice_number`  | `VARCHAR(60)`   |      Yes | UK     | -                | -                     | Invoice number.                        |
| `issued_at`       | `TIMESTAMP`     |      Yes | -      | -                | `CURRENT_TIMESTAMP` | Issue date and time.                   |
| `subtotal`        | `NUMERIC(12,2)` |      Yes | -      | -                | `0`                 | Subtotal.                              |
| `tax_amount`      | `NUMERIC(12,2)` |      Yes | -      | -                | `0`                 | Tax amount.                            |
| `discount_amount` | `NUMERIC(12,2)` |      Yes | -      | -                | `0`                 | Discount amount.                       |
| `total_amount`    | `NUMERIC(12,2)` |      Yes | -      | -                | `0`                 | Total amount.                          |
| `invoice_status`  | `VARCHAR(40)`   |      Yes | -      | -                | `'ISSUED'`          | Invoice status.                        |
| `created_by`      | `UUID`          |       No | -      | -                | -                     | User who created the record.           |
| `created_at`      | `TIMESTAMP`     |      Yes | -      | -                | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by`      | `UUID`          |       No | -      | -                | -                     | User who updated the record.           |
| `updated_at`      | `TIMESTAMP`     |       No | -      | -                | -                     | Update date and time.                  |
| `deleted_by`      | `UUID`          |       No | -      | -                | -                     | User who logically deleted the record. |
| `deleted_at`      | `TIMESTAMP`     |       No | -      | -                | -                     | Logical deletion date and time.        |
| `status`          | `VARCHAR(30)`   |      Yes | -      | -                | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT uk_invoice_number UNIQUE (invoice_number)`
- `CONSTRAINT uk_invoice_stay UNIQUE (stay_id)`
- `CONSTRAINT fk_invoice_customer FOREIGN KEY (customer_id) REFERENCES customer (id)`
- `CONSTRAINT fk_invoice_stay FOREIGN KEY (stay_id) REFERENCES stay (id)`
- `CONSTRAINT ck_invoice_values CHECK (subtotal >= 0 AND tax_amount >= 0 AND discount_amount >= 0 AND total_amount >= 0)`

**Indexes:**

- `ix_invoice_customer (customer_id)`

## Table `partial_payment`

**Description:** Stores partial payments against reservations or invoices.

| Field                   | Data type         | Required | Key | Reference                | Default value         | Description                            |
| ----------------------- | ----------------- | -------: | --- | ------------------------ | --------------------- | -------------------------------------- |
| `id`                  | `UUID`          |      Yes | PK  | -                        | `gen_random_uuid()` | Unique record identifier.              |
| `room_reservation_id` | `UUID`          |       No | FK  | `room_reservation(id)` | -                     | Related room_reservation record.       |
| `invoice_id`          | `UUID`          |       No | FK  | `invoice(id)`          | -                     | Related invoice record.                |
| `payment_method_id`   | `UUID`          |      Yes | FK  | `payment_method(id)`   | -                     | Related payment_method record.         |
| `amount`              | `NUMERIC(12,2)` |      Yes | -   | -                        | -                     | Monetary amount.                       |
| `paid_at`             | `TIMESTAMP`     |      Yes | -   | -                        | `CURRENT_TIMESTAMP` | Payment date and time.                 |
| `payment_reference`   | `VARCHAR(120)`  |       No | -   | -                        | -                     | Payment reference.                     |
| `created_by`          | `UUID`          |       No | -   | -                        | -                     | User who created the record.           |
| `created_at`          | `TIMESTAMP`     |      Yes | -   | -                        | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by`          | `UUID`          |       No | -   | -                        | -                     | User who updated the record.           |
| `updated_at`          | `TIMESTAMP`     |       No | -   | -                        | -                     | Update date and time.                  |
| `deleted_by`          | `UUID`          |       No | -   | -                        | -                     | User who logically deleted the record. |
| `deleted_at`          | `TIMESTAMP`     |       No | -   | -                        | -                     | Logical deletion date and time.        |
| `status`              | `VARCHAR(30)`   |      Yes | -   | -                        | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT fk_partial_payment_reservation FOREIGN KEY (room_reservation_id) REFERENCES room_reservation (id)`
- `CONSTRAINT fk_partial_payment_invoice FOREIGN KEY (invoice_id) REFERENCES invoice (id)`
- `CONSTRAINT fk_partial_payment_method FOREIGN KEY (payment_method_id) REFERENCES payment_method (id)`
- `CONSTRAINT ck_partial_payment_amount CHECK (amount > 0)`
- `CONSTRAINT ck_partial_payment_source CHECK (room_reservation_id IS NOT NULL OR invoice_id IS NOT NULL)`

**Indexes:**

- `ix_partial_payment_reservation (room_reservation_id)`
- `ix_partial_payment_invoice (invoice_id)`
- `ix_partial_payment_method (payment_method_id)`

## Table `invoice_detail`

**Description:** Stores invoice line items.

| Field            | Data type         | Required | Key | Reference       | Default value         | Description                            |
| ---------------- | ----------------- | -------: | --- | --------------- | --------------------- | -------------------------------------- |
| `id`           | `UUID`          |      Yes | PK  | -               | `gen_random_uuid()` | Unique record identifier.              |
| `invoice_id`   | `UUID`          |      Yes | FK  | `invoice(id)` | -                     | Related invoice record.                |
| `product_id`   | `UUID`          |       No | FK  | `product(id)` | -                     | Related product record.                |
| `service_id`   | `UUID`          |       No | FK  | `service(id)` | -                     | Related service record.                |
| `description`  | `VARCHAR(255)`  |      Yes | -   | -               | -                     | Description.                           |
| `quantity`     | `INTEGER`       |      Yes | -   | -               | -                     | Quantity.                              |
| `unit_price`   | `NUMERIC(12,2)` |      Yes | -   | -               | -                     | Unit price.                            |
| `total_amount` | `NUMERIC(12,2)` |      Yes | -   | -               | -                     | Total amount.                          |
| `created_by`   | `UUID`          |       No | -   | -               | -                     | User who created the record.           |
| `created_at`   | `TIMESTAMP`     |      Yes | -   | -               | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by`   | `UUID`          |       No | -   | -               | -                     | User who updated the record.           |
| `updated_at`   | `TIMESTAMP`     |       No | -   | -               | -                     | Update date and time.                  |
| `deleted_by`   | `UUID`          |       No | -   | -               | -                     | User who logically deleted the record. |
| `deleted_at`   | `TIMESTAMP`     |       No | -   | -               | -                     | Logical deletion date and time.        |
| `status`       | `VARCHAR(30)`   |      Yes | -   | -               | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT fk_invoice_detail_invoice FOREIGN KEY (invoice_id) REFERENCES invoice (id)`
- `CONSTRAINT fk_invoice_detail_product FOREIGN KEY (product_id) REFERENCES product (id)`
- `CONSTRAINT fk_invoice_detail_service FOREIGN KEY (service_id) REFERENCES service (id)`
- `CONSTRAINT ck_invoice_detail_values CHECK (quantity > 0 AND unit_price >= 0 AND total_amount >= 0)`
- `CONSTRAINT ck_invoice_detail_item CHECK (product_id IS NOT NULL OR service_id IS NOT NULL)`

**Indexes:**

- `ix_invoice_detail_invoice (invoice_id)`
- `ix_invoice_detail_product (product_id)`
- `ix_invoice_detail_service (service_id)`
