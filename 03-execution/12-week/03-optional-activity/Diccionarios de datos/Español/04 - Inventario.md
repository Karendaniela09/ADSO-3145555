# Diccionario de datos - Dominio Inventario

- `supplier`
- `product`
- `service`
- `product_movement`
- `inventory_availability`

## Tabla `supplier`

**Descripción:** Registra proveedores de productos.

| Campo          | Tipo de dato     | Obligatorio | Llave | Referencia | Valor por defecto     | Descripción                                   |
| -------------- | ---------------- | ----------: | ----- | ---------- | --------------------- | ---------------------------------------------- |
| `id`         | `UUID`         |         Sí | PK    | -          | `gen_random_uuid()` | Identificador único del registro.             |
| `name`       | `VARCHAR(160)` |         Sí | -     | -          | -                     | Nombre.                                        |
| `tax_id`     | `VARCHAR(40)`  |          No | UK    | -          | -                     | Identificación tributaria.                    |
| `phone`      | `VARCHAR(40)`  |          No | -     | -          | -                     | Teléfono de contacto.                         |
| `email`      | `VARCHAR(160)` |          No | -     | -          | -                     | Correo electrónico.                           |
| `address`    | `VARCHAR(255)` |          No | -     | -          | -                     | Dirección.                                    |
| `created_by` | `UUID`         |          No | -     | -          | -                     | Usuario que creó el registro.                 |
| `created_at` | `TIMESTAMP`    |         Sí | -     | -          | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by` | `UUID`         |          No | -     | -          | -                     | Usuario que actualizó el registro.            |
| `updated_at` | `TIMESTAMP`    |          No | -     | -          | -                     | Fecha y hora de actualización.                |
| `deleted_by` | `UUID`         |          No | -     | -          | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at` | `TIMESTAMP`    |          No | -     | -          | -                     | Fecha y hora de eliminación lógica.          |
| `status`     | `VARCHAR(30)`  |         Sí | -     | -          | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT uk_supplier_tax_id UNIQUE (tax_id)`

## Tabla `product`

**Descripción:** Registra productos vendibles o controlados por inventario.

| Campo             | Tipo de dato      | Obligatorio | Llave | Referencia       | Valor por defecto     | Descripción                                   |
| ----------------- | ----------------- | ----------: | ----- | ---------------- | --------------------- | ---------------------------------------------- |
| `id`            | `UUID`          |         Sí | PK    | -                | `gen_random_uuid()` | Identificador único del registro.             |
| `supplier_id`   | `UUID`          |          No | FK    | `supplier(id)` | -                     | Registro relacionado de supplier.              |
| `name`          | `VARCHAR(160)`  |         Sí | UK    | -                | -                     | Nombre.                                        |
| `description`   | `VARCHAR(255)`  |          No | -     | -                | -                     | Descripción.                                  |
| `sale_price`    | `NUMERIC(12,2)` |         Sí | -     | -                | `0`                 | Precio de venta.                               |
| `current_stock` | `INTEGER`       |         Sí | -     | -                | `0`                 | Existencia actual.                             |
| `minimum_stock` | `INTEGER`       |         Sí | -     | -                | `0`                 | Existencia mínima.                            |
| `created_by`    | `UUID`          |          No | -     | -                | -                     | Usuario que creó el registro.                 |
| `created_at`    | `TIMESTAMP`     |         Sí | -     | -                | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`    | `UUID`          |          No | -     | -                | -                     | Usuario que actualizó el registro.            |
| `updated_at`    | `TIMESTAMP`     |          No | -     | -                | -                     | Fecha y hora de actualización.                |
| `deleted_by`    | `UUID`          |          No | -     | -                | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`    | `TIMESTAMP`     |          No | -     | -                | -                     | Fecha y hora de eliminación lógica.          |
| `status`        | `VARCHAR(30)`   |         Sí | -     | -                | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT uk_product_name UNIQUE (name)`
- `CONSTRAINT fk_product_supplier FOREIGN KEY (supplier_id) REFERENCES supplier (id)`
- `CONSTRAINT ck_product_values CHECK (sale_price >= 0 AND current_stock >= 0 AND minimum_stock >= 0)`

**Índices:**

- `ix_product_supplier (supplier_id)`

## Tabla `service`

**Descripción:** Registra servicios vendibles al huésped.

| Campo            | Tipo de dato      | Obligatorio | Llave | Referencia | Valor por defecto     | Descripción                                   |
| ---------------- | ----------------- | ----------: | ----- | ---------- | --------------------- | ---------------------------------------------- |
| `id`           | `UUID`          |         Sí | PK    | -          | `gen_random_uuid()` | Identificador único del registro.             |
| `name`         | `VARCHAR(160)`  |         Sí | UK    | -          | -                     | Nombre.                                        |
| `description`  | `VARCHAR(255)`  |          No | -     | -          | -                     | Descripción.                                  |
| `sale_price`   | `NUMERIC(12,2)` |         Sí | -     | -          | `0`                 | Precio de venta.                               |
| `is_available` | `BOOLEAN`       |         Sí | -     | -          | `TRUE`              | Indica disponibilidad.                         |
| `created_by`   | `UUID`          |          No | -     | -          | -                     | Usuario que creó el registro.                 |
| `created_at`   | `TIMESTAMP`     |         Sí | -     | -          | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`   | `UUID`          |          No | -     | -          | -                     | Usuario que actualizó el registro.            |
| `updated_at`   | `TIMESTAMP`     |          No | -     | -          | -                     | Fecha y hora de actualización.                |
| `deleted_by`   | `UUID`          |          No | -     | -          | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`   | `TIMESTAMP`     |          No | -     | -          | -                     | Fecha y hora de eliminación lógica.          |
| `status`       | `VARCHAR(30)`   |         Sí | -     | -          | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT uk_service_name UNIQUE (name)`
- `CONSTRAINT ck_service_sale_price CHECK (sale_price >= 0)`

## Tabla `product_movement`

**Descripción:** Registra movimientos de inventario de productos.

| Campo             | Tipo de dato    | Obligatorio | Llave | Referencia      | Valor por defecto     | Descripción                                   |
| ----------------- | --------------- | ----------: | ----- | --------------- | --------------------- | ---------------------------------------------- |
| `id`            | `UUID`        |         Sí | PK    | -               | `gen_random_uuid()` | Identificador único del registro.             |
| `product_id`    | `UUID`        |         Sí | FK    | `product(id)` | -                     | Registro relacionado de product.               |
| `movement_type` | `VARCHAR(40)` |         Sí | -     | -               | -                     | Tipo de movimiento.                            |
| `quantity`      | `INTEGER`     |         Sí | -     | -               | -                     | Cantidad.                                      |
| `moved_at`      | `TIMESTAMP`   |         Sí | -     | -               | `CURRENT_TIMESTAMP` | Fecha y hora del movimiento.                   |
| `note`          | `TEXT`        |          No | -     | -               | -                     | Observación.                                  |
| `created_by`    | `UUID`        |          No | -     | -               | -                     | Usuario que creó el registro.                 |
| `created_at`    | `TIMESTAMP`   |         Sí | -     | -               | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`    | `UUID`        |          No | -     | -               | -                     | Usuario que actualizó el registro.            |
| `updated_at`    | `TIMESTAMP`   |          No | -     | -               | -                     | Fecha y hora de actualización.                |
| `deleted_by`    | `UUID`        |          No | -     | -               | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`    | `TIMESTAMP`   |          No | -     | -               | -                     | Fecha y hora de eliminación lógica.          |
| `status`        | `VARCHAR(30)` |         Sí | -     | -               | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT fk_product_movement_product FOREIGN KEY (product_id) REFERENCES product (id)`
- `CONSTRAINT ck_product_movement_quantity CHECK (quantity > 0)`

**Índices:**

- `ix_product_movement_product_date (product_id, moved_at)`

## Tabla `inventory_availability`

**Descripción:** Registra disponibilidad de productos o servicios.

| Campo                  | Tipo de dato     | Obligatorio | Llave | Referencia      | Valor por defecto     | Descripción                                   |
| ---------------------- | ---------------- | ----------: | ----- | --------------- | --------------------- | ---------------------------------------------- |
| `id`                 | `UUID`         |         Sí | PK    | -               | `gen_random_uuid()` | Identificador único del registro.             |
| `product_id`         | `UUID`         |          No | FK    | `product(id)` | -                     | Registro relacionado de product.               |
| `service_id`         | `UUID`         |          No | FK    | `service(id)` | -                     | Registro relacionado de service.               |
| `available_quantity` | `INTEGER`      |         Sí | -     | -               | `0`                 | Cantidad disponible.                           |
| `is_available`       | `BOOLEAN`      |         Sí | -     | -               | `TRUE`              | Indica disponibilidad.                         |
| `note`               | `VARCHAR(255)` |          No | -     | -               | -                     | Observación.                                  |
| `created_by`         | `UUID`         |          No | -     | -               | -                     | Usuario que creó el registro.                 |
| `created_at`         | `TIMESTAMP`    |         Sí | -     | -               | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`         | `UUID`         |          No | -     | -               | -                     | Usuario que actualizó el registro.            |
| `updated_at`         | `TIMESTAMP`    |          No | -     | -               | -                     | Fecha y hora de actualización.                |
| `deleted_by`         | `UUID`         |          No | -     | -               | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`         | `TIMESTAMP`    |          No | -     | -               | -                     | Fecha y hora de eliminación lógica.          |
| `status`             | `VARCHAR(30)`  |         Sí | -     | -               | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT fk_inventory_availability_product FOREIGN KEY (product_id) REFERENCES product (id)`
- `CONSTRAINT fk_inventory_availability_service FOREIGN KEY (service_id) REFERENCES service (id)`
- `CONSTRAINT ck_inventory_availability_item CHECK (product_id IS NOT NULL OR service_id IS NOT NULL)`
- `CONSTRAINT ck_inventory_availability_quantity CHECK (available_quantity >= 0)`

**Índices:**

- `ix_inventory_availability_product (product_id)`
- `ix_inventory_availability_service (service_id)`
