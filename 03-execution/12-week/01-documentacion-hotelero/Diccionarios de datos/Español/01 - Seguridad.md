# Diccionario de datos - Dominio Seguridad

- `person`
- `app_role`
- `permission`
- `module`
- `app_view`
- `app_user`
- `user_role`
- `role_permission`
- `module_view`

## Tabla `person`

**Descripción:** Registra la información base de las personas usadas por el sistema.

| Campo               | Tipo de dato     | Obligatorio | Llave | Referencia | Valor por defecto     | Descripción                                   |
| ------------------- | ---------------- | ----------: | ----- | ---------- | --------------------- | ---------------------------------------------- |
| `id`              | `UUID`         |         Sí | PK    | -          | `gen_random_uuid()` | Identificador único del registro.             |
| `document_type`   | `VARCHAR(30)`  |         Sí | UK    | -          | -                     | Tipo de documento.                             |
| `document_number` | `VARCHAR(40)`  |         Sí | UK    | -          | -                     | Número de documento.                          |
| `first_name`      | `VARCHAR(100)` |         Sí | -     | -          | -                     | Nombres.                                       |
| `last_name`       | `VARCHAR(100)` |         Sí | -     | -          | -                     | Apellidos.                                     |
| `phone`           | `VARCHAR(40)`  |          No | -     | -          | -                     | Teléfono de contacto.                         |
| `email`           | `VARCHAR(160)` |          No | UK    | -          | -                     | Correo electrónico.                           |
| `created_by`      | `UUID`         |          No | -     | -          | -                     | Usuario que creó el registro.                 |
| `created_at`      | `TIMESTAMP`    |         Sí | -     | -          | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`      | `UUID`         |          No | -     | -          | -                     | Usuario que actualizó el registro.            |
| `updated_at`      | `TIMESTAMP`    |          No | -     | -          | -                     | Fecha y hora de actualización.                |
| `deleted_by`      | `UUID`         |          No | -     | -          | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`      | `TIMESTAMP`    |          No | -     | -          | -                     | Fecha y hora de eliminación lógica.          |
| `status`          | `VARCHAR(30)`  |         Sí | -     | -          | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT uk_person_document UNIQUE (document_type, document_number)`
- `CONSTRAINT uk_person_email UNIQUE (email)`

## Tabla `app_role`

**Descripción:** Define los roles de aplicación asignables a los usuarios.

| Campo           | Tipo de dato     | Obligatorio | Llave | Referencia | Valor por defecto     | Descripción                                   |
| --------------- | ---------------- | ----------: | ----- | ---------- | --------------------- | ---------------------------------------------- |
| `id`          | `UUID`         |         Sí | PK    | -          | `gen_random_uuid()` | Identificador único del registro.             |
| `name`        | `VARCHAR(80)`  |         Sí | UK    | -          | -                     | Nombre.                                        |
| `description` | `VARCHAR(255)` |          No | -     | -          | -                     | Descripción.                                  |
| `created_by`  | `UUID`         |          No | -     | -          | -                     | Usuario que creó el registro.                 |
| `created_at`  | `TIMESTAMP`    |         Sí | -     | -          | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`  | `UUID`         |          No | -     | -          | -                     | Usuario que actualizó el registro.            |
| `updated_at`  | `TIMESTAMP`    |          No | -     | -          | -                     | Fecha y hora de actualización.                |
| `deleted_by`  | `UUID`         |          No | -     | -          | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`  | `TIMESTAMP`    |          No | -     | -          | -                     | Fecha y hora de eliminación lógica.          |
| `status`      | `VARCHAR(30)`  |         Sí | -     | -          | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT uk_app_role_name UNIQUE (name)`

## Tabla `permission`

**Descripción:** Define permisos y acciones que controlan el acceso funcional.

| Campo           | Tipo de dato     | Obligatorio | Llave | Referencia | Valor por defecto     | Descripción                                   |
| --------------- | ---------------- | ----------: | ----- | ---------- | --------------------- | ---------------------------------------------- |
| `id`          | `UUID`         |         Sí | PK    | -          | `gen_random_uuid()` | Identificador único del registro.             |
| `name`        | `VARCHAR(120)` |         Sí | UK    | -          | -                     | Nombre.                                        |
| `description` | `VARCHAR(255)` |          No | -     | -          | -                     | Descripción.                                  |
| `action`      | `VARCHAR(80)`  |         Sí | UK    | -          | -                     | Acción permitida.                             |
| `created_by`  | `UUID`         |          No | -     | -          | -                     | Usuario que creó el registro.                 |
| `created_at`  | `TIMESTAMP`    |         Sí | -     | -          | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`  | `UUID`         |          No | -     | -          | -                     | Usuario que actualizó el registro.            |
| `updated_at`  | `TIMESTAMP`    |          No | -     | -          | -                     | Fecha y hora de actualización.                |
| `deleted_by`  | `UUID`         |          No | -     | -          | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`  | `TIMESTAMP`    |          No | -     | -          | -                     | Fecha y hora de eliminación lógica.          |
| `status`      | `VARCHAR(30)`  |         Sí | -     | -          | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT uk_permission_name_action UNIQUE (name, action)`

## Tabla `module`

**Descripción:** Registra módulos funcionales y sus rutas base.

| Campo           | Tipo de dato     | Obligatorio | Llave | Referencia | Valor por defecto     | Descripción                                   |
| --------------- | ---------------- | ----------: | ----- | ---------- | --------------------- | ---------------------------------------------- |
| `id`          | `UUID`         |         Sí | PK    | -          | `gen_random_uuid()` | Identificador único del registro.             |
| `name`        | `VARCHAR(100)` |         Sí | UK    | -          | -                     | Nombre.                                        |
| `description` | `VARCHAR(255)` |          No | -     | -          | -                     | Descripción.                                  |
| `base_path`   | `VARCHAR(160)` |         Sí | UK    | -          | -                     | Ruta base.                                     |
| `created_by`  | `UUID`         |          No | -     | -          | -                     | Usuario que creó el registro.                 |
| `created_at`  | `TIMESTAMP`    |         Sí | -     | -          | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`  | `UUID`         |          No | -     | -          | -                     | Usuario que actualizó el registro.            |
| `updated_at`  | `TIMESTAMP`    |          No | -     | -          | -                     | Fecha y hora de actualización.                |
| `deleted_by`  | `UUID`         |          No | -     | -          | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`  | `TIMESTAMP`    |          No | -     | -          | -                     | Fecha y hora de eliminación lógica.          |
| `status`      | `VARCHAR(30)`  |         Sí | -     | -          | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT uk_module_name UNIQUE (name)`
- `CONSTRAINT uk_module_base_path UNIQUE (base_path)`

## Tabla `app_view`

**Descripción:** Registra vistas o pantallas asociadas a un módulo.

| Campo           | Tipo de dato     | Obligatorio | Llave  | Referencia     | Valor por defecto     | Descripción                                   |
| --------------- | ---------------- | ----------: | ------ | -------------- | --------------------- | ---------------------------------------------- |
| `id`          | `UUID`         |         Sí | PK     | -              | `gen_random_uuid()` | Identificador único del registro.             |
| `module_id`   | `UUID`         |         Sí | FK, UK | `module(id)` | -                     | Registro relacionado de module.                |
| `name`        | `VARCHAR(120)` |         Sí | -      | -              | -                     | Nombre.                                        |
| `description` | `VARCHAR(255)` |          No | -      | -              | -                     | Descripción.                                  |
| `path`        | `VARCHAR(180)` |         Sí | UK     | -              | -                     | Ruta de acceso.                                |
| `created_by`  | `UUID`         |          No | -      | -              | -                     | Usuario que creó el registro.                 |
| `created_at`  | `TIMESTAMP`    |         Sí | -      | -              | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`  | `UUID`         |          No | -      | -              | -                     | Usuario que actualizó el registro.            |
| `updated_at`  | `TIMESTAMP`    |          No | -      | -              | -                     | Fecha y hora de actualización.                |
| `deleted_by`  | `UUID`         |          No | -      | -              | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`  | `TIMESTAMP`    |          No | -      | -              | -                     | Fecha y hora de eliminación lógica.          |
| `status`      | `VARCHAR(30)`  |         Sí | -      | -              | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT uk_app_view_module_path UNIQUE (module_id, path)`
- `CONSTRAINT fk_app_view_module FOREIGN KEY (module_id) REFERENCES module (id)`

## Tabla `app_user`

**Descripción:** Registra credenciales y estado de acceso de usuarios.

| Campo              | Tipo de dato     | Obligatorio | Llave  | Referencia     | Valor por defecto     | Descripción                                   |
| ------------------ | ---------------- | ----------: | ------ | -------------- | --------------------- | ---------------------------------------------- |
| `id`             | `UUID`         |         Sí | PK     | -              | `gen_random_uuid()` | Identificador único del registro.             |
| `person_id`      | `UUID`         |         Sí | FK, UK | `person(id)` | -                     | Registro relacionado de person.                |
| `username`       | `VARCHAR(80)`  |         Sí | UK     | -              | -                     | Nombre de usuario.                             |
| `password_hash`  | `VARCHAR(255)` |         Sí | -      | -              | -                     | Contraseña cifrada en hash.                   |
| `last_access_at` | `TIMESTAMP`    |          No | -      | -              | -                     | Último acceso.                                |
| `is_blocked`     | `BOOLEAN`      |         Sí | -      | -              | `FALSE`             | Indica si está bloqueado.                     |
| `created_by`     | `UUID`         |          No | -      | -              | -                     | Usuario que creó el registro.                 |
| `created_at`     | `TIMESTAMP`    |         Sí | -      | -              | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`     | `UUID`         |          No | -      | -              | -                     | Usuario que actualizó el registro.            |
| `updated_at`     | `TIMESTAMP`    |          No | -      | -              | -                     | Fecha y hora de actualización.                |
| `deleted_by`     | `UUID`         |          No | -      | -              | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`     | `TIMESTAMP`    |          No | -      | -              | -                     | Fecha y hora de eliminación lógica.          |
| `status`         | `VARCHAR(30)`  |         Sí | -      | -              | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT uk_app_user_person UNIQUE (person_id)`
- `CONSTRAINT uk_app_user_username UNIQUE (username)`
- `CONSTRAINT fk_app_user_person FOREIGN KEY (person_id) REFERENCES person (id)`

## Tabla `user_role`

**Descripción:** Relaciona usuarios con roles de aplicación.

| Campo          | Tipo de dato    | Obligatorio | Llave  | Referencia       | Valor por defecto     | Descripción                                   |
| -------------- | --------------- | ----------: | ------ | ---------------- | --------------------- | ---------------------------------------------- |
| `id`         | `UUID`        |         Sí | PK     | -                | `gen_random_uuid()` | Identificador único del registro.             |
| `user_id`    | `UUID`        |         Sí | FK, UK | `app_user(id)` | -                     | Registro relacionado de user.                  |
| `role_id`    | `UUID`        |         Sí | FK, UK | `app_role(id)` | -                     | Registro relacionado de role.                  |
| `created_by` | `UUID`        |          No | -      | -                | -                     | Usuario que creó el registro.                 |
| `created_at` | `TIMESTAMP`   |         Sí | -      | -                | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by` | `UUID`        |          No | -      | -                | -                     | Usuario que actualizó el registro.            |
| `updated_at` | `TIMESTAMP`   |          No | -      | -                | -                     | Fecha y hora de actualización.                |
| `deleted_by` | `UUID`        |          No | -      | -                | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at` | `TIMESTAMP`   |          No | -      | -                | -                     | Fecha y hora de eliminación lógica.          |
| `status`     | `VARCHAR(30)` |         Sí | -      | -                | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT uk_user_role UNIQUE (user_id, role_id)`
- `CONSTRAINT fk_user_role_user FOREIGN KEY (user_id) REFERENCES app_user (id)`
- `CONSTRAINT fk_user_role_role FOREIGN KEY (role_id) REFERENCES app_role (id)`

## Tabla `role_permission`

**Descripción:** Relaciona roles con permisos específicos.

| Campo             | Tipo de dato    | Obligatorio | Llave  | Referencia         | Valor por defecto     | Descripción                                   |
| ----------------- | --------------- | ----------: | ------ | ------------------ | --------------------- | ---------------------------------------------- |
| `id`            | `UUID`        |         Sí | PK     | -                  | `gen_random_uuid()` | Identificador único del registro.             |
| `role_id`       | `UUID`        |         Sí | FK, UK | `app_role(id)`   | -                     | Registro relacionado de role.                  |
| `permission_id` | `UUID`        |         Sí | FK, UK | `permission(id)` | -                     | Registro relacionado de permission.            |
| `created_by`    | `UUID`        |          No | -      | -                  | -                     | Usuario que creó el registro.                 |
| `created_at`    | `TIMESTAMP`   |         Sí | -      | -                  | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`    | `UUID`        |          No | -      | -                  | -                     | Usuario que actualizó el registro.            |
| `updated_at`    | `TIMESTAMP`   |          No | -      | -                  | -                     | Fecha y hora de actualización.                |
| `deleted_by`    | `UUID`        |          No | -      | -                  | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`    | `TIMESTAMP`   |          No | -      | -                  | -                     | Fecha y hora de eliminación lógica.          |
| `status`        | `VARCHAR(30)` |         Sí | -      | -                  | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT uk_role_permission UNIQUE (role_id, permission_id)`
- `CONSTRAINT fk_role_permission_role FOREIGN KEY (role_id) REFERENCES app_role (id)`
- `CONSTRAINT fk_role_permission_permission FOREIGN KEY (permission_id) REFERENCES permission (id)`

## Tabla `module_view`

**Descripción:** Relaciona módulos con vistas disponibles.

| Campo          | Tipo de dato    | Obligatorio | Llave  | Referencia       | Valor por defecto     | Descripción                                   |
| -------------- | --------------- | ----------: | ------ | ---------------- | --------------------- | ---------------------------------------------- |
| `id`         | `UUID`        |         Sí | PK     | -                | `gen_random_uuid()` | Identificador único del registro.             |
| `module_id`  | `UUID`        |         Sí | FK, UK | `module(id)`   | -                     | Registro relacionado de module.                |
| `view_id`    | `UUID`        |         Sí | FK, UK | `app_view(id)` | -                     | Registro relacionado de view.                  |
| `created_by` | `UUID`        |          No | -      | -                | -                     | Usuario que creó el registro.                 |
| `created_at` | `TIMESTAMP`   |         Sí | -      | -                | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by` | `UUID`        |          No | -      | -                | -                     | Usuario que actualizó el registro.            |
| `updated_at` | `TIMESTAMP`   |          No | -      | -                | -                     | Fecha y hora de actualización.                |
| `deleted_by` | `UUID`        |          No | -      | -                | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at` | `TIMESTAMP`   |          No | -      | -                | -                     | Fecha y hora de eliminación lógica.          |
| `status`     | `VARCHAR(30)` |         Sí | -      | -                | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT uk_module_view UNIQUE (module_id, view_id)`
- `CONSTRAINT fk_module_view_module FOREIGN KEY (module_id) REFERENCES module (id)`
- `CONSTRAINT fk_module_view_view FOREIGN KEY (view_id) REFERENCES app_view (id)`
