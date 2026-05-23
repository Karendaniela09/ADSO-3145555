# Diccionario de datos - Dominio Mantenimiento

- `room_maintenance`
- `usage_maintenance`
- `remodeling_maintenance`
- `maintenance_dashboard`

## Tabla `room_maintenance`

**Descripción:** Registra mantenimientos realizados o programados a habitaciones.

| Campo                  | Tipo de dato    | Obligatorio | Llave | Referencia       | Valor por defecto     | Descripción                                   |
| ---------------------- | --------------- | ----------: | ----- | ---------------- | --------------------- | ---------------------------------------------- |
| `id`                 | `UUID`        |         Sí | PK    | -                | `gen_random_uuid()` | Identificador único del registro.             |
| `room_id`            | `UUID`        |         Sí | FK    | `room(id)`     | -                     | Registro relacionado de room.                  |
| `employee_id`        | `UUID`        |          No | FK    | `employee(id)` | -                     | Registro relacionado de employee.              |
| `maintenance_type`   | `VARCHAR(60)` |         Sí | -     | -                | -                     | Tipo de mantenimiento.                         |
| `start_at`           | `TIMESTAMP`   |         Sí | -     | -                | -                     | Fecha y hora inicial.                          |
| `end_at`             | `TIMESTAMP`   |          No | -     | -                | -                     | Fecha y hora final.                            |
| `maintenance_status` | `VARCHAR(40)` |         Sí | -     | -                | `'PENDING'`         | Estado de mantenimiento.                       |
| `note`               | `TEXT`        |          No | -     | -                | -                     | Observación.                                  |
| `created_by`         | `UUID`        |          No | -     | -                | -                     | Usuario que creó el registro.                 |
| `created_at`         | `TIMESTAMP`   |         Sí | -     | -                | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`         | `UUID`        |          No | -     | -                | -                     | Usuario que actualizó el registro.            |
| `updated_at`         | `TIMESTAMP`   |          No | -     | -                | -                     | Fecha y hora de actualización.                |
| `deleted_by`         | `UUID`        |          No | -     | -                | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`         | `TIMESTAMP`   |          No | -     | -                | -                     | Fecha y hora de eliminación lógica.          |
| `status`             | `VARCHAR(30)` |         Sí | -     | -                | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT fk_room_maintenance_room FOREIGN KEY (room_id) REFERENCES room (id)`
- `CONSTRAINT fk_room_maintenance_employee FOREIGN KEY (employee_id) REFERENCES employee (id)`

**Índices:**

- `ix_room_maintenance_room_dates (room_id, start_at, end_at)`
- `ix_room_maintenance_employee (employee_id)`

## Tabla `usage_maintenance`

**Descripción:** Registra mantenimientos asociados al uso de la habitación.

| Campo                   | Tipo de dato     | Obligatorio | Llave  | Referencia               | Valor por defecto     | Descripción                                   |
| ----------------------- | ---------------- | ----------: | ------ | ------------------------ | --------------------- | ---------------------------------------------- |
| `id`                  | `UUID`         |         Sí | PK     | -                        | `gen_random_uuid()` | Identificador único del registro.             |
| `room_maintenance_id` | `UUID`         |         Sí | FK, UK | `room_maintenance(id)` | -                     | Registro relacionado de room_maintenance.      |
| `usage_reason`        | `VARCHAR(160)` |         Sí | -      | -                        | -                     | Razón de uso.                                 |
| `activity_detail`     | `TEXT`         |          No | -      | -                        | -                     | Detalle de actividad.                          |
| `created_by`          | `UUID`         |          No | -      | -                        | -                     | Usuario que creó el registro.                 |
| `created_at`          | `TIMESTAMP`    |         Sí | -      | -                        | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`          | `UUID`         |          No | -      | -                        | -                     | Usuario que actualizó el registro.            |
| `updated_at`          | `TIMESTAMP`    |          No | -      | -                        | -                     | Fecha y hora de actualización.                |
| `deleted_by`          | `UUID`         |          No | -      | -                        | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`          | `TIMESTAMP`    |          No | -      | -                        | -                     | Fecha y hora de eliminación lógica.          |
| `status`              | `VARCHAR(30)`  |         Sí | -      | -                        | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT uk_usage_maintenance_base UNIQUE (room_maintenance_id)`
- `CONSTRAINT fk_usage_maintenance_base FOREIGN KEY (room_maintenance_id) REFERENCES room_maintenance (id)`

## Tabla `remodeling_maintenance`

**Descripción:** Registra mantenimientos de remodelación y presupuesto estimado.

| Campo                      | Tipo de dato      | Obligatorio | Llave  | Referencia               | Valor por defecto     | Descripción                                   |
| -------------------------- | ----------------- | ----------: | ------ | ------------------------ | --------------------- | ---------------------------------------------- |
| `id`                     | `UUID`          |         Sí | PK     | -                        | `gen_random_uuid()` | Identificador único del registro.             |
| `room_maintenance_id`    | `UUID`          |         Sí | FK, UK | `room_maintenance(id)` | -                     | Registro relacionado de room_maintenance.      |
| `remodeling_description` | `TEXT`          |         Sí | -      | -                        | -                     | Descripción de remodelación.                 |
| `estimated_budget`       | `NUMERIC(12,2)` |          No | -      | -                        | -                     | Presupuesto estimado.                          |
| `created_by`             | `UUID`          |          No | -      | -                        | -                     | Usuario que creó el registro.                 |
| `created_at`             | `TIMESTAMP`     |         Sí | -      | -                        | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`             | `UUID`          |          No | -      | -                        | -                     | Usuario que actualizó el registro.            |
| `updated_at`             | `TIMESTAMP`     |          No | -      | -                        | -                     | Fecha y hora de actualización.                |
| `deleted_by`             | `UUID`          |          No | -      | -                        | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`             | `TIMESTAMP`     |          No | -      | -                        | -                     | Fecha y hora de eliminación lógica.          |
| `status`                 | `VARCHAR(30)`   |         Sí | -      | -                        | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT uk_remodeling_maintenance_base UNIQUE (room_maintenance_id)`
- `CONSTRAINT fk_remodeling_maintenance_base FOREIGN KEY (room_maintenance_id) REFERENCES room_maintenance (id)`
- `CONSTRAINT ck_remodeling_maintenance_budget CHECK (estimated_budget IS NULL OR estimated_budget >= 0)`

## Tabla `maintenance_dashboard`

**Descripción:** Registra métricas consolidadas de habitaciones por sede.

| Campo                 | Tipo de dato    | Obligatorio | Llave | Referencia     | Valor por defecto     | Descripción                                   |
| --------------------- | --------------- | ----------: | ----- | -------------- | --------------------- | ---------------------------------------------- |
| `id`                | `UUID`        |         Sí | PK    | -              | `gen_random_uuid()` | Identificador único del registro.             |
| `branch_id`         | `UUID`        |         Sí | FK    | `branch(id)` | -                     | Registro relacionado de branch.                |
| `total_rooms`       | `INTEGER`     |         Sí | -     | -              | `0`                 | Total de habitaciones.                         |
| `available_rooms`   | `INTEGER`     |         Sí | -     | -              | `0`                 | Habitaciones disponibles.                      |
| `occupied_rooms`    | `INTEGER`     |         Sí | -     | -              | `0`                 | Habitaciones ocupadas.                         |
| `maintenance_rooms` | `INTEGER`     |         Sí | -     | -              | `0`                 | Habitaciones en mantenimiento.                 |
| `cutoff_at`         | `TIMESTAMP`   |         Sí | -     | -              | `CURRENT_TIMESTAMP` | Fecha y hora de corte.                         |
| `created_by`        | `UUID`        |          No | -     | -              | -                     | Usuario que creó el registro.                 |
| `created_at`        | `TIMESTAMP`   |         Sí | -     | -              | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`        | `UUID`        |          No | -     | -              | -                     | Usuario que actualizó el registro.            |
| `updated_at`        | `TIMESTAMP`   |          No | -     | -              | -                     | Fecha y hora de actualización.                |
| `deleted_by`        | `UUID`        |          No | -     | -              | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`        | `TIMESTAMP`   |          No | -     | -              | -                     | Fecha y hora de eliminación lógica.          |
| `status`            | `VARCHAR(30)` |         Sí | -     | -              | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT fk_maintenance_dashboard_branch FOREIGN KEY (branch_id) REFERENCES branch (id)`
- `CONSTRAINT ck_maintenance_dashboard_totals CHECK ( total_rooms >= 0 AND available_rooms >= 0 AND occupied_rooms >= 0 AND maintenance_rooms >= 0 )`

**Índices:**

- `ix_maintenance_dashboard_branch_cutoff (branch_id, cutoff_at)`
