# Diccionario de datos - Dominio Prestación de servicios

- `room_reservation`
- `room_cancellation`
- `room_availability`
- `room_catalog`
- `stay`
- `check_in`
- `check_out`
- `product_sale`
- `service_sale`

## Tabla `room_reservation`

**Descripción:** Registra reservas de habitación realizadas por clientes.

| Campo                  | Tipo de dato      | Obligatorio | Llave | Referencia       | Valor por defecto     | Descripción                                   |
| ---------------------- | ----------------- | ----------: | ----- | ---------------- | --------------------- | ---------------------------------------------- |
| `id`                 | `UUID`          |         Sí | PK    | -                | `gen_random_uuid()` | Identificador único del registro.             |
| `customer_id`        | `UUID`          |         Sí | FK    | `customer(id)` | -                     | Registro relacionado de customer.              |
| `room_id`            | `UUID`          |         Sí | FK    | `room(id)`     | -                     | Registro relacionado de room.                  |
| `start_at`           | `TIMESTAMP`     |         Sí | -     | -                | -                     | Fecha y hora inicial.                          |
| `end_at`             | `TIMESTAMP`     |         Sí | -     | -                | -                     | Fecha y hora final.                            |
| `guest_count`        | `SMALLINT`      |         Sí | -     | -                | -                     | Cantidad de huéspedes.                        |
| `reservation_status` | `VARCHAR(40)`   |         Sí | -     | -                | `'PENDING'`         | Estado de la reserva.                          |
| `estimated_amount`   | `NUMERIC(12,2)` |         Sí | -     | -                | `0`                 | Valor estimado.                                |
| `created_by`         | `UUID`          |          No | -     | -                | -                     | Usuario que creó el registro.                 |
| `created_at`         | `TIMESTAMP`     |         Sí | -     | -                | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`         | `UUID`          |          No | -     | -                | -                     | Usuario que actualizó el registro.            |
| `updated_at`         | `TIMESTAMP`     |          No | -     | -                | -                     | Fecha y hora de actualización.                |
| `deleted_by`         | `UUID`          |          No | -     | -                | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`         | `TIMESTAMP`     |          No | -     | -                | -                     | Fecha y hora de eliminación lógica.          |
| `status`             | `VARCHAR(30)`   |         Sí | -     | -                | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT fk_room_reservation_customer FOREIGN KEY (customer_id) REFERENCES customer (id)`
- `CONSTRAINT fk_room_reservation_room FOREIGN KEY (room_id) REFERENCES room (id)`
- `CONSTRAINT ck_room_reservation_dates CHECK (end_at > start_at)`
- `CONSTRAINT ck_room_reservation_values CHECK (guest_count > 0 AND estimated_amount >= 0)`

**Índices:**

- `ix_room_reservation_customer (customer_id)`
- `ix_room_reservation_room_dates (room_id, start_at, end_at)`

## Tabla `room_cancellation`

**Descripción:** Registra cancelaciones de reservas.

| Campo                   | Tipo de dato      | Obligatorio | Llave  | Referencia               | Valor por defecto     | Descripción                                   |
| ----------------------- | ----------------- | ----------: | ------ | ------------------------ | --------------------- | ---------------------------------------------- |
| `id`                  | `UUID`          |         Sí | PK     | -                        | `gen_random_uuid()` | Identificador único del registro.             |
| `room_reservation_id` | `UUID`          |         Sí | FK, UK | `room_reservation(id)` | -                     | Registro relacionado de room_reservation.      |
| `reason`              | `VARCHAR(255)`  |         Sí | -      | -                        | -                     | Motivo.                                        |
| `cancelled_at`        | `TIMESTAMP`     |         Sí | -      | -                        | `CURRENT_TIMESTAMP` | Fecha y hora de cancelación.                  |
| `applies_penalty`     | `BOOLEAN`       |         Sí | -      | -                        | `FALSE`             | Aplica penalización.                          |
| `penalty_amount`      | `NUMERIC(12,2)` |         Sí | -      | -                        | `0`                 | Valor de penalización.                        |
| `created_by`          | `UUID`          |          No | -      | -                        | -                     | Usuario que creó el registro.                 |
| `created_at`          | `TIMESTAMP`     |         Sí | -      | -                        | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`          | `UUID`          |          No | -      | -                        | -                     | Usuario que actualizó el registro.            |
| `updated_at`          | `TIMESTAMP`     |          No | -      | -                        | -                     | Fecha y hora de actualización.                |
| `deleted_by`          | `UUID`          |          No | -      | -                        | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`          | `TIMESTAMP`     |          No | -      | -                        | -                     | Fecha y hora de eliminación lógica.          |
| `status`              | `VARCHAR(30)`   |         Sí | -      | -                        | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT uk_room_cancellation_reservation UNIQUE (room_reservation_id)`
- `CONSTRAINT fk_room_cancellation_reservation FOREIGN KEY (room_reservation_id) REFERENCES room_reservation (id)`
- `CONSTRAINT ck_room_cancellation_penalty CHECK (penalty_amount >= 0)`

## Tabla `room_availability`

**Descripción:** Registra ventanas de disponibilidad o indisponibilidad de habitaciones.

| Campo                  | Tipo de dato     | Obligatorio | Llave | Referencia   | Valor por defecto     | Descripción                                   |
| ---------------------- | ---------------- | ----------: | ----- | ------------ | --------------------- | ---------------------------------------------- |
| `id`                 | `UUID`         |         Sí | PK    | -            | `gen_random_uuid()` | Identificador único del registro.             |
| `room_id`            | `UUID`         |         Sí | FK    | `room(id)` | -                     | Registro relacionado de room.                  |
| `start_at`           | `TIMESTAMP`    |         Sí | -     | -            | -                     | Fecha y hora inicial.                          |
| `end_at`             | `TIMESTAMP`    |         Sí | -     | -            | -                     | Fecha y hora final.                            |
| `is_available`       | `BOOLEAN`      |         Sí | -     | -            | `TRUE`              | Indica disponibilidad.                         |
| `unavailable_reason` | `VARCHAR(255)` |          No | -     | -            | -                     | Motivo de indisponibilidad.                    |
| `created_by`         | `UUID`         |          No | -     | -            | -                     | Usuario que creó el registro.                 |
| `created_at`         | `TIMESTAMP`    |         Sí | -     | -            | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`         | `UUID`         |          No | -     | -            | -                     | Usuario que actualizó el registro.            |
| `updated_at`         | `TIMESTAMP`    |          No | -     | -            | -                     | Fecha y hora de actualización.                |
| `deleted_by`         | `UUID`         |          No | -     | -            | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`         | `TIMESTAMP`    |          No | -     | -            | -                     | Fecha y hora de eliminación lógica.          |
| `status`             | `VARCHAR(30)`  |         Sí | -     | -            | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT fk_room_availability_room FOREIGN KEY (room_id) REFERENCES room (id)`
- `CONSTRAINT ck_room_availability_dates CHECK (end_at > start_at)`

**Índices:**

- `ix_room_availability_room_dates (room_id, start_at, end_at)`

## Tabla `room_catalog`

**Descripción:** Registra la publicación comercial de una habitación.

| Campo           | Tipo de dato      | Obligatorio | Llave  | Referencia   | Valor por defecto     | Descripción                                   |
| --------------- | ----------------- | ----------: | ------ | ------------ | --------------------- | ---------------------------------------------- |
| `id`          | `UUID`          |         Sí | PK     | -            | `gen_random_uuid()` | Identificador único del registro.             |
| `room_id`     | `UUID`          |         Sí | FK, UK | `room(id)` | -                     | Registro relacionado de room.                  |
| `title`       | `VARCHAR(160)`  |         Sí | -      | -            | -                     | Título.                                       |
| `description` | `TEXT`          |          No | -      | -            | -                     | Descripción.                                  |
| `base_price`  | `NUMERIC(12,2)` |         Sí | -      | -            | `0`                 | Precio base.                                   |
| `is_visible`  | `BOOLEAN`       |         Sí | -      | -            | `TRUE`              | Visible en catálogo.                          |
| `created_by`  | `UUID`          |          No | -      | -            | -                     | Usuario que creó el registro.                 |
| `created_at`  | `TIMESTAMP`     |         Sí | -      | -            | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`  | `UUID`          |          No | -      | -            | -                     | Usuario que actualizó el registro.            |
| `updated_at`  | `TIMESTAMP`     |          No | -      | -            | -                     | Fecha y hora de actualización.                |
| `deleted_by`  | `UUID`          |          No | -      | -            | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`  | `TIMESTAMP`     |          No | -      | -            | -                     | Fecha y hora de eliminación lógica.          |
| `status`      | `VARCHAR(30)`   |         Sí | -      | -            | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT uk_room_catalog_room UNIQUE (room_id)`
- `CONSTRAINT fk_room_catalog_room FOREIGN KEY (room_id) REFERENCES room (id)`
- `CONSTRAINT ck_room_catalog_base_price CHECK (base_price >= 0)`

## Tabla `stay`

**Descripción:** Registra estadías efectivas de clientes.

| Campo                   | Tipo de dato    | Obligatorio | Llave  | Referencia               | Valor por defecto     | Descripción                                   |
| ----------------------- | --------------- | ----------: | ------ | ------------------------ | --------------------- | ---------------------------------------------- |
| `id`                  | `UUID`        |         Sí | PK     | -                        | `gen_random_uuid()` | Identificador único del registro.             |
| `room_reservation_id` | `UUID`        |         Sí | FK, UK | `room_reservation(id)` | -                     | Registro relacionado de room_reservation.      |
| `customer_id`         | `UUID`        |         Sí | FK     | `customer(id)`         | -                     | Registro relacionado de customer.              |
| `room_id`             | `UUID`        |         Sí | FK     | `room(id)`             | -                     | Registro relacionado de room.                  |
| `start_at`            | `TIMESTAMP`   |         Sí | -      | -                        | -                     | Fecha y hora inicial.                          |
| `end_at`              | `TIMESTAMP`   |          No | -      | -                        | -                     | Fecha y hora final.                            |
| `stay_status`         | `VARCHAR(40)` |         Sí | -      | -                        | `'ACTIVE'`          | Estado de estadía.                            |
| `created_by`          | `UUID`        |          No | -      | -                        | -                     | Usuario que creó el registro.                 |
| `created_at`          | `TIMESTAMP`   |         Sí | -      | -                        | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`          | `UUID`        |          No | -      | -                        | -                     | Usuario que actualizó el registro.            |
| `updated_at`          | `TIMESTAMP`   |          No | -      | -                        | -                     | Fecha y hora de actualización.                |
| `deleted_by`          | `UUID`        |          No | -      | -                        | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`          | `TIMESTAMP`   |          No | -      | -                        | -                     | Fecha y hora de eliminación lógica.          |
| `status`              | `VARCHAR(30)` |         Sí | -      | -                        | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT uk_stay_reservation UNIQUE (room_reservation_id)`
- `CONSTRAINT fk_stay_reservation FOREIGN KEY (room_reservation_id) REFERENCES room_reservation (id)`
- `CONSTRAINT fk_stay_customer FOREIGN KEY (customer_id) REFERENCES customer (id)`
- `CONSTRAINT fk_stay_room FOREIGN KEY (room_id) REFERENCES room (id)`

**Índices:**

- `ix_stay_customer (customer_id)`
- `ix_stay_room (room_id)`

## Tabla `check_in`

**Descripción:** Registra el ingreso del huésped asociado a una reserva.

| Campo                   | Tipo de dato    | Obligatorio | Llave  | Referencia               | Valor por defecto     | Descripción                                   |
| ----------------------- | --------------- | ----------: | ------ | ------------------------ | --------------------- | ---------------------------------------------- |
| `id`                  | `UUID`        |         Sí | PK     | -                        | `gen_random_uuid()` | Identificador único del registro.             |
| `room_reservation_id` | `UUID`        |         Sí | FK, UK | `room_reservation(id)` | -                     | Registro relacionado de room_reservation.      |
| `employee_id`         | `UUID`        |         Sí | FK     | `employee(id)`         | -                     | Registro relacionado de employee.              |
| `checked_in_at`       | `TIMESTAMP`   |         Sí | -      | -                        | `CURRENT_TIMESTAMP` | Fecha y hora de ingreso.                       |
| `note`                | `TEXT`        |          No | -      | -                        | -                     | Observación.                                  |
| `created_by`          | `UUID`        |          No | -      | -                        | -                     | Usuario que creó el registro.                 |
| `created_at`          | `TIMESTAMP`   |         Sí | -      | -                        | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`          | `UUID`        |          No | -      | -                        | -                     | Usuario que actualizó el registro.            |
| `updated_at`          | `TIMESTAMP`   |          No | -      | -                        | -                     | Fecha y hora de actualización.                |
| `deleted_by`          | `UUID`        |          No | -      | -                        | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`          | `TIMESTAMP`   |          No | -      | -                        | -                     | Fecha y hora de eliminación lógica.          |
| `status`              | `VARCHAR(30)` |         Sí | -      | -                        | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT uk_check_in_reservation UNIQUE (room_reservation_id)`
- `CONSTRAINT fk_check_in_reservation FOREIGN KEY (room_reservation_id) REFERENCES room_reservation (id)`
- `CONSTRAINT fk_check_in_employee FOREIGN KEY (employee_id) REFERENCES employee (id)`

**Índices:**

- `ix_check_in_employee (employee_id)`

## Tabla `check_out`

**Descripción:** Registra la salida del huésped y valores de cierre.

| Campo              | Tipo de dato      | Obligatorio | Llave  | Referencia       | Valor por defecto     | Descripción                                   |
| ------------------ | ----------------- | ----------: | ------ | ---------------- | --------------------- | ---------------------------------------------- |
| `id`             | `UUID`          |         Sí | PK     | -                | `gen_random_uuid()` | Identificador único del registro.             |
| `stay_id`        | `UUID`          |         Sí | FK, UK | `stay(id)`     | -                     | Registro relacionado de stay.                  |
| `employee_id`    | `UUID`          |         Sí | FK     | `employee(id)` | -                     | Registro relacionado de employee.              |
| `checked_out_at` | `TIMESTAMP`     |         Sí | -      | -                | `CURRENT_TIMESTAMP` | Fecha y hora de salida.                        |
| `note`           | `TEXT`          |          No | -      | -                | -                     | Observación.                                  |
| `total_amount`   | `NUMERIC(12,2)` |         Sí | -      | -                | `0`                 | Valor total.                                   |
| `created_by`     | `UUID`          |          No | -      | -                | -                     | Usuario que creó el registro.                 |
| `created_at`     | `TIMESTAMP`     |         Sí | -      | -                | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`     | `UUID`          |          No | -      | -                | -                     | Usuario que actualizó el registro.            |
| `updated_at`     | `TIMESTAMP`     |          No | -      | -                | -                     | Fecha y hora de actualización.                |
| `deleted_by`     | `UUID`          |          No | -      | -                | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`     | `TIMESTAMP`     |          No | -      | -                | -                     | Fecha y hora de eliminación lógica.          |
| `status`         | `VARCHAR(30)`   |         Sí | -      | -                | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT uk_check_out_stay UNIQUE (stay_id)`
- `CONSTRAINT fk_check_out_stay FOREIGN KEY (stay_id) REFERENCES stay (id)`
- `CONSTRAINT fk_check_out_employee FOREIGN KEY (employee_id) REFERENCES employee (id)`
- `CONSTRAINT ck_check_out_total_amount CHECK (total_amount >= 0)`

**Índices:**

- `ix_check_out_employee (employee_id)`

## Tabla `product_sale`

**Descripción:** Registra productos consumidos o vendidos durante una estadía.

| Campo            | Tipo de dato      | Obligatorio | Llave | Referencia      | Valor por defecto     | Descripción                                   |
| ---------------- | ----------------- | ----------: | ----- | --------------- | --------------------- | ---------------------------------------------- |
| `id`           | `UUID`          |         Sí | PK    | -               | `gen_random_uuid()` | Identificador único del registro.             |
| `stay_id`      | `UUID`          |         Sí | FK    | `stay(id)`    | -                     | Registro relacionado de stay.                  |
| `product_id`   | `UUID`          |         Sí | FK    | `product(id)` | -                     | Registro relacionado de product.               |
| `quantity`     | `INTEGER`       |         Sí | -     | -               | -                     | Cantidad.                                      |
| `unit_price`   | `NUMERIC(12,2)` |         Sí | -     | -               | -                     | Precio unitario.                               |
| `total_amount` | `NUMERIC(12,2)` |         Sí | -     | -               | -                     | Valor total.                                   |
| `created_by`   | `UUID`          |          No | -     | -               | -                     | Usuario que creó el registro.                 |
| `created_at`   | `TIMESTAMP`     |         Sí | -     | -               | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`   | `UUID`          |          No | -     | -               | -                     | Usuario que actualizó el registro.            |
| `updated_at`   | `TIMESTAMP`     |          No | -     | -               | -                     | Fecha y hora de actualización.                |
| `deleted_by`   | `UUID`          |          No | -     | -               | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`   | `TIMESTAMP`     |          No | -     | -               | -                     | Fecha y hora de eliminación lógica.          |
| `status`       | `VARCHAR(30)`   |         Sí | -     | -               | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT fk_product_sale_stay FOREIGN KEY (stay_id) REFERENCES stay (id)`
- `CONSTRAINT fk_product_sale_product FOREIGN KEY (product_id) REFERENCES product (id)`
- `CONSTRAINT ck_product_sale_values CHECK (quantity > 0 AND unit_price >= 0 AND total_amount >= 0)`

**Índices:**

- `ix_product_sale_stay (stay_id)`
- `ix_product_sale_product (product_id)`

## Tabla `service_sale`

**Descripción:** Registra servicios consumidos o vendidos durante una estadía.

| Campo            | Tipo de dato      | Obligatorio | Llave | Referencia      | Valor por defecto     | Descripción                                   |
| ---------------- | ----------------- | ----------: | ----- | --------------- | --------------------- | ---------------------------------------------- |
| `id`           | `UUID`          |         Sí | PK    | -               | `gen_random_uuid()` | Identificador único del registro.             |
| `stay_id`      | `UUID`          |         Sí | FK    | `stay(id)`    | -                     | Registro relacionado de stay.                  |
| `service_id`   | `UUID`          |         Sí | FK    | `service(id)` | -                     | Registro relacionado de service.               |
| `quantity`     | `INTEGER`       |         Sí | -     | -               | -                     | Cantidad.                                      |
| `unit_price`   | `NUMERIC(12,2)` |         Sí | -     | -               | -                     | Precio unitario.                               |
| `total_amount` | `NUMERIC(12,2)` |         Sí | -     | -               | -                     | Valor total.                                   |
| `created_by`   | `UUID`          |          No | -     | -               | -                     | Usuario que creó el registro.                 |
| `created_at`   | `TIMESTAMP`     |         Sí | -     | -               | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`   | `UUID`          |          No | -     | -               | -                     | Usuario que actualizó el registro.            |
| `updated_at`   | `TIMESTAMP`     |          No | -     | -               | -                     | Fecha y hora de actualización.                |
| `deleted_by`   | `UUID`          |          No | -     | -               | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`   | `TIMESTAMP`     |          No | -     | -               | -                     | Fecha y hora de eliminación lógica.          |
| `status`       | `VARCHAR(30)`   |         Sí | -     | -               | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT fk_service_sale_stay FOREIGN KEY (stay_id) REFERENCES stay (id)`
- `CONSTRAINT fk_service_sale_service FOREIGN KEY (service_id) REFERENCES service (id)`
- `CONSTRAINT ck_service_sale_values CHECK (quantity > 0 AND unit_price >= 0 AND total_amount >= 0)`

**Índices:**

- `ix_service_sale_stay (stay_id)`
- `ix_service_sale_service (service_id)`
