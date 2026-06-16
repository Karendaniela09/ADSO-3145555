# Data dictionary - Notifications domain

- `promotion`
- `alert`
- `term_condition`
- `customer_loyalty`

## Table `promotion`

**Description:** Stores promotions communicated through channels.

| Field           | Data type        | Required | Key | Reference | Default value         | Description                            |
| --------------- | ---------------- | -------: | --- | --------- | --------------------- | -------------------------------------- |
| `id`          | `UUID`         |      Yes | PK  | -         | `gen_random_uuid()` | Unique record identifier.              |
| `title`       | `VARCHAR(160)` |      Yes | -   | -         | -                     | Title.                                 |
| `description` | `TEXT`         |       No | -   | -         | -                     | Description.                           |
| `start_at`    | `TIMESTAMP`    |      Yes | -   | -         | -                     | Start date and time.                   |
| `end_at`      | `TIMESTAMP`    |       No | -   | -         | -                     | End date and time.                     |
| `channel`     | `VARCHAR(60)`  |      Yes | -   | -         | -                     | Communication channel.                 |
| `is_active`   | `BOOLEAN`      |      Yes | -   | -         | `TRUE`              | Indicates whether it is active.        |
| `created_by`  | `UUID`         |       No | -   | -         | -                     | User who created the record.           |
| `created_at`  | `TIMESTAMP`    |      Yes | -   | -         | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by`  | `UUID`         |       No | -   | -         | -                     | User who updated the record.           |
| `updated_at`  | `TIMESTAMP`    |       No | -   | -         | -                     | Update date and time.                  |
| `deleted_by`  | `UUID`         |       No | -   | -         | -                     | User who logically deleted the record. |
| `deleted_at`  | `TIMESTAMP`    |       No | -   | -         | -                     | Logical deletion date and time.        |
| `status`      | `VARCHAR(30)`  |      Yes | -   | -         | `'ACTIVE'`          | Logical record status.                 |

**Indexes:**

- `ix_promotion_dates (start_at, end_at)`

## Table `alert`

**Description:** Stores alerts or messages sent to customers.

| Field                   | Data type        | Required | Key | Reference                | Default value         | Description                            |
| ----------------------- | ---------------- | -------: | --- | ------------------------ | --------------------- | -------------------------------------- |
| `id`                  | `UUID`         |      Yes | PK  | -                        | `gen_random_uuid()` | Unique record identifier.              |
| `customer_id`         | `UUID`         |       No | FK  | `customer(id)`         | -                     | Related customer record.               |
| `room_reservation_id` | `UUID`         |       No | FK  | `room_reservation(id)` | -                     | Related room_reservation record.       |
| `title`               | `VARCHAR(160)` |      Yes | -   | -                        | -                     | Title.                                 |
| `message`             | `TEXT`         |      Yes | -   | -                        | -                     | Message.                               |
| `channel`             | `VARCHAR(60)`  |      Yes | -   | -                        | -                     | Communication channel.                 |
| `sent_at`             | `TIMESTAMP`    |       No | -   | -                        | -                     | Sending date and time.                 |
| `created_by`          | `UUID`         |       No | -   | -                        | -                     | User who created the record.           |
| `created_at`          | `TIMESTAMP`    |      Yes | -   | -                        | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by`          | `UUID`         |       No | -   | -                        | -                     | User who updated the record.           |
| `updated_at`          | `TIMESTAMP`    |       No | -   | -                        | -                     | Update date and time.                  |
| `deleted_by`          | `UUID`         |       No | -   | -                        | -                     | User who logically deleted the record. |
| `deleted_at`          | `TIMESTAMP`    |       No | -   | -                        | -                     | Logical deletion date and time.        |
| `status`              | `VARCHAR(30)`  |      Yes | -   | -                        | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT fk_alert_customer FOREIGN KEY (customer_id) REFERENCES customer (id)`
- `CONSTRAINT fk_alert_reservation FOREIGN KEY (room_reservation_id) REFERENCES room_reservation (id)`

**Indexes:**

- `ix_alert_customer (customer_id)`
- `ix_alert_reservation (room_reservation_id)`

## Table `term_condition`

**Description:** Stores active terms and conditions.

| Field              | Data type        | Required | Key | Reference | Default value         | Description                            |
| ------------------ | ---------------- | -------: | --- | --------- | --------------------- | -------------------------------------- |
| `id`             | `UUID`         |      Yes | PK  | -         | `gen_random_uuid()` | Unique record identifier.              |
| `title`          | `VARCHAR(160)` |      Yes | -   | -         | -                     | Title.                                 |
| `content`        | `TEXT`         |      Yes | -   | -         | -                     | Content.                               |
| `version`        | `VARCHAR(40)`  |      Yes | UK  | -         | -                     | Version.                               |
| `effective_date` | `DATE`         |      Yes | -   | -         | -                     | Effective date.                        |
| `is_required`    | `BOOLEAN`      |      Yes | -   | -         | `TRUE`              | Indicates whether it is required.      |
| `created_by`     | `UUID`         |       No | -   | -         | -                     | User who created the record.           |
| `created_at`     | `TIMESTAMP`    |      Yes | -   | -         | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by`     | `UUID`         |       No | -   | -         | -                     | User who updated the record.           |
| `updated_at`     | `TIMESTAMP`    |       No | -   | -         | -                     | Update date and time.                  |
| `deleted_by`     | `UUID`         |       No | -   | -         | -                     | User who logically deleted the record. |
| `deleted_at`     | `TIMESTAMP`    |       No | -   | -         | -                     | Logical deletion date and time.        |
| `status`         | `VARCHAR(30)`  |      Yes | -   | -         | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT uk_term_condition_version UNIQUE (version)`

## Table `customer_loyalty`

**Description:** Stores customer loyalty level and points.

| Field                   | Data type       | Required | Key    | Reference        | Default value         | Description                            |
| ----------------------- | --------------- | -------: | ------ | ---------------- | --------------------- | -------------------------------------- |
| `id`                  | `UUID`        |      Yes | PK     | -                | `gen_random_uuid()` | Unique record identifier.              |
| `customer_id`         | `UUID`        |      Yes | FK, UK | `customer(id)` | -                     | Related customer record.               |
| `level`               | `VARCHAR(60)` |      Yes | -      | -                | `'BASIC'`           | Level.                                 |
| `points`              | `INTEGER`     |      Yes | -      | -                | `0`                 | Accumulated points.                    |
| `last_interaction_at` | `TIMESTAMP`   |       No | -      | -                | -                     | Last interaction.                      |
| `note`                | `TEXT`        |       No | -      | -                | -                     | Note.                                  |
| `created_by`          | `UUID`        |       No | -      | -                | -                     | User who created the record.           |
| `created_at`          | `TIMESTAMP`   |      Yes | -      | -                | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by`          | `UUID`        |       No | -      | -                | -                     | User who updated the record.           |
| `updated_at`          | `TIMESTAMP`   |       No | -      | -                | -                     | Update date and time.                  |
| `deleted_by`          | `UUID`        |       No | -      | -                | -                     | User who logically deleted the record. |
| `deleted_at`          | `TIMESTAMP`   |       No | -      | -                | -                     | Logical deletion date and time.        |
| `status`              | `VARCHAR(30)` |      Yes | -      | -                | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT uk_customer_loyalty_customer UNIQUE (customer_id)`
- `CONSTRAINT fk_customer_loyalty_customer FOREIGN KEY (customer_id) REFERENCES customer (id)`
- `CONSTRAINT ck_customer_loyalty_points CHECK (points >= 0)`
