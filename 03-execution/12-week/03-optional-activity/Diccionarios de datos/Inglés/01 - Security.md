# Data dictionary - Security domain

- `person`
- `app_role`
- `permission`
- `module`
- `app_view`
- `app_user`
- `user_role`
- `role_permission`
- `module_view`

## Table `person`

**Description:** Stores base person information used by the system.

| Field               | Data type        | Required | Key | Reference | Default value         | Description                            |
| ------------------- | ---------------- | -------: | --- | --------- | --------------------- | -------------------------------------- |
| `id`              | `UUID`         |      Yes | PK  | -         | `gen_random_uuid()` | Unique record identifier.              |
| `document_type`   | `VARCHAR(30)`  |      Yes | UK  | -         | -                     | Document type.                         |
| `document_number` | `VARCHAR(40)`  |      Yes | UK  | -         | -                     | Document number.                       |
| `first_name`      | `VARCHAR(100)` |      Yes | -   | -         | -                     | First names.                           |
| `last_name`       | `VARCHAR(100)` |      Yes | -   | -         | -                     | Last names.                            |
| `phone`           | `VARCHAR(40)`  |       No | -   | -         | -                     | Contact phone.                         |
| `email`           | `VARCHAR(160)` |       No | UK  | -         | -                     | Email address.                         |
| `created_by`      | `UUID`         |       No | -   | -         | -                     | User who created the record.           |
| `created_at`      | `TIMESTAMP`    |      Yes | -   | -         | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by`      | `UUID`         |       No | -   | -         | -                     | User who updated the record.           |
| `updated_at`      | `TIMESTAMP`    |       No | -   | -         | -                     | Update date and time.                  |
| `deleted_by`      | `UUID`         |       No | -   | -         | -                     | User who logically deleted the record. |
| `deleted_at`      | `TIMESTAMP`    |       No | -   | -         | -                     | Logical deletion date and time.        |
| `status`          | `VARCHAR(30)`  |      Yes | -   | -         | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT uk_person_document UNIQUE (document_type, document_number)`
- `CONSTRAINT uk_person_email UNIQUE (email)`

## Table `app_role`

**Description:** Defines application roles assignable to users.

| Field           | Data type        | Required | Key | Reference | Default value         | Description                            |
| --------------- | ---------------- | -------: | --- | --------- | --------------------- | -------------------------------------- |
| `id`          | `UUID`         |      Yes | PK  | -         | `gen_random_uuid()` | Unique record identifier.              |
| `name`        | `VARCHAR(80)`  |      Yes | UK  | -         | -                     | Name.                                  |
| `description` | `VARCHAR(255)` |       No | -   | -         | -                     | Description.                           |
| `created_by`  | `UUID`         |       No | -   | -         | -                     | User who created the record.           |
| `created_at`  | `TIMESTAMP`    |      Yes | -   | -         | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by`  | `UUID`         |       No | -   | -         | -                     | User who updated the record.           |
| `updated_at`  | `TIMESTAMP`    |       No | -   | -         | -                     | Update date and time.                  |
| `deleted_by`  | `UUID`         |       No | -   | -         | -                     | User who logically deleted the record. |
| `deleted_at`  | `TIMESTAMP`    |       No | -   | -         | -                     | Logical deletion date and time.        |
| `status`      | `VARCHAR(30)`  |      Yes | -   | -         | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT uk_app_role_name UNIQUE (name)`

## Table `permission`

**Description:** Defines permissions and actions that control functional access.

| Field           | Data type        | Required | Key | Reference | Default value         | Description                            |
| --------------- | ---------------- | -------: | --- | --------- | --------------------- | -------------------------------------- |
| `id`          | `UUID`         |      Yes | PK  | -         | `gen_random_uuid()` | Unique record identifier.              |
| `name`        | `VARCHAR(120)` |      Yes | UK  | -         | -                     | Name.                                  |
| `description` | `VARCHAR(255)` |       No | -   | -         | -                     | Description.                           |
| `action`      | `VARCHAR(80)`  |      Yes | UK  | -         | -                     | Allowed action.                        |
| `created_by`  | `UUID`         |       No | -   | -         | -                     | User who created the record.           |
| `created_at`  | `TIMESTAMP`    |      Yes | -   | -         | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by`  | `UUID`         |       No | -   | -         | -                     | User who updated the record.           |
| `updated_at`  | `TIMESTAMP`    |       No | -   | -         | -                     | Update date and time.                  |
| `deleted_by`  | `UUID`         |       No | -   | -         | -                     | User who logically deleted the record. |
| `deleted_at`  | `TIMESTAMP`    |       No | -   | -         | -                     | Logical deletion date and time.        |
| `status`      | `VARCHAR(30)`  |      Yes | -   | -         | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT uk_permission_name_action UNIQUE (name, action)`

## Table `module`

**Description:** Stores functional modules and their base paths.

| Field           | Data type        | Required | Key | Reference | Default value         | Description                            |
| --------------- | ---------------- | -------: | --- | --------- | --------------------- | -------------------------------------- |
| `id`          | `UUID`         |      Yes | PK  | -         | `gen_random_uuid()` | Unique record identifier.              |
| `name`        | `VARCHAR(100)` |      Yes | UK  | -         | -                     | Name.                                  |
| `description` | `VARCHAR(255)` |       No | -   | -         | -                     | Description.                           |
| `base_path`   | `VARCHAR(160)` |      Yes | UK  | -         | -                     | Base path.                             |
| `created_by`  | `UUID`         |       No | -   | -         | -                     | User who created the record.           |
| `created_at`  | `TIMESTAMP`    |      Yes | -   | -         | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by`  | `UUID`         |       No | -   | -         | -                     | User who updated the record.           |
| `updated_at`  | `TIMESTAMP`    |       No | -   | -         | -                     | Update date and time.                  |
| `deleted_by`  | `UUID`         |       No | -   | -         | -                     | User who logically deleted the record. |
| `deleted_at`  | `TIMESTAMP`    |       No | -   | -         | -                     | Logical deletion date and time.        |
| `status`      | `VARCHAR(30)`  |      Yes | -   | -         | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT uk_module_name UNIQUE (name)`
- `CONSTRAINT uk_module_base_path UNIQUE (base_path)`

## Table `app_view`

**Description:** Stores views or screens associated with a module.

| Field           | Data type        | Required | Key    | Reference      | Default value         | Description                            |
| --------------- | ---------------- | -------: | ------ | -------------- | --------------------- | -------------------------------------- |
| `id`          | `UUID`         |      Yes | PK     | -              | `gen_random_uuid()` | Unique record identifier.              |
| `module_id`   | `UUID`         |      Yes | FK, UK | `module(id)` | -                     | Related module record.                 |
| `name`        | `VARCHAR(120)` |      Yes | -      | -              | -                     | Name.                                  |
| `description` | `VARCHAR(255)` |       No | -      | -              | -                     | Description.                           |
| `path`        | `VARCHAR(180)` |      Yes | UK     | -              | -                     | Access path.                           |
| `created_by`  | `UUID`         |       No | -      | -              | -                     | User who created the record.           |
| `created_at`  | `TIMESTAMP`    |      Yes | -      | -              | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by`  | `UUID`         |       No | -      | -              | -                     | User who updated the record.           |
| `updated_at`  | `TIMESTAMP`    |       No | -      | -              | -                     | Update date and time.                  |
| `deleted_by`  | `UUID`         |       No | -      | -              | -                     | User who logically deleted the record. |
| `deleted_at`  | `TIMESTAMP`    |       No | -      | -              | -                     | Logical deletion date and time.        |
| `status`      | `VARCHAR(30)`  |      Yes | -      | -              | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT uk_app_view_module_path UNIQUE (module_id, path)`
- `CONSTRAINT fk_app_view_module FOREIGN KEY (module_id) REFERENCES module (id)`

## Table `app_user`

**Description:** Stores user credentials and access state.

| Field              | Data type        | Required | Key    | Reference      | Default value         | Description                            |
| ------------------ | ---------------- | -------: | ------ | -------------- | --------------------- | -------------------------------------- |
| `id`             | `UUID`         |      Yes | PK     | -              | `gen_random_uuid()` | Unique record identifier.              |
| `person_id`      | `UUID`         |      Yes | FK, UK | `person(id)` | -                     | Related person record.                 |
| `username`       | `VARCHAR(80)`  |      Yes | UK     | -              | -                     | Username.                              |
| `password_hash`  | `VARCHAR(255)` |      Yes | -      | -              | -                     | Password hash.                         |
| `last_access_at` | `TIMESTAMP`    |       No | -      | -              | -                     | Last access.                           |
| `is_blocked`     | `BOOLEAN`      |      Yes | -      | -              | `FALSE`             | Indicates whether it is blocked.       |
| `created_by`     | `UUID`         |       No | -      | -              | -                     | User who created the record.           |
| `created_at`     | `TIMESTAMP`    |      Yes | -      | -              | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by`     | `UUID`         |       No | -      | -              | -                     | User who updated the record.           |
| `updated_at`     | `TIMESTAMP`    |       No | -      | -              | -                     | Update date and time.                  |
| `deleted_by`     | `UUID`         |       No | -      | -              | -                     | User who logically deleted the record. |
| `deleted_at`     | `TIMESTAMP`    |       No | -      | -              | -                     | Logical deletion date and time.        |
| `status`         | `VARCHAR(30)`  |      Yes | -      | -              | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT uk_app_user_person UNIQUE (person_id)`
- `CONSTRAINT uk_app_user_username UNIQUE (username)`
- `CONSTRAINT fk_app_user_person FOREIGN KEY (person_id) REFERENCES person (id)`

## Table `user_role`

**Description:** Links users to application roles.

| Field          | Data type       | Required | Key    | Reference        | Default value         | Description                            |
| -------------- | --------------- | -------: | ------ | ---------------- | --------------------- | -------------------------------------- |
| `id`         | `UUID`        |      Yes | PK     | -                | `gen_random_uuid()` | Unique record identifier.              |
| `user_id`    | `UUID`        |      Yes | FK, UK | `app_user(id)` | -                     | Related user record.                   |
| `role_id`    | `UUID`        |      Yes | FK, UK | `app_role(id)` | -                     | Related role record.                   |
| `created_by` | `UUID`        |       No | -      | -                | -                     | User who created the record.           |
| `created_at` | `TIMESTAMP`   |      Yes | -      | -                | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by` | `UUID`        |       No | -      | -                | -                     | User who updated the record.           |
| `updated_at` | `TIMESTAMP`   |       No | -      | -                | -                     | Update date and time.                  |
| `deleted_by` | `UUID`        |       No | -      | -                | -                     | User who logically deleted the record. |
| `deleted_at` | `TIMESTAMP`   |       No | -      | -                | -                     | Logical deletion date and time.        |
| `status`     | `VARCHAR(30)` |      Yes | -      | -                | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT uk_user_role UNIQUE (user_id, role_id)`
- `CONSTRAINT fk_user_role_user FOREIGN KEY (user_id) REFERENCES app_user (id)`
- `CONSTRAINT fk_user_role_role FOREIGN KEY (role_id) REFERENCES app_role (id)`

## Table `role_permission`

**Description:** Links roles to specific permissions.

| Field             | Data type       | Required | Key    | Reference          | Default value         | Description                            |
| ----------------- | --------------- | -------: | ------ | ------------------ | --------------------- | -------------------------------------- |
| `id`            | `UUID`        |      Yes | PK     | -                  | `gen_random_uuid()` | Unique record identifier.              |
| `role_id`       | `UUID`        |      Yes | FK, UK | `app_role(id)`   | -                     | Related role record.                   |
| `permission_id` | `UUID`        |      Yes | FK, UK | `permission(id)` | -                     | Related permission record.             |
| `created_by`    | `UUID`        |       No | -      | -                  | -                     | User who created the record.           |
| `created_at`    | `TIMESTAMP`   |      Yes | -      | -                  | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by`    | `UUID`        |       No | -      | -                  | -                     | User who updated the record.           |
| `updated_at`    | `TIMESTAMP`   |       No | -      | -                  | -                     | Update date and time.                  |
| `deleted_by`    | `UUID`        |       No | -      | -                  | -                     | User who logically deleted the record. |
| `deleted_at`    | `TIMESTAMP`   |       No | -      | -                  | -                     | Logical deletion date and time.        |
| `status`        | `VARCHAR(30)` |      Yes | -      | -                  | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT uk_role_permission UNIQUE (role_id, permission_id)`
- `CONSTRAINT fk_role_permission_role FOREIGN KEY (role_id) REFERENCES app_role (id)`
- `CONSTRAINT fk_role_permission_permission FOREIGN KEY (permission_id) REFERENCES permission (id)`

## Table `module_view`

**Description:** Links modules to available views.

| Field          | Data type       | Required | Key    | Reference        | Default value         | Description                            |
| -------------- | --------------- | -------: | ------ | ---------------- | --------------------- | -------------------------------------- |
| `id`         | `UUID`        |      Yes | PK     | -                | `gen_random_uuid()` | Unique record identifier.              |
| `module_id`  | `UUID`        |      Yes | FK, UK | `module(id)`   | -                     | Related module record.                 |
| `view_id`    | `UUID`        |      Yes | FK, UK | `app_view(id)` | -                     | Related view record.                   |
| `created_by` | `UUID`        |       No | -      | -                | -                     | User who created the record.           |
| `created_at` | `TIMESTAMP`   |      Yes | -      | -                | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by` | `UUID`        |       No | -      | -                | -                     | User who updated the record.           |
| `updated_at` | `TIMESTAMP`   |       No | -      | -                | -                     | Update date and time.                  |
| `deleted_by` | `UUID`        |       No | -      | -                | -                     | User who logically deleted the record. |
| `deleted_at` | `TIMESTAMP`   |       No | -      | -                | -                     | Logical deletion date and time.        |
| `status`     | `VARCHAR(30)` |      Yes | -      | -                | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT uk_module_view UNIQUE (module_id, view_id)`
- `CONSTRAINT fk_module_view_module FOREIGN KEY (module_id) REFERENCES module (id)`
- `CONSTRAINT fk_module_view_view FOREIGN KEY (view_id) REFERENCES app_view (id)`
