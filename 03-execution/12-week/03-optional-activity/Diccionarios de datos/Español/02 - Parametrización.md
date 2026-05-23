# Diccionario de datos - Dominio Parametrización

- `customer`
- `company`
- `day_type`
- `payment_method`
- `legal_information`
- `employee`

## Tabla `customer`

**Descripción:** Registra clientes del hotel y sus datos de contacto.

| Campo               | Tipo de dato     | Obligatorio | Llave | Referencia | Valor por defecto     | Descripción                                   |
| ------------------- | ---------------- | ----------: | ----- | ---------- | --------------------- | ---------------------------------------------- |
| `id`              | `UUID`         |         Sí | PK    | -          | `gen_random_uuid()` | Identificador único del registro.             |
| `document_type`   | `VARCHAR(30)`  |         Sí | UK    | -          | -                     | Tipo de documento.                             |
| `document_number` | `VARCHAR(40)`  |         Sí | UK    | -          | -                     | Número de documento.                          |
| `first_name`      | `VARCHAR(100)` |         Sí | -     | -          | -                     | Nombres.                                       |
| `last_name`       | `VARCHAR(100)` |         Sí | -     | -          | -                     | Apellidos.                                     |
| `phone`           | `VARCHAR(40)`  |          No | -     | -          | -                     | Teléfono de contacto.                         |
| `email`           | `VARCHAR(160)` |          No | UK    | -          | -                     | Correo electrónico.                           |
| `address`         | `VARCHAR(255)` |          No | -     | -          | -                     | Dirección.                                    |
| `created_by`      | `UUID`         |          No | -     | -          | -                     | Usuario que creó el registro.                 |
| `created_at`      | `TIMESTAMP`    |         Sí | -     | -          | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`      | `UUID`         |          No | -     | -          | -                     | Usuario que actualizó el registro.            |
| `updated_at`      | `TIMESTAMP`    |          No | -     | -          | -                     | Fecha y hora de actualización.                |
| `deleted_by`      | `UUID`         |          No | -     | -          | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`      | `TIMESTAMP`    |          No | -     | -          | -                     | Fecha y hora de eliminación lógica.          |
| `status`          | `VARCHAR(30)`  |         Sí | -     | -          | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT uk_customer_document UNIQUE (document_type, document_number)`
- `CONSTRAINT uk_customer_email UNIQUE (email)`

## Tabla `company`

**Descripción:** Registra la empresa propietaria u operadora del hotel.

| Campo          | Tipo de dato     | Obligatorio | Llave | Referencia | Valor por defecto     | Descripción                                   |
| -------------- | ---------------- | ----------: | ----- | ---------- | --------------------- | ---------------------------------------------- |
| `id`         | `UUID`         |         Sí | PK    | -          | `gen_random_uuid()` | Identificador único del registro.             |
| `name`       | `VARCHAR(160)` |         Sí | -     | -          | -                     | Nombre.                                        |
| `tax_id`     | `VARCHAR(40)`  |         Sí | UK    | -          | -                     | Identificación tributaria.                    |
| `legal_name` | `VARCHAR(180)` |         Sí | -     | -          | -                     | Razón social.                                 |
| `phone`      | `VARCHAR(40)`  |          No | -     | -          | -                     | Teléfono de contacto.                         |
| `email`      | `VARCHAR(160)` |          No | -     | -          | -                     | Correo electrónico.                           |
| `address`    | `VARCHAR(255)` |          No | -     | -          | -                     | Dirección.                                    |
| `website`    | `VARCHAR(180)` |          No | -     | -          | -                     | Sitio web.                                     |
| `created_by` | `UUID`         |          No | -     | -          | -                     | Usuario que creó el registro.                 |
| `created_at` | `TIMESTAMP`    |         Sí | -     | -          | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by` | `UUID`         |          No | -     | -          | -                     | Usuario que actualizó el registro.            |
| `updated_at` | `TIMESTAMP`    |          No | -     | -          | -                     | Fecha y hora de actualización.                |
| `deleted_by` | `UUID`         |          No | -     | -          | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at` | `TIMESTAMP`    |          No | -     | -          | -                     | Fecha y hora de eliminación lógica.          |
| `status`     | `VARCHAR(30)`  |         Sí | -     | -          | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT uk_company_tax_id UNIQUE (tax_id)`

## Tabla `day_type`

**Descripción:** Clasifica fechas o días para reglas de tarifa.

| Campo               | Tipo de dato     | Obligatorio | Llave | Referencia | Valor por defecto     | Descripción                                   |
| ------------------- | ---------------- | ----------: | ----- | ---------- | --------------------- | ---------------------------------------------- |
| `id`              | `UUID`         |         Sí | PK    | -          | `gen_random_uuid()` | Identificador único del registro.             |
| `name`            | `VARCHAR(80)`  |         Sí | UK    | -          | -                     | Nombre.                                        |
| `description`     | `VARCHAR(255)` |          No | -     | -          | -                     | Descripción.                                  |
| `date_value`      | `DATE`         |          No | UK    | -          | -                     | Fecha asociada.                                |
| `applies_season`  | `BOOLEAN`      |         Sí | -     | -          | `FALSE`             | Aplica por temporada.                          |
| `applies_holiday` | `BOOLEAN`      |         Sí | -     | -          | `FALSE`             | Aplica por festivo.                            |
| `applies_special` | `BOOLEAN`      |         Sí | -     | -          | `FALSE`             | Aplica por condición especial.                |
| `created_by`      | `UUID`         |          No | -     | -          | -                     | Usuario que creó el registro.                 |
| `created_at`      | `TIMESTAMP`    |         Sí | -     | -          | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`      | `UUID`         |          No | -     | -          | -                     | Usuario que actualizó el registro.            |
| `updated_at`      | `TIMESTAMP`    |          No | -     | -          | -                     | Fecha y hora de actualización.                |
| `deleted_by`      | `UUID`         |          No | -     | -          | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`      | `TIMESTAMP`    |          No | -     | -          | -                     | Fecha y hora de eliminación lógica.          |
| `status`          | `VARCHAR(30)`  |         Sí | -     | -          | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT uk_day_type_name_date UNIQUE (name, date_value)`

## Tabla `payment_method`

**Descripción:** Define métodos de pago disponibles.

| Campo                      | Tipo de dato     | Obligatorio | Llave | Referencia | Valor por defecto     | Descripción                                   |
| -------------------------- | ---------------- | ----------: | ----- | ---------- | --------------------- | ---------------------------------------------- |
| `id`                     | `UUID`         |         Sí | PK    | -          | `gen_random_uuid()` | Identificador único del registro.             |
| `name`                   | `VARCHAR(80)`  |         Sí | UK    | -          | -                     | Nombre.                                        |
| `description`            | `VARCHAR(255)` |          No | -     | -          | -                     | Descripción.                                  |
| `requires_reference`     | `BOOLEAN`      |         Sí | -     | -          | `FALSE`             | Requiere referencia.                           |
| `allows_partial_payment` | `BOOLEAN`      |         Sí | -     | -          | `TRUE`              | Permite pagos parciales.                       |
| `created_by`             | `UUID`         |          No | -     | -          | -                     | Usuario que creó el registro.                 |
| `created_at`             | `TIMESTAMP`    |         Sí | -     | -          | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`             | `UUID`         |          No | -     | -          | -                     | Usuario que actualizó el registro.            |
| `updated_at`             | `TIMESTAMP`    |          No | -     | -          | -                     | Fecha y hora de actualización.                |
| `deleted_by`             | `UUID`         |          No | -     | -          | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`             | `TIMESTAMP`    |          No | -     | -          | -                     | Fecha y hora de eliminación lógica.          |
| `status`                 | `VARCHAR(30)`  |         Sí | -     | -          | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT uk_payment_method_name UNIQUE (name)`

## Tabla `legal_information`

**Descripción:** Registra documentos e información legal de la empresa.

| Campo                     | Tipo de dato    | Obligatorio | Llave | Referencia      | Valor por defecto     | Descripción                                   |
| ------------------------- | --------------- | ----------: | ----- | --------------- | --------------------- | ---------------------------------------------- |
| `id`                    | `UUID`        |         Sí | PK    | -               | `gen_random_uuid()` | Identificador único del registro.             |
| `company_id`            | `UUID`        |         Sí | FK    | `company(id)` | -                     | Registro relacionado de company.               |
| `legal_document_type`   | `VARCHAR(80)` |         Sí | -     | -               | -                     | Dato propio de la tabla.                       |
| `legal_document_number` | `VARCHAR(80)` |         Sí | -     | -               | -                     | Dato propio de la tabla.                       |
| `description`           | `TEXT`        |          No | -     | -               | -                     | Descripción.                                  |
| `issue_date`            | `DATE`        |          No | -     | -               | -                     | Fecha de expedición.                          |
| `expiration_date`       | `DATE`        |          No | -     | -               | -                     | Fecha de vencimiento.                          |
| `created_by`            | `UUID`        |          No | -     | -               | -                     | Usuario que creó el registro.                 |
| `created_at`            | `TIMESTAMP`   |         Sí | -     | -               | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`            | `UUID`        |          No | -     | -               | -                     | Usuario que actualizó el registro.            |
| `updated_at`            | `TIMESTAMP`   |          No | -     | -               | -                     | Fecha y hora de actualización.                |
| `deleted_by`            | `UUID`        |          No | -     | -               | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`            | `TIMESTAMP`   |          No | -     | -               | -                     | Fecha y hora de eliminación lógica.          |
| `status`                | `VARCHAR(30)` |         Sí | -     | -               | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT fk_legal_information_company FOREIGN KEY (company_id) REFERENCES company (id)`

**Índices:**

- `ix_legal_information_company (company_id)`

## Tabla `employee`

**Descripción:** Registra empleados vinculados a una persona.

| Campo          | Tipo de dato     | Obligatorio | Llave  | Referencia     | Valor por defecto     | Descripción                                   |
| -------------- | ---------------- | ----------: | ------ | -------------- | --------------------- | ---------------------------------------------- |
| `id`         | `UUID`         |         Sí | PK     | -              | `gen_random_uuid()` | Identificador único del registro.             |
| `person_id`  | `UUID`         |         Sí | FK, UK | `person(id)` | -                     | Registro relacionado de person.                |
| `job_title`  | `VARCHAR(100)` |         Sí | -      | -              | -                     | Cargo.                                         |
| `hire_date`  | `DATE`         |         Sí | -      | -              | -                     | Fecha de contratación.                        |
| `work_phone` | `VARCHAR(40)`  |          No | -      | -              | -                     | Teléfono laboral.                             |
| `work_email` | `VARCHAR(160)` |          No | UK     | -              | -                     | Correo laboral.                                |
| `created_by` | `UUID`         |          No | -      | -              | -                     | Usuario que creó el registro.                 |
| `created_at` | `TIMESTAMP`    |         Sí | -      | -              | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by` | `UUID`         |          No | -      | -              | -                     | Usuario que actualizó el registro.            |
| `updated_at` | `TIMESTAMP`    |          No | -      | -              | -                     | Fecha y hora de actualización.                |
| `deleted_by` | `UUID`         |          No | -      | -              | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at` | `TIMESTAMP`    |          No | -      | -              | -                     | Fecha y hora de eliminación lógica.          |
| `status`     | `VARCHAR(30)`  |         Sí | -      | -              | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT uk_employee_person UNIQUE (person_id)`
- `CONSTRAINT uk_employee_work_email UNIQUE (work_email)`
- `CONSTRAINT fk_employee_person FOREIGN KEY (person_id) REFERENCES person (id)`
