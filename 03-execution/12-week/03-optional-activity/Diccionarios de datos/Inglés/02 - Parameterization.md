# Data dictionary - Parameterization domain

- `customer`
- `company`
- `day_type`
- `payment_method`
- `legal_information`
- `employee`

## Table `customer`

**Description:** Stores hotel customers and contact information.

| Field               | Data type        | Required | Key | Reference | Default value         | Description                            |
| ------------------- | ---------------- | -------: | --- | --------- | --------------------- | -------------------------------------- |
| `id`              | `UUID`         |      Yes | PK  | -         | `gen_random_uuid()` | Unique record identifier.              |
| `document_type`   | `VARCHAR(30)`  |      Yes | UK  | -         | -                     | Document type.                         |
| `document_number` | `VARCHAR(40)`  |      Yes | UK  | -         | -                     | Document number.                       |
| `first_name`      | `VARCHAR(100)` |      Yes | -   | -         | -                     | First names.                           |
| `last_name`       | `VARCHAR(100)` |      Yes | -   | -         | -                     | Last names.                            |
| `phone`           | `VARCHAR(40)`  |       No | -   | -         | -                     | Contact phone.                         |
| `email`           | `VARCHAR(160)` |       No | UK  | -         | -                     | Email address.                         |
| `address`         | `VARCHAR(255)` |       No | -   | -         | -                     | Address.                               |
| `created_by`      | `UUID`         |       No | -   | -         | -                     | User who created the record.           |
| `created_at`      | `TIMESTAMP`    |      Yes | -   | -         | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by`      | `UUID`         |       No | -   | -         | -                     | User who updated the record.           |
| `updated_at`      | `TIMESTAMP`    |       No | -   | -         | -                     | Update date and time.                  |
| `deleted_by`      | `UUID`         |       No | -   | -         | -                     | User who logically deleted the record. |
| `deleted_at`      | `TIMESTAMP`    |       No | -   | -         | -                     | Logical deletion date and time.        |
| `status`          | `VARCHAR(30)`  |      Yes | -   | -         | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT uk_customer_document UNIQUE (document_type, document_number)`
- `CONSTRAINT uk_customer_email UNIQUE (email)`

## Table `company`

**Description:** Stores the company that owns or operates the hotel.

| Field          | Data type        | Required | Key | Reference | Default value         | Description                            |
| -------------- | ---------------- | -------: | --- | --------- | --------------------- | -------------------------------------- |
| `id`         | `UUID`         |      Yes | PK  | -         | `gen_random_uuid()` | Unique record identifier.              |
| `name`       | `VARCHAR(160)` |      Yes | -   | -         | -                     | Name.                                  |
| `tax_id`     | `VARCHAR(40)`  |      Yes | UK  | -         | -                     | Tax identifier.                        |
| `legal_name` | `VARCHAR(180)` |      Yes | -   | -         | -                     | Legal name.                            |
| `phone`      | `VARCHAR(40)`  |       No | -   | -         | -                     | Contact phone.                         |
| `email`      | `VARCHAR(160)` |       No | -   | -         | -                     | Email address.                         |
| `address`    | `VARCHAR(255)` |       No | -   | -         | -                     | Address.                               |
| `website`    | `VARCHAR(180)` |       No | -   | -         | -                     | Website.                               |
| `created_by` | `UUID`         |       No | -   | -         | -                     | User who created the record.           |
| `created_at` | `TIMESTAMP`    |      Yes | -   | -         | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by` | `UUID`         |       No | -   | -         | -                     | User who updated the record.           |
| `updated_at` | `TIMESTAMP`    |       No | -   | -         | -                     | Update date and time.                  |
| `deleted_by` | `UUID`         |       No | -   | -         | -                     | User who logically deleted the record. |
| `deleted_at` | `TIMESTAMP`    |       No | -   | -         | -                     | Logical deletion date and time.        |
| `status`     | `VARCHAR(30)`  |      Yes | -   | -         | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT uk_company_tax_id UNIQUE (tax_id)`

## Table `day_type`

**Description:** Classifies dates or days for rate rules.

| Field               | Data type        | Required | Key | Reference | Default value         | Description                            |
| ------------------- | ---------------- | -------: | --- | --------- | --------------------- | -------------------------------------- |
| `id`              | `UUID`         |      Yes | PK  | -         | `gen_random_uuid()` | Unique record identifier.              |
| `name`            | `VARCHAR(80)`  |      Yes | UK  | -         | -                     | Name.                                  |
| `description`     | `VARCHAR(255)` |       No | -   | -         | -                     | Description.                           |
| `date_value`      | `DATE`         |       No | UK  | -         | -                     | Associated date.                       |
| `applies_season`  | `BOOLEAN`      |      Yes | -   | -         | `FALSE`             | Applies by season.                     |
| `applies_holiday` | `BOOLEAN`      |      Yes | -   | -         | `FALSE`             | Applies to holiday.                    |
| `applies_special` | `BOOLEAN`      |      Yes | -   | -         | `FALSE`             | Applies to special condition.          |
| `created_by`      | `UUID`         |       No | -   | -         | -                     | User who created the record.           |
| `created_at`      | `TIMESTAMP`    |      Yes | -   | -         | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by`      | `UUID`         |       No | -   | -         | -                     | User who updated the record.           |
| `updated_at`      | `TIMESTAMP`    |       No | -   | -         | -                     | Update date and time.                  |
| `deleted_by`      | `UUID`         |       No | -   | -         | -                     | User who logically deleted the record. |
| `deleted_at`      | `TIMESTAMP`    |       No | -   | -         | -                     | Logical deletion date and time.        |
| `status`          | `VARCHAR(30)`  |      Yes | -   | -         | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT uk_day_type_name_date UNIQUE (name, date_value)`

## Table `payment_method`

**Description:** Defines available payment methods.

| Field                      | Data type        | Required | Key | Reference | Default value         | Description                            |
| -------------------------- | ---------------- | -------: | --- | --------- | --------------------- | -------------------------------------- |
| `id`                     | `UUID`         |      Yes | PK  | -         | `gen_random_uuid()` | Unique record identifier.              |
| `name`                   | `VARCHAR(80)`  |      Yes | UK  | -         | -                     | Name.                                  |
| `description`            | `VARCHAR(255)` |       No | -   | -         | -                     | Description.                           |
| `requires_reference`     | `BOOLEAN`      |      Yes | -   | -         | `FALSE`             | Requires reference.                    |
| `allows_partial_payment` | `BOOLEAN`      |      Yes | -   | -         | `TRUE`              | Allows partial payments.               |
| `created_by`             | `UUID`         |       No | -   | -         | -                     | User who created the record.           |
| `created_at`             | `TIMESTAMP`    |      Yes | -   | -         | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by`             | `UUID`         |       No | -   | -         | -                     | User who updated the record.           |
| `updated_at`             | `TIMESTAMP`    |       No | -   | -         | -                     | Update date and time.                  |
| `deleted_by`             | `UUID`         |       No | -   | -         | -                     | User who logically deleted the record. |
| `deleted_at`             | `TIMESTAMP`    |       No | -   | -         | -                     | Logical deletion date and time.        |
| `status`                 | `VARCHAR(30)`  |      Yes | -   | -         | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT uk_payment_method_name UNIQUE (name)`

## Table `legal_information`

**Description:** Stores company legal documents and information.

| Field                     | Data type       | Required | Key | Reference       | Default value         | Description                            |
| ------------------------- | --------------- | -------: | --- | --------------- | --------------------- | -------------------------------------- |
| `id`                    | `UUID`        |      Yes | PK  | -               | `gen_random_uuid()` | Unique record identifier.              |
| `company_id`            | `UUID`        |      Yes | FK  | `company(id)` | -                     | Related company record.                |
| `legal_document_type`   | `VARCHAR(80)` |      Yes | -   | -               | -                     | Table-specific data.                   |
| `legal_document_number` | `VARCHAR(80)` |      Yes | -   | -               | -                     | Table-specific data.                   |
| `description`           | `TEXT`        |       No | -   | -               | -                     | Description.                           |
| `issue_date`            | `DATE`        |       No | -   | -               | -                     | Issue date.                            |
| `expiration_date`       | `DATE`        |       No | -   | -               | -                     | Expiration date.                       |
| `created_by`            | `UUID`        |       No | -   | -               | -                     | User who created the record.           |
| `created_at`            | `TIMESTAMP`   |      Yes | -   | -               | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by`            | `UUID`        |       No | -   | -               | -                     | User who updated the record.           |
| `updated_at`            | `TIMESTAMP`   |       No | -   | -               | -                     | Update date and time.                  |
| `deleted_by`            | `UUID`        |       No | -   | -               | -                     | User who logically deleted the record. |
| `deleted_at`            | `TIMESTAMP`   |       No | -   | -               | -                     | Logical deletion date and time.        |
| `status`                | `VARCHAR(30)` |      Yes | -   | -               | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT fk_legal_information_company FOREIGN KEY (company_id) REFERENCES company (id)`

**Indexes:**

- `ix_legal_information_company (company_id)`

## Table `employee`

**Description:** Stores employees linked to a person record.

| Field          | Data type        | Required | Key    | Reference      | Default value         | Description                            |
| -------------- | ---------------- | -------: | ------ | -------------- | --------------------- | -------------------------------------- |
| `id`         | `UUID`         |      Yes | PK     | -              | `gen_random_uuid()` | Unique record identifier.              |
| `person_id`  | `UUID`         |      Yes | FK, UK | `person(id)` | -                     | Related person record.                 |
| `job_title`  | `VARCHAR(100)` |      Yes | -      | -              | -                     | Job title.                             |
| `hire_date`  | `DATE`         |      Yes | -      | -              | -                     | Hire date.                             |
| `work_phone` | `VARCHAR(40)`  |       No | -      | -              | -                     | Work phone.                            |
| `work_email` | `VARCHAR(160)` |       No | UK     | -              | -                     | Work email.                            |
| `created_by` | `UUID`         |       No | -      | -              | -                     | User who created the record.           |
| `created_at` | `TIMESTAMP`    |      Yes | -      | -              | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by` | `UUID`         |       No | -      | -              | -                     | User who updated the record.           |
| `updated_at` | `TIMESTAMP`    |       No | -      | -              | -                     | Update date and time.                  |
| `deleted_by` | `UUID`         |       No | -      | -              | -                     | User who logically deleted the record. |
| `deleted_at` | `TIMESTAMP`    |       No | -      | -              | -                     | Logical deletion date and time.        |
| `status`     | `VARCHAR(30)`  |      Yes | -      | -              | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT uk_employee_person UNIQUE (person_id)`
- `CONSTRAINT uk_employee_work_email UNIQUE (work_email)`
- `CONSTRAINT fk_employee_person FOREIGN KEY (person_id) REFERENCES person (id)`
