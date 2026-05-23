# Data dictionary - Service delivery domain

- `room_reservation`
- `room_cancellation`
- `room_availability`
- `room_catalog`
- `stay`
- `check_in`
- `check_out`
- `product_sale`
- `service_sale`

## Table `room_reservation`

**Description:** Stores room reservations made by customers.

| Field                  | Data type         | Required | Key | Reference        | Default value         | Description                            |
| ---------------------- | ----------------- | -------: | --- | ---------------- | --------------------- | -------------------------------------- |
| `id`                 | `UUID`          |      Yes | PK  | -                | `gen_random_uuid()` | Unique record identifier.              |
| `customer_id`        | `UUID`          |      Yes | FK  | `customer(id)` | -                     | Related customer record.               |
| `room_id`            | `UUID`          |      Yes | FK  | `room(id)`     | -                     | Related room record.                   |
| `start_at`           | `TIMESTAMP`     |      Yes | -   | -                | -                     | Start date and time.                   |
| `end_at`             | `TIMESTAMP`     |      Yes | -   | -                | -                     | End date and time.                     |
| `guest_count`        | `SMALLINT`      |      Yes | -   | -                | -                     | Guest count.                           |
| `reservation_status` | `VARCHAR(40)`   |      Yes | -   | -                | `'PENDING'`         | Reservation status.                    |
| `estimated_amount`   | `NUMERIC(12,2)` |      Yes | -   | -                | `0`                 | Estimated amount.                      |
| `created_by`         | `UUID`          |       No | -   | -                | -                     | User who created the record.           |
| `created_at`         | `TIMESTAMP`     |      Yes | -   | -                | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by`         | `UUID`          |       No | -   | -                | -                     | User who updated the record.           |
| `updated_at`         | `TIMESTAMP`     |       No | -   | -                | -                     | Update date and time.                  |
| `deleted_by`         | `UUID`          |       No | -   | -                | -                     | User who logically deleted the record. |
| `deleted_at`         | `TIMESTAMP`     |       No | -   | -                | -                     | Logical deletion date and time.        |
| `status`             | `VARCHAR(30)`   |      Yes | -   | -                | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT fk_room_reservation_customer FOREIGN KEY (customer_id) REFERENCES customer (id)`
- `CONSTRAINT fk_room_reservation_room FOREIGN KEY (room_id) REFERENCES room (id)`
- `CONSTRAINT ck_room_reservation_dates CHECK (end_at > start_at)`
- `CONSTRAINT ck_room_reservation_values CHECK (guest_count > 0 AND estimated_amount >= 0)`

**Indexes:**

- `ix_room_reservation_customer (customer_id)`
- `ix_room_reservation_room_dates (room_id, start_at, end_at)`

## Table `room_cancellation`

**Description:** Stores reservation cancellations.

| Field                   | Data type         | Required | Key    | Reference                | Default value         | Description                            |
| ----------------------- | ----------------- | -------: | ------ | ------------------------ | --------------------- | -------------------------------------- |
| `id`                  | `UUID`          |      Yes | PK     | -                        | `gen_random_uuid()` | Unique record identifier.              |
| `room_reservation_id` | `UUID`          |      Yes | FK, UK | `room_reservation(id)` | -                     | Related room_reservation record.       |
| `reason`              | `VARCHAR(255)`  |      Yes | -      | -                        | -                     | Reason.                                |
| `cancelled_at`        | `TIMESTAMP`     |      Yes | -      | -                        | `CURRENT_TIMESTAMP` | Cancellation date and time.            |
| `applies_penalty`     | `BOOLEAN`       |      Yes | -      | -                        | `FALSE`             | Applies penalty.                       |
| `penalty_amount`      | `NUMERIC(12,2)` |      Yes | -      | -                        | `0`                 | Penalty amount.                        |
| `created_by`          | `UUID`          |       No | -      | -                        | -                     | User who created the record.           |
| `created_at`          | `TIMESTAMP`     |      Yes | -      | -                        | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by`          | `UUID`          |       No | -      | -                        | -                     | User who updated the record.           |
| `updated_at`          | `TIMESTAMP`     |       No | -      | -                        | -                     | Update date and time.                  |
| `deleted_by`          | `UUID`          |       No | -      | -                        | -                     | User who logically deleted the record. |
| `deleted_at`          | `TIMESTAMP`     |       No | -      | -                        | -                     | Logical deletion date and time.        |
| `status`              | `VARCHAR(30)`   |      Yes | -      | -                        | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT uk_room_cancellation_reservation UNIQUE (room_reservation_id)`
- `CONSTRAINT fk_room_cancellation_reservation FOREIGN KEY (room_reservation_id) REFERENCES room_reservation (id)`
- `CONSTRAINT ck_room_cancellation_penalty CHECK (penalty_amount >= 0)`

## Table `room_availability`

**Description:** Stores room availability or unavailability windows.

| Field                  | Data type        | Required | Key | Reference    | Default value         | Description                            |
| ---------------------- | ---------------- | -------: | --- | ------------ | --------------------- | -------------------------------------- |
| `id`                 | `UUID`         |      Yes | PK  | -            | `gen_random_uuid()` | Unique record identifier.              |
| `room_id`            | `UUID`         |      Yes | FK  | `room(id)` | -                     | Related room record.                   |
| `start_at`           | `TIMESTAMP`    |      Yes | -   | -            | -                     | Start date and time.                   |
| `end_at`             | `TIMESTAMP`    |      Yes | -   | -            | -                     | End date and time.                     |
| `is_available`       | `BOOLEAN`      |      Yes | -   | -            | `TRUE`              | Indicates availability.                |
| `unavailable_reason` | `VARCHAR(255)` |       No | -   | -            | -                     | Unavailability reason.                 |
| `created_by`         | `UUID`         |       No | -   | -            | -                     | User who created the record.           |
| `created_at`         | `TIMESTAMP`    |      Yes | -   | -            | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by`         | `UUID`         |       No | -   | -            | -                     | User who updated the record.           |
| `updated_at`         | `TIMESTAMP`    |       No | -   | -            | -                     | Update date and time.                  |
| `deleted_by`         | `UUID`         |       No | -   | -            | -                     | User who logically deleted the record. |
| `deleted_at`         | `TIMESTAMP`    |       No | -   | -            | -                     | Logical deletion date and time.        |
| `status`             | `VARCHAR(30)`  |      Yes | -   | -            | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT fk_room_availability_room FOREIGN KEY (room_id) REFERENCES room (id)`
- `CONSTRAINT ck_room_availability_dates CHECK (end_at > start_at)`

**Indexes:**

- `ix_room_availability_room_dates (room_id, start_at, end_at)`

## Table `room_catalog`

**Description:** Stores the commercial listing for a room.

| Field           | Data type         | Required | Key    | Reference    | Default value         | Description                            |
| --------------- | ----------------- | -------: | ------ | ------------ | --------------------- | -------------------------------------- |
| `id`          | `UUID`          |      Yes | PK     | -            | `gen_random_uuid()` | Unique record identifier.              |
| `room_id`     | `UUID`          |      Yes | FK, UK | `room(id)` | -                     | Related room record.                   |
| `title`       | `VARCHAR(160)`  |      Yes | -      | -            | -                     | Title.                                 |
| `description` | `TEXT`          |       No | -      | -            | -                     | Description.                           |
| `base_price`  | `NUMERIC(12,2)` |      Yes | -      | -            | `0`                 | Base price.                            |
| `is_visible`  | `BOOLEAN`       |      Yes | -      | -            | `TRUE`              | Visible in catalog.                    |
| `created_by`  | `UUID`          |       No | -      | -            | -                     | User who created the record.           |
| `created_at`  | `TIMESTAMP`     |      Yes | -      | -            | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by`  | `UUID`          |       No | -      | -            | -                     | User who updated the record.           |
| `updated_at`  | `TIMESTAMP`     |       No | -      | -            | -                     | Update date and time.                  |
| `deleted_by`  | `UUID`          |       No | -      | -            | -                     | User who logically deleted the record. |
| `deleted_at`  | `TIMESTAMP`     |       No | -      | -            | -                     | Logical deletion date and time.        |
| `status`      | `VARCHAR(30)`   |      Yes | -      | -            | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT uk_room_catalog_room UNIQUE (room_id)`
- `CONSTRAINT fk_room_catalog_room FOREIGN KEY (room_id) REFERENCES room (id)`
- `CONSTRAINT ck_room_catalog_base_price CHECK (base_price >= 0)`

## Table `stay`

**Description:** Stores actual customer stays.

| Field                   | Data type       | Required | Key    | Reference                | Default value         | Description                            |
| ----------------------- | --------------- | -------: | ------ | ------------------------ | --------------------- | -------------------------------------- |
| `id`                  | `UUID`        |      Yes | PK     | -                        | `gen_random_uuid()` | Unique record identifier.              |
| `room_reservation_id` | `UUID`        |      Yes | FK, UK | `room_reservation(id)` | -                     | Related room_reservation record.       |
| `customer_id`         | `UUID`        |      Yes | FK     | `customer(id)`         | -                     | Related customer record.               |
| `room_id`             | `UUID`        |      Yes | FK     | `room(id)`             | -                     | Related room record.                   |
| `start_at`            | `TIMESTAMP`   |      Yes | -      | -                        | -                     | Start date and time.                   |
| `end_at`              | `TIMESTAMP`   |       No | -      | -                        | -                     | End date and time.                     |
| `stay_status`         | `VARCHAR(40)` |      Yes | -      | -                        | `'ACTIVE'`          | Stay status.                           |
| `created_by`          | `UUID`        |       No | -      | -                        | -                     | User who created the record.           |
| `created_at`          | `TIMESTAMP`   |      Yes | -      | -                        | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by`          | `UUID`        |       No | -      | -                        | -                     | User who updated the record.           |
| `updated_at`          | `TIMESTAMP`   |       No | -      | -                        | -                     | Update date and time.                  |
| `deleted_by`          | `UUID`        |       No | -      | -                        | -                     | User who logically deleted the record. |
| `deleted_at`          | `TIMESTAMP`   |       No | -      | -                        | -                     | Logical deletion date and time.        |
| `status`              | `VARCHAR(30)` |      Yes | -      | -                        | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT uk_stay_reservation UNIQUE (room_reservation_id)`
- `CONSTRAINT fk_stay_reservation FOREIGN KEY (room_reservation_id) REFERENCES room_reservation (id)`
- `CONSTRAINT fk_stay_customer FOREIGN KEY (customer_id) REFERENCES customer (id)`
- `CONSTRAINT fk_stay_room FOREIGN KEY (room_id) REFERENCES room (id)`

**Indexes:**

- `ix_stay_customer (customer_id)`
- `ix_stay_room (room_id)`

## Table `check_in`

**Description:** Stores guest check-in events for reservations.

| Field                   | Data type       | Required | Key    | Reference                | Default value         | Description                            |
| ----------------------- | --------------- | -------: | ------ | ------------------------ | --------------------- | -------------------------------------- |
| `id`                  | `UUID`        |      Yes | PK     | -                        | `gen_random_uuid()` | Unique record identifier.              |
| `room_reservation_id` | `UUID`        |      Yes | FK, UK | `room_reservation(id)` | -                     | Related room_reservation record.       |
| `employee_id`         | `UUID`        |      Yes | FK     | `employee(id)`         | -                     | Related employee record.               |
| `checked_in_at`       | `TIMESTAMP`   |      Yes | -      | -                        | `CURRENT_TIMESTAMP` | Check-in date and time.                |
| `note`                | `TEXT`        |       No | -      | -                        | -                     | Note.                                  |
| `created_by`          | `UUID`        |       No | -      | -                        | -                     | User who created the record.           |
| `created_at`          | `TIMESTAMP`   |      Yes | -      | -                        | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by`          | `UUID`        |       No | -      | -                        | -                     | User who updated the record.           |
| `updated_at`          | `TIMESTAMP`   |       No | -      | -                        | -                     | Update date and time.                  |
| `deleted_by`          | `UUID`        |       No | -      | -                        | -                     | User who logically deleted the record. |
| `deleted_at`          | `TIMESTAMP`   |       No | -      | -                        | -                     | Logical deletion date and time.        |
| `status`              | `VARCHAR(30)` |      Yes | -      | -                        | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT uk_check_in_reservation UNIQUE (room_reservation_id)`
- `CONSTRAINT fk_check_in_reservation FOREIGN KEY (room_reservation_id) REFERENCES room_reservation (id)`
- `CONSTRAINT fk_check_in_employee FOREIGN KEY (employee_id) REFERENCES employee (id)`

**Indexes:**

- `ix_check_in_employee (employee_id)`

## Table `check_out`

**Description:** Stores guest check-out events and closing amounts.

| Field              | Data type         | Required | Key    | Reference        | Default value         | Description                            |
| ------------------ | ----------------- | -------: | ------ | ---------------- | --------------------- | -------------------------------------- |
| `id`             | `UUID`          |      Yes | PK     | -                | `gen_random_uuid()` | Unique record identifier.              |
| `stay_id`        | `UUID`          |      Yes | FK, UK | `stay(id)`     | -                     | Related stay record.                   |
| `employee_id`    | `UUID`          |      Yes | FK     | `employee(id)` | -                     | Related employee record.               |
| `checked_out_at` | `TIMESTAMP`     |      Yes | -      | -                | `CURRENT_TIMESTAMP` | Check-out date and time.               |
| `note`           | `TEXT`          |       No | -      | -                | -                     | Note.                                  |
| `total_amount`   | `NUMERIC(12,2)` |      Yes | -      | -                | `0`                 | Total amount.                          |
| `created_by`     | `UUID`          |       No | -      | -                | -                     | User who created the record.           |
| `created_at`     | `TIMESTAMP`     |      Yes | -      | -                | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by`     | `UUID`          |       No | -      | -                | -                     | User who updated the record.           |
| `updated_at`     | `TIMESTAMP`     |       No | -      | -                | -                     | Update date and time.                  |
| `deleted_by`     | `UUID`          |       No | -      | -                | -                     | User who logically deleted the record. |
| `deleted_at`     | `TIMESTAMP`     |       No | -      | -                | -                     | Logical deletion date and time.        |
| `status`         | `VARCHAR(30)`   |      Yes | -      | -                | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT uk_check_out_stay UNIQUE (stay_id)`
- `CONSTRAINT fk_check_out_stay FOREIGN KEY (stay_id) REFERENCES stay (id)`
- `CONSTRAINT fk_check_out_employee FOREIGN KEY (employee_id) REFERENCES employee (id)`
- `CONSTRAINT ck_check_out_total_amount CHECK (total_amount >= 0)`

**Indexes:**

- `ix_check_out_employee (employee_id)`

## Table `product_sale`

**Description:** Stores products consumed or sold during a stay.

| Field            | Data type         | Required | Key | Reference       | Default value         | Description                            |
| ---------------- | ----------------- | -------: | --- | --------------- | --------------------- | -------------------------------------- |
| `id`           | `UUID`          |      Yes | PK  | -               | `gen_random_uuid()` | Unique record identifier.              |
| `stay_id`      | `UUID`          |      Yes | FK  | `stay(id)`    | -                     | Related stay record.                   |
| `product_id`   | `UUID`          |      Yes | FK  | `product(id)` | -                     | Related product record.                |
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

- `CONSTRAINT fk_product_sale_stay FOREIGN KEY (stay_id) REFERENCES stay (id)`
- `CONSTRAINT fk_product_sale_product FOREIGN KEY (product_id) REFERENCES product (id)`
- `CONSTRAINT ck_product_sale_values CHECK (quantity > 0 AND unit_price >= 0 AND total_amount >= 0)`

**Indexes:**

- `ix_product_sale_stay (stay_id)`
- `ix_product_sale_product (product_id)`

## Table `service_sale`

**Description:** Stores services consumed or sold during a stay.

| Field            | Data type         | Required | Key | Reference       | Default value         | Description                            |
| ---------------- | ----------------- | -------: | --- | --------------- | --------------------- | -------------------------------------- |
| `id`           | `UUID`          |      Yes | PK  | -               | `gen_random_uuid()` | Unique record identifier.              |
| `stay_id`      | `UUID`          |      Yes | FK  | `stay(id)`    | -                     | Related stay record.                   |
| `service_id`   | `UUID`          |      Yes | FK  | `service(id)` | -                     | Related service record.                |
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

- `CONSTRAINT fk_service_sale_stay FOREIGN KEY (stay_id) REFERENCES stay (id)`
- `CONSTRAINT fk_service_sale_service FOREIGN KEY (service_id) REFERENCES service (id)`
- `CONSTRAINT ck_service_sale_values CHECK (quantity > 0 AND unit_price >= 0 AND total_amount >= 0)`

**Indexes:**

- `ix_service_sale_stay (stay_id)`
- `ix_service_sale_service (service_id)`
