# Data dictionary - Maintenance domain

- `room_maintenance`
- `usage_maintenance`
- `remodeling_maintenance`
- `maintenance_dashboard`

## Table `room_maintenance`

**Description:** Stores scheduled or performed room maintenance.

| Field                  | Data type       | Required | Key | Reference        | Default value         | Description                            |
| ---------------------- | --------------- | -------: | --- | ---------------- | --------------------- | -------------------------------------- |
| `id`                 | `UUID`        |      Yes | PK  | -                | `gen_random_uuid()` | Unique record identifier.              |
| `room_id`            | `UUID`        |      Yes | FK  | `room(id)`     | -                     | Related room record.                   |
| `employee_id`        | `UUID`        |       No | FK  | `employee(id)` | -                     | Related employee record.               |
| `maintenance_type`   | `VARCHAR(60)` |      Yes | -   | -                | -                     | Maintenance type.                      |
| `start_at`           | `TIMESTAMP`   |      Yes | -   | -                | -                     | Start date and time.                   |
| `end_at`             | `TIMESTAMP`   |       No | -   | -                | -                     | End date and time.                     |
| `maintenance_status` | `VARCHAR(40)` |      Yes | -   | -                | `'PENDING'`         | Maintenance status.                    |
| `note`               | `TEXT`        |       No | -   | -                | -                     | Note.                                  |
| `created_by`         | `UUID`        |       No | -   | -                | -                     | User who created the record.           |
| `created_at`         | `TIMESTAMP`   |      Yes | -   | -                | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by`         | `UUID`        |       No | -   | -                | -                     | User who updated the record.           |
| `updated_at`         | `TIMESTAMP`   |       No | -   | -                | -                     | Update date and time.                  |
| `deleted_by`         | `UUID`        |       No | -   | -                | -                     | User who logically deleted the record. |
| `deleted_at`         | `TIMESTAMP`   |       No | -   | -                | -                     | Logical deletion date and time.        |
| `status`             | `VARCHAR(30)` |      Yes | -   | -                | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT fk_room_maintenance_room FOREIGN KEY (room_id) REFERENCES room (id)`
- `CONSTRAINT fk_room_maintenance_employee FOREIGN KEY (employee_id) REFERENCES employee (id)`

**Indexes:**

- `ix_room_maintenance_room_dates (room_id, start_at, end_at)`
- `ix_room_maintenance_employee (employee_id)`

## Table `usage_maintenance`

**Description:** Stores maintenance related to room usage.

| Field                   | Data type        | Required | Key    | Reference                | Default value         | Description                            |
| ----------------------- | ---------------- | -------: | ------ | ------------------------ | --------------------- | -------------------------------------- |
| `id`                  | `UUID`         |      Yes | PK     | -                        | `gen_random_uuid()` | Unique record identifier.              |
| `room_maintenance_id` | `UUID`         |      Yes | FK, UK | `room_maintenance(id)` | -                     | Related room_maintenance record.       |
| `usage_reason`        | `VARCHAR(160)` |      Yes | -      | -                        | -                     | Usage reason.                          |
| `activity_detail`     | `TEXT`         |       No | -      | -                        | -                     | Activity detail.                       |
| `created_by`          | `UUID`         |       No | -      | -                        | -                     | User who created the record.           |
| `created_at`          | `TIMESTAMP`    |      Yes | -      | -                        | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by`          | `UUID`         |       No | -      | -                        | -                     | User who updated the record.           |
| `updated_at`          | `TIMESTAMP`    |       No | -      | -                        | -                     | Update date and time.                  |
| `deleted_by`          | `UUID`         |       No | -      | -                        | -                     | User who logically deleted the record. |
| `deleted_at`          | `TIMESTAMP`    |       No | -      | -                        | -                     | Logical deletion date and time.        |
| `status`              | `VARCHAR(30)`  |      Yes | -      | -                        | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT uk_usage_maintenance_base UNIQUE (room_maintenance_id)`
- `CONSTRAINT fk_usage_maintenance_base FOREIGN KEY (room_maintenance_id) REFERENCES room_maintenance (id)`

## Table `remodeling_maintenance`

**Description:** Stores remodeling maintenance and estimated budget.

| Field                      | Data type         | Required | Key    | Reference                | Default value         | Description                            |
| -------------------------- | ----------------- | -------: | ------ | ------------------------ | --------------------- | -------------------------------------- |
| `id`                     | `UUID`          |      Yes | PK     | -                        | `gen_random_uuid()` | Unique record identifier.              |
| `room_maintenance_id`    | `UUID`          |      Yes | FK, UK | `room_maintenance(id)` | -                     | Related room_maintenance record.       |
| `remodeling_description` | `TEXT`          |      Yes | -      | -                        | -                     | Remodeling description.                |
| `estimated_budget`       | `NUMERIC(12,2)` |       No | -      | -                        | -                     | Estimated budget.                      |
| `created_by`             | `UUID`          |       No | -      | -                        | -                     | User who created the record.           |
| `created_at`             | `TIMESTAMP`     |      Yes | -      | -                        | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by`             | `UUID`          |       No | -      | -                        | -                     | User who updated the record.           |
| `updated_at`             | `TIMESTAMP`     |       No | -      | -                        | -                     | Update date and time.                  |
| `deleted_by`             | `UUID`          |       No | -      | -                        | -                     | User who logically deleted the record. |
| `deleted_at`             | `TIMESTAMP`     |       No | -      | -                        | -                     | Logical deletion date and time.        |
| `status`                 | `VARCHAR(30)`   |      Yes | -      | -                        | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT uk_remodeling_maintenance_base UNIQUE (room_maintenance_id)`
- `CONSTRAINT fk_remodeling_maintenance_base FOREIGN KEY (room_maintenance_id) REFERENCES room_maintenance (id)`
- `CONSTRAINT ck_remodeling_maintenance_budget CHECK (estimated_budget IS NULL OR estimated_budget >= 0)`

## Table `maintenance_dashboard`

**Description:** Stores consolidated room metrics by branch.

| Field                 | Data type       | Required | Key | Reference      | Default value         | Description                            |
| --------------------- | --------------- | -------: | --- | -------------- | --------------------- | -------------------------------------- |
| `id`                | `UUID`        |      Yes | PK  | -              | `gen_random_uuid()` | Unique record identifier.              |
| `branch_id`         | `UUID`        |      Yes | FK  | `branch(id)` | -                     | Related branch record.                 |
| `total_rooms`       | `INTEGER`     |      Yes | -   | -              | `0`                 | Total rooms.                           |
| `available_rooms`   | `INTEGER`     |      Yes | -   | -              | `0`                 | Available rooms.                       |
| `occupied_rooms`    | `INTEGER`     |      Yes | -   | -              | `0`                 | Occupied rooms.                        |
| `maintenance_rooms` | `INTEGER`     |      Yes | -   | -              | `0`                 | Rooms under maintenance.               |
| `cutoff_at`         | `TIMESTAMP`   |      Yes | -   | -              | `CURRENT_TIMESTAMP` | Cutoff date and time.                  |
| `created_by`        | `UUID`        |       No | -   | -              | -                     | User who created the record.           |
| `created_at`        | `TIMESTAMP`   |      Yes | -   | -              | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by`        | `UUID`        |       No | -   | -              | -                     | User who updated the record.           |
| `updated_at`        | `TIMESTAMP`   |       No | -   | -              | -                     | Update date and time.                  |
| `deleted_by`        | `UUID`        |       No | -   | -              | -                     | User who logically deleted the record. |
| `deleted_at`        | `TIMESTAMP`   |       No | -   | -              | -                     | Logical deletion date and time.        |
| `status`            | `VARCHAR(30)` |      Yes | -   | -              | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT fk_maintenance_dashboard_branch FOREIGN KEY (branch_id) REFERENCES branch (id)`
- `CONSTRAINT ck_maintenance_dashboard_totals CHECK ( total_rooms >= 0 AND available_rooms >= 0 AND occupied_rooms >= 0 AND maintenance_rooms >= 0 )`

**Indexes:**

- `ix_maintenance_dashboard_branch_cutoff (branch_id, cutoff_at)`
