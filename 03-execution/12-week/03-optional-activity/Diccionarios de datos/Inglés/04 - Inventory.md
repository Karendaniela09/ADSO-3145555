# Data dictionary - Inventory domain

- `supplier`
- `product`
- `service`
- `product_movement`
- `inventory_availability`

## Table `supplier`

**Description:** Stores product suppliers.

| Field          | Data type        | Required | Key | Reference | Default value         | Description                            |
| -------------- | ---------------- | -------: | --- | --------- | --------------------- | -------------------------------------- |
| `id`         | `UUID`         |      Yes | PK  | -         | `gen_random_uuid()` | Unique record identifier.              |
| `name`       | `VARCHAR(160)` |      Yes | -   | -         | -                     | Name.                                  |
| `tax_id`     | `VARCHAR(40)`  |       No | UK  | -         | -                     | Tax identifier.                        |
| `phone`      | `VARCHAR(40)`  |       No | -   | -         | -                     | Contact phone.                         |
| `email`      | `VARCHAR(160)` |       No | -   | -         | -                     | Email address.                         |
| `address`    | `VARCHAR(255)` |       No | -   | -         | -                     | Address.                               |
| `created_by` | `UUID`         |       No | -   | -         | -                     | User who created the record.           |
| `created_at` | `TIMESTAMP`    |      Yes | -   | -         | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by` | `UUID`         |       No | -   | -         | -                     | User who updated the record.           |
| `updated_at` | `TIMESTAMP`    |       No | -   | -         | -                     | Update date and time.                  |
| `deleted_by` | `UUID`         |       No | -   | -         | -                     | User who logically deleted the record. |
| `deleted_at` | `TIMESTAMP`    |       No | -   | -         | -                     | Logical deletion date and time.        |
| `status`     | `VARCHAR(30)`  |      Yes | -   | -         | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT uk_supplier_tax_id UNIQUE (tax_id)`

## Table `product`

**Description:** Stores sellable or inventory-controlled products.

| Field             | Data type         | Required | Key | Reference        | Default value         | Description                            |
| ----------------- | ----------------- | -------: | --- | ---------------- | --------------------- | -------------------------------------- |
| `id`            | `UUID`          |      Yes | PK  | -                | `gen_random_uuid()` | Unique record identifier.              |
| `supplier_id`   | `UUID`          |       No | FK  | `supplier(id)` | -                     | Related supplier record.               |
| `name`          | `VARCHAR(160)`  |      Yes | UK  | -                | -                     | Name.                                  |
| `description`   | `VARCHAR(255)`  |       No | -   | -                | -                     | Description.                           |
| `sale_price`    | `NUMERIC(12,2)` |      Yes | -   | -                | `0`                 | Sale price.                            |
| `current_stock` | `INTEGER`       |      Yes | -   | -                | `0`                 | Current stock.                         |
| `minimum_stock` | `INTEGER`       |      Yes | -   | -                | `0`                 | Minimum stock.                         |
| `created_by`    | `UUID`          |       No | -   | -                | -                     | User who created the record.           |
| `created_at`    | `TIMESTAMP`     |      Yes | -   | -                | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by`    | `UUID`          |       No | -   | -                | -                     | User who updated the record.           |
| `updated_at`    | `TIMESTAMP`     |       No | -   | -                | -                     | Update date and time.                  |
| `deleted_by`    | `UUID`          |       No | -   | -                | -                     | User who logically deleted the record. |
| `deleted_at`    | `TIMESTAMP`     |       No | -   | -                | -                     | Logical deletion date and time.        |
| `status`        | `VARCHAR(30)`   |      Yes | -   | -                | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT uk_product_name UNIQUE (name)`
- `CONSTRAINT fk_product_supplier FOREIGN KEY (supplier_id) REFERENCES supplier (id)`
- `CONSTRAINT ck_product_values CHECK (sale_price >= 0 AND current_stock >= 0 AND minimum_stock >= 0)`

**Indexes:**

- `ix_product_supplier (supplier_id)`

## Table `service`

**Description:** Stores sellable guest services.

| Field            | Data type         | Required | Key | Reference | Default value         | Description                            |
| ---------------- | ----------------- | -------: | --- | --------- | --------------------- | -------------------------------------- |
| `id`           | `UUID`          |      Yes | PK  | -         | `gen_random_uuid()` | Unique record identifier.              |
| `name`         | `VARCHAR(160)`  |      Yes | UK  | -         | -                     | Name.                                  |
| `description`  | `VARCHAR(255)`  |       No | -   | -         | -                     | Description.                           |
| `sale_price`   | `NUMERIC(12,2)` |      Yes | -   | -         | `0`                 | Sale price.                            |
| `is_available` | `BOOLEAN`       |      Yes | -   | -         | `TRUE`              | Indicates availability.                |
| `created_by`   | `UUID`          |       No | -   | -         | -                     | User who created the record.           |
| `created_at`   | `TIMESTAMP`     |      Yes | -   | -         | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by`   | `UUID`          |       No | -   | -         | -                     | User who updated the record.           |
| `updated_at`   | `TIMESTAMP`     |       No | -   | -         | -                     | Update date and time.                  |
| `deleted_by`   | `UUID`          |       No | -   | -         | -                     | User who logically deleted the record. |
| `deleted_at`   | `TIMESTAMP`     |       No | -   | -         | -                     | Logical deletion date and time.        |
| `status`       | `VARCHAR(30)`   |      Yes | -   | -         | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT uk_service_name UNIQUE (name)`
- `CONSTRAINT ck_service_sale_price CHECK (sale_price >= 0)`

## Table `product_movement`

**Description:** Stores product inventory movements.

| Field             | Data type       | Required | Key | Reference       | Default value         | Description                            |
| ----------------- | --------------- | -------: | --- | --------------- | --------------------- | -------------------------------------- |
| `id`            | `UUID`        |      Yes | PK  | -               | `gen_random_uuid()` | Unique record identifier.              |
| `product_id`    | `UUID`        |      Yes | FK  | `product(id)` | -                     | Related product record.                |
| `movement_type` | `VARCHAR(40)` |      Yes | -   | -               | -                     | Movement type.                         |
| `quantity`      | `INTEGER`     |      Yes | -   | -               | -                     | Quantity.                              |
| `moved_at`      | `TIMESTAMP`   |      Yes | -   | -               | `CURRENT_TIMESTAMP` | Movement date and time.                |
| `note`          | `TEXT`        |       No | -   | -               | -                     | Note.                                  |
| `created_by`    | `UUID`        |       No | -   | -               | -                     | User who created the record.           |
| `created_at`    | `TIMESTAMP`   |      Yes | -   | -               | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by`    | `UUID`        |       No | -   | -               | -                     | User who updated the record.           |
| `updated_at`    | `TIMESTAMP`   |       No | -   | -               | -                     | Update date and time.                  |
| `deleted_by`    | `UUID`        |       No | -   | -               | -                     | User who logically deleted the record. |
| `deleted_at`    | `TIMESTAMP`   |       No | -   | -               | -                     | Logical deletion date and time.        |
| `status`        | `VARCHAR(30)` |      Yes | -   | -               | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT fk_product_movement_product FOREIGN KEY (product_id) REFERENCES product (id)`
- `CONSTRAINT ck_product_movement_quantity CHECK (quantity > 0)`

**Indexes:**

- `ix_product_movement_product_date (product_id, moved_at)`

## Table `inventory_availability`

**Description:** Stores product or service availability.

| Field                  | Data type        | Required | Key | Reference       | Default value         | Description                            |
| ---------------------- | ---------------- | -------: | --- | --------------- | --------------------- | -------------------------------------- |
| `id`                 | `UUID`         |      Yes | PK  | -               | `gen_random_uuid()` | Unique record identifier.              |
| `product_id`         | `UUID`         |       No | FK  | `product(id)` | -                     | Related product record.                |
| `service_id`         | `UUID`         |       No | FK  | `service(id)` | -                     | Related service record.                |
| `available_quantity` | `INTEGER`      |      Yes | -   | -               | `0`                 | Available quantity.                    |
| `is_available`       | `BOOLEAN`      |      Yes | -   | -               | `TRUE`              | Indicates availability.                |
| `note`               | `VARCHAR(255)` |       No | -   | -               | -                     | Note.                                  |
| `created_by`         | `UUID`         |       No | -   | -               | -                     | User who created the record.           |
| `created_at`         | `TIMESTAMP`    |      Yes | -   | -               | `CURRENT_TIMESTAMP` | Creation date and time.                |
| `updated_by`         | `UUID`         |       No | -   | -               | -                     | User who updated the record.           |
| `updated_at`         | `TIMESTAMP`    |       No | -   | -               | -                     | Update date and time.                  |
| `deleted_by`         | `UUID`         |       No | -   | -               | -                     | User who logically deleted the record. |
| `deleted_at`         | `TIMESTAMP`    |       No | -   | -               | -                     | Logical deletion date and time.        |
| `status`             | `VARCHAR(30)`  |      Yes | -   | -               | `'ACTIVE'`          | Logical record status.                 |

**Constraints:**

- `CONSTRAINT fk_inventory_availability_product FOREIGN KEY (product_id) REFERENCES product (id)`
- `CONSTRAINT fk_inventory_availability_service FOREIGN KEY (service_id) REFERENCES service (id)`
- `CONSTRAINT ck_inventory_availability_item CHECK (product_id IS NOT NULL OR service_id IS NOT NULL)`
- `CONSTRAINT ck_inventory_availability_quantity CHECK (available_quantity >= 0)`

**Indexes:**

- `ix_inventory_availability_product (product_id)`
- `ix_inventory_availability_service (service_id)`
