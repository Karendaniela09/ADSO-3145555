# Diccionario de datos - Dominio Notificaciones

- `promotion`
- `alert`
- `term_condition`
- `customer_loyalty`

## Tabla `promotion`

**Descripción:** Registra promociones comunicadas por distintos canales.

| Campo           | Tipo de dato     | Obligatorio | Llave | Referencia | Valor por defecto     | Descripción                                   |
| --------------- | ---------------- | ----------: | ----- | ---------- | --------------------- | ---------------------------------------------- |
| `id`          | `UUID`         |         Sí | PK    | -          | `gen_random_uuid()` | Identificador único del registro.             |
| `title`       | `VARCHAR(160)` |         Sí | -     | -          | -                     | Título.                                       |
| `description` | `TEXT`         |          No | -     | -          | -                     | Descripción.                                  |
| `start_at`    | `TIMESTAMP`    |         Sí | -     | -          | -                     | Fecha y hora inicial.                          |
| `end_at`      | `TIMESTAMP`    |          No | -     | -          | -                     | Fecha y hora final.                            |
| `channel`     | `VARCHAR(60)`  |         Sí | -     | -          | -                     | Canal de comunicación.                        |
| `is_active`   | `BOOLEAN`      |         Sí | -     | -          | `TRUE`              | Indica si está activo.                        |
| `created_by`  | `UUID`         |          No | -     | -          | -                     | Usuario que creó el registro.                 |
| `created_at`  | `TIMESTAMP`    |         Sí | -     | -          | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`  | `UUID`         |          No | -     | -          | -                     | Usuario que actualizó el registro.            |
| `updated_at`  | `TIMESTAMP`    |          No | -     | -          | -                     | Fecha y hora de actualización.                |
| `deleted_by`  | `UUID`         |          No | -     | -          | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`  | `TIMESTAMP`    |          No | -     | -          | -                     | Fecha y hora de eliminación lógica.          |
| `status`      | `VARCHAR(30)`  |         Sí | -     | -          | `'ACTIVE'`          | Estado lógico del registro.                   |

**Índices:**

- `ix_promotion_dates (start_at, end_at)`

## Tabla `alert`

**Descripción:** Registra alertas o mensajes enviados a clientes.

| Campo                   | Tipo de dato     | Obligatorio | Llave | Referencia               | Valor por defecto     | Descripción                                   |
| ----------------------- | ---------------- | ----------: | ----- | ------------------------ | --------------------- | ---------------------------------------------- |
| `id`                  | `UUID`         |         Sí | PK    | -                        | `gen_random_uuid()` | Identificador único del registro.             |
| `customer_id`         | `UUID`         |          No | FK    | `customer(id)`         | -                     | Registro relacionado de customer.              |
| `room_reservation_id` | `UUID`         |          No | FK    | `room_reservation(id)` | -                     | Registro relacionado de room_reservation.      |
| `title`               | `VARCHAR(160)` |         Sí | -     | -                        | -                     | Título.                                       |
| `message`             | `TEXT`         |         Sí | -     | -                        | -                     | Mensaje.                                       |
| `channel`             | `VARCHAR(60)`  |         Sí | -     | -                        | -                     | Canal de comunicación.                        |
| `sent_at`             | `TIMESTAMP`    |          No | -     | -                        | -                     | Fecha y hora de envío.                        |
| `created_by`          | `UUID`         |          No | -     | -                        | -                     | Usuario que creó el registro.                 |
| `created_at`          | `TIMESTAMP`    |         Sí | -     | -                        | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`          | `UUID`         |          No | -     | -                        | -                     | Usuario que actualizó el registro.            |
| `updated_at`          | `TIMESTAMP`    |          No | -     | -                        | -                     | Fecha y hora de actualización.                |
| `deleted_by`          | `UUID`         |          No | -     | -                        | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`          | `TIMESTAMP`    |          No | -     | -                        | -                     | Fecha y hora de eliminación lógica.          |
| `status`              | `VARCHAR(30)`  |         Sí | -     | -                        | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT fk_alert_customer FOREIGN KEY (customer_id) REFERENCES customer (id)`
- `CONSTRAINT fk_alert_reservation FOREIGN KEY (room_reservation_id) REFERENCES room_reservation (id)`

**Índices:**

- `ix_alert_customer (customer_id)`
- `ix_alert_reservation (room_reservation_id)`

## Tabla `term_condition`

**Descripción:** Registra términos y condiciones vigentes.

| Campo              | Tipo de dato     | Obligatorio | Llave | Referencia | Valor por defecto     | Descripción                                   |
| ------------------ | ---------------- | ----------: | ----- | ---------- | --------------------- | ---------------------------------------------- |
| `id`             | `UUID`         |         Sí | PK    | -          | `gen_random_uuid()` | Identificador único del registro.             |
| `title`          | `VARCHAR(160)` |         Sí | -     | -          | -                     | Título.                                       |
| `content`        | `TEXT`         |         Sí | -     | -          | -                     | Contenido.                                     |
| `version`        | `VARCHAR(40)`  |         Sí | UK    | -          | -                     | Versión.                                      |
| `effective_date` | `DATE`         |         Sí | -     | -          | -                     | Fecha de vigencia.                             |
| `is_required`    | `BOOLEAN`      |         Sí | -     | -          | `TRUE`              | Indica obligatoriedad.                         |
| `created_by`     | `UUID`         |          No | -     | -          | -                     | Usuario que creó el registro.                 |
| `created_at`     | `TIMESTAMP`    |         Sí | -     | -          | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`     | `UUID`         |          No | -     | -          | -                     | Usuario que actualizó el registro.            |
| `updated_at`     | `TIMESTAMP`    |          No | -     | -          | -                     | Fecha y hora de actualización.                |
| `deleted_by`     | `UUID`         |          No | -     | -          | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`     | `TIMESTAMP`    |          No | -     | -          | -                     | Fecha y hora de eliminación lógica.          |
| `status`         | `VARCHAR(30)`  |         Sí | -     | -          | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT uk_term_condition_version UNIQUE (version)`

## Tabla `customer_loyalty`

**Descripción:** Registra nivel y puntos de fidelización del cliente.

| Campo                   | Tipo de dato    | Obligatorio | Llave  | Referencia       | Valor por defecto     | Descripción                                   |
| ----------------------- | --------------- | ----------: | ------ | ---------------- | --------------------- | ---------------------------------------------- |
| `id`                  | `UUID`        |         Sí | PK     | -                | `gen_random_uuid()` | Identificador único del registro.             |
| `customer_id`         | `UUID`        |         Sí | FK, UK | `customer(id)` | -                     | Registro relacionado de customer.              |
| `level`               | `VARCHAR(60)` |         Sí | -      | -                | `'BASIC'`           | Nivel.                                         |
| `points`              | `INTEGER`     |         Sí | -      | -                | `0`                 | Puntos acumulados.                             |
| `last_interaction_at` | `TIMESTAMP`   |          No | -      | -                | -                     | Última interacción.                          |
| `note`                | `TEXT`        |          No | -      | -                | -                     | Observación.                                  |
| `created_by`          | `UUID`        |          No | -      | -                | -                     | Usuario que creó el registro.                 |
| `created_at`          | `TIMESTAMP`   |         Sí | -      | -                | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`          | `UUID`        |          No | -      | -                | -                     | Usuario que actualizó el registro.            |
| `updated_at`          | `TIMESTAMP`   |          No | -      | -                | -                     | Fecha y hora de actualización.                |
| `deleted_by`          | `UUID`        |          No | -      | -                | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`          | `TIMESTAMP`   |          No | -      | -                | -                     | Fecha y hora de eliminación lógica.          |
| `status`              | `VARCHAR(30)` |         Sí | -      | -                | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT uk_customer_loyalty_customer UNIQUE (customer_id)`
- `CONSTRAINT fk_customer_loyalty_customer FOREIGN KEY (customer_id) REFERENCES customer (id)`
- `CONSTRAINT ck_customer_loyalty_points CHECK (points >= 0)`
