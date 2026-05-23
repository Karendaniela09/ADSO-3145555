# Diccionario de datos - Dominio Facturación

- `proforma_invoice`
- `invoice`
- `partial_payment`
- `invoice_detail`

## Tabla `proforma_invoice`

**Descripción:** Registra prefacturas calculadas para una estadía o reserva.

| Campo                   | Tipo de dato      | Obligatorio | Llave  | Referencia               | Valor por defecto     | Descripción                                   |
| ----------------------- | ----------------- | ----------: | ------ | ------------------------ | --------------------- | ---------------------------------------------- |
| `id`                  | `UUID`          |         Sí | PK     | -                        | `gen_random_uuid()` | Identificador único del registro.             |
| `stay_id`             | `UUID`          |         Sí | FK, UK | `stay(id)`             | -                     | Registro relacionado de stay.                  |
| `room_reservation_id` | `UUID`          |         Sí | FK     | `room_reservation(id)` | -                     | Registro relacionado de room_reservation.      |
| `customer_id`         | `UUID`          |         Sí | FK     | `customer(id)`         | -                     | Registro relacionado de customer.              |
| `subtotal`            | `NUMERIC(12,2)` |         Sí | -      | -                        | `0`                 | Subtotal.                                      |
| `tax_amount`          | `NUMERIC(12,2)` |         Sí | -      | -                        | `0`                 | Valor de impuestos.                            |
| `discount_amount`     | `NUMERIC(12,2)` |         Sí | -      | -                        | `0`                 | Valor de descuento.                            |
| `total_amount`        | `NUMERIC(12,2)` |         Sí | -      | -                        | `0`                 | Valor total.                                   |
| `created_by`          | `UUID`          |          No | -      | -                        | -                     | Usuario que creó el registro.                 |
| `created_at`          | `TIMESTAMP`     |         Sí | -      | -                        | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`          | `UUID`          |          No | -      | -                        | -                     | Usuario que actualizó el registro.            |
| `updated_at`          | `TIMESTAMP`     |          No | -      | -                        | -                     | Fecha y hora de actualización.                |
| `deleted_by`          | `UUID`          |          No | -      | -                        | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`          | `TIMESTAMP`     |          No | -      | -                        | -                     | Fecha y hora de eliminación lógica.          |
| `status`              | `VARCHAR(30)`   |         Sí | -      | -                        | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT uk_proforma_invoice_stay UNIQUE (stay_id)`
- `CONSTRAINT fk_proforma_invoice_stay FOREIGN KEY (stay_id) REFERENCES stay (id)`
- `CONSTRAINT fk_proforma_invoice_reservation FOREIGN KEY (room_reservation_id) REFERENCES room_reservation (id)`
- `CONSTRAINT fk_proforma_invoice_customer FOREIGN KEY (customer_id) REFERENCES customer (id)`
- `CONSTRAINT ck_proforma_invoice_values CHECK (subtotal >= 0 AND tax_amount >= 0 AND discount_amount >= 0 AND total_amount >= 0)`

**Índices:**

- `ix_proforma_invoice_reservation (room_reservation_id)`
- `ix_proforma_invoice_customer (customer_id)`

## Tabla `invoice`

**Descripción:** Registra facturas emitidas al cliente.

| Campo               | Tipo de dato      | Obligatorio | Llave  | Referencia       | Valor por defecto     | Descripción                                   |
| ------------------- | ----------------- | ----------: | ------ | ---------------- | --------------------- | ---------------------------------------------- |
| `id`              | `UUID`          |         Sí | PK     | -                | `gen_random_uuid()` | Identificador único del registro.             |
| `customer_id`     | `UUID`          |         Sí | FK     | `customer(id)` | -                     | Registro relacionado de customer.              |
| `stay_id`         | `UUID`          |         Sí | FK, UK | `stay(id)`     | -                     | Registro relacionado de stay.                  |
| `invoice_number`  | `VARCHAR(60)`   |         Sí | UK     | -                | -                     | Número de factura.                            |
| `issued_at`       | `TIMESTAMP`     |         Sí | -      | -                | `CURRENT_TIMESTAMP` | Fecha y hora de emisión.                      |
| `subtotal`        | `NUMERIC(12,2)` |         Sí | -      | -                | `0`                 | Subtotal.                                      |
| `tax_amount`      | `NUMERIC(12,2)` |         Sí | -      | -                | `0`                 | Valor de impuestos.                            |
| `discount_amount` | `NUMERIC(12,2)` |         Sí | -      | -                | `0`                 | Valor de descuento.                            |
| `total_amount`    | `NUMERIC(12,2)` |         Sí | -      | -                | `0`                 | Valor total.                                   |
| `invoice_status`  | `VARCHAR(40)`   |         Sí | -      | -                | `'ISSUED'`          | Estado de factura.                             |
| `created_by`      | `UUID`          |          No | -      | -                | -                     | Usuario que creó el registro.                 |
| `created_at`      | `TIMESTAMP`     |         Sí | -      | -                | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`      | `UUID`          |          No | -      | -                | -                     | Usuario que actualizó el registro.            |
| `updated_at`      | `TIMESTAMP`     |          No | -      | -                | -                     | Fecha y hora de actualización.                |
| `deleted_by`      | `UUID`          |          No | -      | -                | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`      | `TIMESTAMP`     |          No | -      | -                | -                     | Fecha y hora de eliminación lógica.          |
| `status`          | `VARCHAR(30)`   |         Sí | -      | -                | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT uk_invoice_number UNIQUE (invoice_number)`
- `CONSTRAINT uk_invoice_stay UNIQUE (stay_id)`
- `CONSTRAINT fk_invoice_customer FOREIGN KEY (customer_id) REFERENCES customer (id)`
- `CONSTRAINT fk_invoice_stay FOREIGN KEY (stay_id) REFERENCES stay (id)`
- `CONSTRAINT ck_invoice_values CHECK (subtotal >= 0 AND tax_amount >= 0 AND discount_amount >= 0 AND total_amount >= 0)`

**Índices:**

- `ix_invoice_customer (customer_id)`

## Tabla `partial_payment`

**Descripción:** Registra abonos o pagos parciales sobre reservas o facturas.

| Campo                   | Tipo de dato      | Obligatorio | Llave | Referencia               | Valor por defecto     | Descripción                                   |
| ----------------------- | ----------------- | ----------: | ----- | ------------------------ | --------------------- | ---------------------------------------------- |
| `id`                  | `UUID`          |         Sí | PK    | -                        | `gen_random_uuid()` | Identificador único del registro.             |
| `room_reservation_id` | `UUID`          |          No | FK    | `room_reservation(id)` | -                     | Registro relacionado de room_reservation.      |
| `invoice_id`          | `UUID`          |          No | FK    | `invoice(id)`          | -                     | Registro relacionado de invoice.               |
| `payment_method_id`   | `UUID`          |         Sí | FK    | `payment_method(id)`   | -                     | Registro relacionado de payment_method.        |
| `amount`              | `NUMERIC(12,2)` |         Sí | -     | -                        | -                     | Valor monetario.                               |
| `paid_at`             | `TIMESTAMP`     |         Sí | -     | -                        | `CURRENT_TIMESTAMP` | Fecha y hora del pago.                         |
| `payment_reference`   | `VARCHAR(120)`  |          No | -     | -                        | -                     | Referencia del pago.                           |
| `created_by`          | `UUID`          |          No | -     | -                        | -                     | Usuario que creó el registro.                 |
| `created_at`          | `TIMESTAMP`     |         Sí | -     | -                        | `CURRENT_TIMESTAMP` | Fecha y hora de creación.                     |
| `updated_by`          | `UUID`          |          No | -     | -                        | -                     | Usuario que actualizó el registro.            |
| `updated_at`          | `TIMESTAMP`     |          No | -     | -                        | -                     | Fecha y hora de actualización.                |
| `deleted_by`          | `UUID`          |          No | -     | -                        | -                     | Usuario que eliminó lógicamente el registro. |
| `deleted_at`          | `TIMESTAMP`     |          No | -     | -                        | -                     | Fecha y hora de eliminación lógica.          |
| `status`              | `VARCHAR(30)`   |         Sí | -     | -                        | `'ACTIVE'`          | Estado lógico del registro.                   |

**Restricciones:**

- `CONSTRAINT fk_partial_payment_reservation FOREIGN KEY (room_reservation_id) REFERENCES room_reservation (id)`
- `CONSTRAINT fk_partial_payment_invoice FOREIGN KEY (invoice_id) REFERENCES invoice (id)`
- `CONSTRAINT fk_partial_payment_method FOREIGN KEY (payment_method_id) REFERENCES payment_method (id)`
- `CONSTRAINT ck_partial_payment_amount CHECK (amount > 0)`
- `CONSTRAINT ck_partial_payment_source CHECK (room_reservation_id IS NOT NULL OR invoice_id IS NOT NULL)`

**Índices:**

- `ix_partial_payment_reservation (room_reservation_id)`
- `ix_partial_payment_invoice (invoice_id)`
- `ix_partial_payment_method (payment_method_id)`

## Tabla `invoice_detail`

**Descripción:** Registra líneas de detalle de una factura.

| Campo            | Tipo de dato      | Obligatorio | Llave | Referencia      | Valor por defecto     | Descripción                                   |
| ---------------- | ----------------- | ----------: | ----- | --------------- | --------------------- | ---------------------------------------------- |
| `id`           | `UUID`          |         Sí | PK    | -               | `gen_random_uuid()` | Identificador único del registro.             |
| `invoice_id`   | `UUID`          |         Sí | FK    | `invoice(id)` | -                     | Registro relacionado de invoice.               |
| `product_id`   | `UUID`          |          No | FK    | `product(id)` | -                     | Registro relacionado de product.               |
| `service_id`   | `UUID`          |          No | FK    | `service(id)` | -                     | Registro relacionado de service.               |
| `description`  | `VARCHAR(255)`  |         Sí | -     | -               | -                     | Descripción.                                  |
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

- `CONSTRAINT fk_invoice_detail_invoice FOREIGN KEY (invoice_id) REFERENCES invoice (id)`
- `CONSTRAINT fk_invoice_detail_product FOREIGN KEY (product_id) REFERENCES product (id)`
- `CONSTRAINT fk_invoice_detail_service FOREIGN KEY (service_id) REFERENCES service (id)`
- `CONSTRAINT ck_invoice_detail_values CHECK (quantity > 0 AND unit_price >= 0 AND total_amount >= 0)`
- `CONSTRAINT ck_invoice_detail_item CHECK (product_id IS NOT NULL OR service_id IS NOT NULL)`

**Índices:**

- `ix_invoice_detail_invoice (invoice_id)`
- `ix_invoice_detail_product (product_id)`
- `ix_invoice_detail_service (service_id)`
