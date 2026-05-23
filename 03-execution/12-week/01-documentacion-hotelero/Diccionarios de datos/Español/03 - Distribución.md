# Diccionario de datos - Dominio Distribución

- `branch`
- `room_type`
- `room_status`
- `room`
- `rate`

## Tabla `branch`

**Descripción:** Registra sedes o sucursales de una empresa.

| Campo          | Tipo de dato     | Obligatorio | Llave  | Referencia      | Valor por defecto     | Descripción                                   |
| -------------- | ---------------- | ----------: | ------ | --------------- | --------------------- | ---------------------------------------------- |
| `id`         | `UUID`         |         Sí | PK     | -               | `gen_random_uuid()` | Identificador único del registro.             |
| `company_id` | `UUID`         |         Sí | FK, UK | `company(id)` | -                     | Registro relacionado de company.               |
| `name`       | `VARCHAR(160)` |         Sí | UK     | -               | -                     | Nombre.                                        |
| `address`    | `VARCHAR(255)` |         Sí | -      | -               | -                     | Dirección.                                    |
| `city`       | `VARCHAR(120)` |         Sí | -      | -               | -                     | Ciudad.                                        |
| `phone`      | `VARCHAR(40)`  |          No | -      | -               | -                     | Teléfono de contacto.                         |
| `email`      | `VARCHAR(160)` |          No | -      | -               | -                     | Correo electrónico.                           |
| `created_by` | `UUID`         |          No | -      | -               | -                     | Usuario que creó el registro.                 |
| `created_at` | `TIMESTAMP`    |         Sí | -      | -               | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by` | `UUID`         |          No | -      | -               | -                     | Usuario que actualizó el registro.            |
| `updated_at` | `TIMESTAMP`    |          No | -      | -               | -                     | Fecha y hora de actualización.                |
| `deleted_by` | `UUID`         |          No | -      | -               | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at` | `TIMESTAMP`    |          No | -      | -               | -                     | Fecha y hora de eliminación lógica.          |
| `status`     | `VARCHAR(30)`  |         Sí | -      | -               | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT uk_branch_company_name UNIQUE (company_id, name)`
- `CONSTRAINT fk_branch_company FOREIGN KEY (company_id) REFERENCES company (id)`

## Tabla `room_type`

**Descripción:** Define tipos de habitación y capacidades.

| Campo             | Tipo de dato     | Obligatorio | Llave | Referencia | Valor por defecto     | Descripción                                   |
| ----------------- | ---------------- | ----------: | ----- | ---------- | --------------------- | ---------------------------------------------- |
| `id`            | `UUID`         |         Sí | PK    | -          | `gen_random_uuid()` | Identificador único del registro.             |
| `name`          | `VARCHAR(80)`  |         Sí | UK    | -          | -                     | Nombre.                                        |
| `description`   | `VARCHAR(255)` |          No | -     | -          | -                     | Descripción.                                  |
| `base_capacity` | `SMALLINT`     |         Sí | -     | -          | -                     | Capacidad base.                                |
| `max_capacity`  | `SMALLINT`     |         Sí | -     | -          | -                     | Capacidad máxima.                             |
| `created_by`    | `UUID`         |          No | -     | -          | -                     | Usuario que creó el registro.                 |
| `created_at`    | `TIMESTAMP`    |         Sí | -     | -          | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`    | `UUID`         |          No | -     | -          | -                     | Usuario que actualizó el registro.            |
| `updated_at`    | `TIMESTAMP`    |          No | -     | -          | -                     | Fecha y hora de actualización.                |
| `deleted_by`    | `UUID`         |          No | -     | -          | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`    | `TIMESTAMP`    |          No | -     | -          | -                     | Fecha y hora de eliminación lógica.          |
| `status`        | `VARCHAR(30)`  |         Sí | -     | -          | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT uk_room_type_name UNIQUE (name)`
- `CONSTRAINT ck_room_type_capacity CHECK (max_capacity >= base_capacity)`

## Tabla `room_status`

**Descripción:** Define estados operativos de habitación.

| Campo                  | Tipo de dato     | Obligatorio | Llave | Referencia | Valor por defecto     | Descripción                                   |
| ---------------------- | ---------------- | ----------: | ----- | ---------- | --------------------- | ---------------------------------------------- |
| `id`                 | `UUID`         |         Sí | PK    | -          | `gen_random_uuid()` | Identificador único del registro.             |
| `name`               | `VARCHAR(80)`  |         Sí | UK    | -          | -                     | Nombre.                                        |
| `description`        | `VARCHAR(255)` |          No | -     | -          | -                     | Descripción.                                  |
| `allows_reservation` | `BOOLEAN`      |         Sí | -     | -          | `FALSE`             | Permite reserva.                               |
| `allows_check_in`    | `BOOLEAN`      |         Sí | -     | -          | `FALSE`             | Permite check-in.                              |
| `created_by`         | `UUID`         |          No | -     | -          | -                     | Usuario que creó el registro.                 |
| `created_at`         | `TIMESTAMP`    |         Sí | -     | -          | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`         | `UUID`         |          No | -     | -          | -                     | Usuario que actualizó el registro.            |
| `updated_at`         | `TIMESTAMP`    |          No | -     | -          | -                     | Fecha y hora de actualización.                |
| `deleted_by`         | `UUID`         |          No | -     | -          | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`         | `TIMESTAMP`    |          No | -     | -          | -                     | Fecha y hora de eliminación lógica.          |
| `status`             | `VARCHAR(30)`  |         Sí | -     | -          | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT uk_room_status_name UNIQUE (name)`

## Tabla `room`

**Descripción:** Registra habitaciones físicas por sede.

| Campo              | Tipo de dato     | Obligatorio | Llave  | Referencia          | Valor por defecto     | Descripción                                   |
| ------------------ | ---------------- | ----------: | ------ | ------------------- | --------------------- | ---------------------------------------------- |
| `id`             | `UUID`         |         Sí | PK     | -                   | `gen_random_uuid()` | Identificador único del registro.             |
| `branch_id`      | `UUID`         |         Sí | FK, UK | `branch(id)`      | -                     | Registro relacionado de branch.                |
| `room_type_id`   | `UUID`         |         Sí | FK     | `room_type(id)`   | -                     | Registro relacionado de room_type.             |
| `room_status_id` | `UUID`         |         Sí | FK     | `room_status(id)` | -                     | Registro relacionado de room_status.           |
| `room_number`    | `VARCHAR(20)`  |         Sí | UK     | -                   | -                     | Número de habitación.                        |
| `floor_number`   | `SMALLINT`     |          No | -      | -                   | -                     | Número de piso.                               |
| `capacity`       | `SMALLINT`     |         Sí | -      | -                   | -                     | Capacidad.                                     |
| `description`    | `VARCHAR(255)` |          No | -      | -                   | -                     | Descripción.                                  |
| `created_by`     | `UUID`         |          No | -      | -                   | -                     | Usuario que creó el registro.                 |
| `created_at`     | `TIMESTAMP`    |         Sí | -      | -                   | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`     | `UUID`         |          No | -      | -                   | -                     | Usuario que actualizó el registro.            |
| `updated_at`     | `TIMESTAMP`    |          No | -      | -                   | -                     | Fecha y hora de actualización.                |
| `deleted_by`     | `UUID`         |          No | -      | -                   | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`     | `TIMESTAMP`    |          No | -      | -                   | -                     | Fecha y hora de eliminación lógica.          |
| `status`         | `VARCHAR(30)`  |         Sí | -      | -                   | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT uk_room_branch_number UNIQUE (branch_id, room_number)`
- `CONSTRAINT fk_room_branch FOREIGN KEY (branch_id) REFERENCES branch (id)`
- `CONSTRAINT fk_room_type FOREIGN KEY (room_type_id) REFERENCES room_type (id)`
- `CONSTRAINT fk_room_status FOREIGN KEY (room_status_id) REFERENCES room_status (id)`

**Índices:**

- `ix_room_type (room_type_id)`
- `ix_room_status (room_status_id)`

## Tabla `rate`

**Descripción:** Define tarifas por tipo de habitación y tipo de día.

| Campo              | Tipo de dato      | Obligatorio | Llave  | Referencia        | Valor por defecto     | Descripción                                   |
| ------------------ | ----------------- | ----------: | ------ | ----------------- | --------------------- | ---------------------------------------------- |
| `id`             | `UUID`          |         Sí | PK     | -                 | `gen_random_uuid()` | Identificador único del registro.             |
| `room_type_id`   | `UUID`          |         Sí | FK, UK | `room_type(id)` | -                     | Registro relacionado de room_type.             |
| `day_type_id`    | `UUID`          |         Sí | FK, UK | `day_type(id)`  | -                     | Registro relacionado de day_type.              |
| `amount`         | `NUMERIC(12,2)` |         Sí | -      | -                 | -                     | Valor monetario.                               |
| `start_date`     | `DATE`          |         Sí | UK     | -                 | -                     | Fecha inicial.                                 |
| `end_date`       | `DATE`          |          No | -      | -                 | -                     | Fecha final.                                   |
| `condition_note` | `VARCHAR(255)`  |          No | -      | -                 | -                     | Nota de condición.                            |
| `created_by`     | `UUID`          |          No | -      | -                 | -                     | Usuario que creó el registro.                 |
| `created_at`     | `TIMESTAMP`     |         Sí | -      | -                 | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`     | `UUID`          |          No | -      | -                 | -                     | Usuario que actualizó el registro.            |
| `updated_at`     | `TIMESTAMP`     |          No | -      | -                 | -                     | Fecha y hora de actualización.                |
| `deleted_by`     | `UUID`          |          No | -      | -                 | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`     | `TIMESTAMP`     |          No | -      | -                 | -                     | Fecha y hora de eliminación lógica.          |
| `status`         | `VARCHAR(30)`   |         Sí | -      | -                 | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT uk_rate_room_day_start UNIQUE (room_type_id, day_type_id, start_date)`
- `CONSTRAINT fk_rate_room_type FOREIGN KEY (room_type_id) REFERENCES room_type (id)`
- `CONSTRAINT fk_rate_day_type FOREIGN KEY (day_type_id) REFERENCES day_type (id)`
- `CONSTRAINT ck_rate_amount CHECK (amount >= 0)`

**Índices:**

- `ix_rate_room_type (room_type_id)`
- `ix_rate_day_type (day_type_id)`
