# Data dictionary - Distribution domain

- `branch`
- `room_type`
- `room_status`
- `room`
- `rate`

## Table `branch`

**Description:** Stores company branches or hotel locations.

| Field          | Data type        | Required | Key    | Reference       | Default value         | Description                            |
| -------------- | ---------------- | -------: | ------ | --------------- | --------------------- | -------------------------------------- |
| `id`         | `UUID`         |      Yes | PK     | -               | `gen_random_uuid()` | Unique record identifier.              |
| `company_id` | `UUID`         |      Yes | FK, UK | `company(id)` | -                     | Related company record.                |
| `name`       | `VARCHAR(160)` |      Yes | UK     | -               | -                     | Name.                                  |
| `address`    | `VARCHAR(255)` |      Yes | -      | -               | -                     | Address.                               |
| `city`       | `VARCHAR(120)` |      Yes | -      | -               | -                     | City.                                  |
| `phone`      | `VARCHAR(40)`  |       No | -      | -               | -                     | Contact phone.                         |
| `email`      | `VARCHAR(160)` |       No | -      | -               | -                     | Email address.                         |
| `created_by` | `UUID`         |       No | -      | -               | -                     | User who created the record.           |
| `created_at` | `TIMESTAMP`    |      Yes | -      | -               | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by` | `UUID`         |       No | -      | -               | -                     | User who updated the record.           |
| `updated_at` | `TIMESTAMP`    |       No | -      | -               | -                     | Update date and time.                  |
| `deleted_by` | `UUID`         |       No | -      | -               | -                     | User who logically deleted the record. |
| `deleted_at` | `TIMESTAMP`    |       No | -      | -               | -                     | Logical deletion date and time.        |
| `status`     | `VARCHAR(30)`  |      Yes | -      | -               | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT uk_branch_company_name UNIQUE (company_id, name)`
- `CONSTRAINT fk_branch_company FOREIGN KEY (company_id) REFERENCES company (id)`

## Table `room_type`

**Description:** Defines room types and capacities.

| Field             | Data type        | Required | Key | Reference | Default value         | Description                            |
| ----------------- | ---------------- | -------: | --- | --------- | --------------------- | -------------------------------------- |
| `id`            | `UUID`         |      Yes | PK  | -         | `gen_random_uuid()` | Unique record identifier.              |
| `name`          | `VARCHAR(80)`  |      Yes | UK  | -         | -                     | Name.                                  |
| `description`   | `VARCHAR(255)` |       No | -   | -         | -                     | Description.                           |
| `base_capacity` | `SMALLINT`     |      Yes | -   | -         | -                     | Base capacity.                         |
| `max_capacity`  | `SMALLINT`     |      Yes | -   | -         | -                     | Maximum capacity.                      |
| `created_by`    | `UUID`         |       No | -   | -         | -                     | User who created the record.           |
| `created_at`    | `TIMESTAMP`    |      Yes | -   | -         | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by`    | `UUID`         |       No | -   | -         | -                     | User who updated the record.           |
| `updated_at`    | `TIMESTAMP`    |       No | -   | -         | -                     | Update date and time.                  |
| `deleted_by`    | `UUID`         |       No | -   | -         | -                     | User who logically deleted the record. |
| `deleted_at`    | `TIMESTAMP`    |       No | -   | -         | -                     | Logical deletion date and time.        |
| `status`        | `VARCHAR(30)`  |      Yes | -   | -         | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT uk_room_type_name UNIQUE (name)`
- `CONSTRAINT ck_room_type_capacity CHECK (max_capacity >= base_capacity)`

## Table `room_status`

**Description:** Defines operational room states.

| Field                  | Data type        | Required | Key | Reference | Default value         | Description                            |
| ---------------------- | ---------------- | -------: | --- | --------- | --------------------- | -------------------------------------- |
| `id`                 | `UUID`         |      Yes | PK  | -         | `gen_random_uuid()` | Unique record identifier.              |
| `name`               | `VARCHAR(80)`  |      Yes | UK  | -         | -                     | Name.                                  |
| `description`        | `VARCHAR(255)` |       No | -   | -         | -                     | Description.                           |
| `allows_reservation` | `BOOLEAN`      |      Yes | -   | -         | `FALSE`             | Allows reservations.                   |
| `allows_check_in`    | `BOOLEAN`      |      Yes | -   | -         | `FALSE`             | Allows check-in.                       |
| `created_by`         | `UUID`         |       No | -   | -         | -                     | User who created the record.           |
| `created_at`         | `TIMESTAMP`    |      Yes | -   | -         | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by`         | `UUID`         |       No | -   | -         | -                     | User who updated the record.           |
| `updated_at`         | `TIMESTAMP`    |       No | -   | -         | -                     | Update date and time.                  |
| `deleted_by`         | `UUID`         |       No | -   | -         | -                     | User who logically deleted the record. |
| `deleted_at`         | `TIMESTAMP`    |       No | -   | -         | -                     | Logical deletion date and time.        |
| `status`             | `VARCHAR(30)`  |      Yes | -   | -         | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT uk_room_status_name UNIQUE (name)`

## Table `room`

**Description:** Stores physical rooms by branch.

| Field              | Data type        | Required | Key    | Reference           | Default value         | Description                            |
| ------------------ | ---------------- | -------: | ------ | ------------------- | --------------------- | -------------------------------------- |
| `id`             | `UUID`         |      Yes | PK     | -                   | `gen_random_uuid()` | Unique record identifier.              |
| `branch_id`      | `UUID`         |      Yes | FK, UK | `branch(id)`      | -                     | Related branch record.                 |
| `room_type_id`   | `UUID`         |      Yes | FK     | `room_type(id)`   | -                     | Related room_type record.              |
| `room_status_id` | `UUID`         |      Yes | FK     | `room_status(id)` | -                     | Related room_status record.            |
| `room_number`    | `VARCHAR(20)`  |      Yes | UK     | -                   | -                     | Room number.                           |
| `floor_number`   | `SMALLINT`     |       No | -      | -                   | -                     | Floor number.                          |
| `capacity`       | `SMALLINT`     |      Yes | -      | -                   | -                     | Capacity.                              |
| `description`    | `VARCHAR(255)` |       No | -      | -                   | -                     | Description.                           |
| `created_by`     | `UUID`         |       No | -      | -                   | -                     | User who created the record.           |
| `created_at`     | `TIMESTAMP`    |      Yes | -      | -                   | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by`     | `UUID`         |       No | -      | -                   | -                     | User who updated the record.           |
| `updated_at`     | `TIMESTAMP`    |       No | -      | -                   | -                     | Update date and time.                  |
| `deleted_by`     | `UUID`         |       No | -      | -                   | -                     | User who logically deleted the record. |
| `deleted_at`     | `TIMESTAMP`    |       No | -      | -                   | -                     | Logical deletion date and time.        |
| `status`         | `VARCHAR(30)`  |      Yes | -      | -                   | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT uk_room_branch_number UNIQUE (branch_id, room_number)`
- `CONSTRAINT fk_room_branch FOREIGN KEY (branch_id) REFERENCES branch (id)`
- `CONSTRAINT fk_room_type FOREIGN KEY (room_type_id) REFERENCES room_type (id)`
- `CONSTRAINT fk_room_status FOREIGN KEY (room_status_id) REFERENCES room_status (id)`

**Indexes:**

- `ix_room_type (room_type_id)`
- `ix_room_status (room_status_id)`

## Table `rate`

**Description:** Defines rates by room type and day type.

| Field              | Data type         | Required | Key    | Reference         | Default value         | Description                            |
| ------------------ | ----------------- | -------: | ------ | ----------------- | --------------------- | -------------------------------------- |
| `id`             | `UUID`          |      Yes | PK     | -                 | `gen_random_uuid()` | Unique record identifier.              |
| `room_type_id`   | `UUID`          |      Yes | FK, UK | `room_type(id)` | -                     | Related room_type record.              |
| `day_type_id`    | `UUID`          |      Yes | FK, UK | `day_type(id)`  | -                     | Related day_type record.               |
| `amount`         | `NUMERIC(12,2)` |      Yes | -      | -                 | -                     | Monetary amount.                       |
| `start_date`     | `DATE`          |      Yes | UK     | -                 | -                     | Start date.                            |
| `end_date`       | `DATE`          |       No | -      | -                 | -                     | End date.                              |
| `condition_note` | `VARCHAR(255)`  |       No | -      | -                 | -                     | Condition note.                        |
| `created_by`     | `UUID`          |       No | -      | -                 | -                     | User who created the record.           |
| `created_at`     | `TIMESTAMP`     |      Yes | -      | -                 | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by`     | `UUID`          |       No | -      | -                 | -                     | User who updated the record.           |
| `updated_at`     | `TIMESTAMP`     |       No | -      | -                 | -                     | Update date and time.                  |
| `deleted_by`     | `UUID`          |       No | -      | -                 | -                     | User who logically deleted the record. |
| `deleted_at`     | `TIMESTAMP`     |       No | -      | -                 | -                     | Logical deletion date and time.        |
| `status`         | `VARCHAR(30)`   |      Yes | -      | -                 | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT uk_rate_room_day_start UNIQUE (room_type_id, day_type_id, start_date)`
- `CONSTRAINT fk_rate_room_type FOREIGN KEY (room_type_id) REFERENCES room_type (id)`
- `CONSTRAINT fk_rate_day_type FOREIGN KEY (day_type_id) REFERENCES day_type (id)`
- `CONSTRAINT ck_rate_amount CHECK (amount >= 0)`

**Indexes:**

- `ix_rate_room_type (room_type_id)`
- `ix_rate_day_type (day_type_id)`
