# Análisis de dominios del modelo

A partir del análisis del archivo modelo_postgresql.sql, se identifican los siguientes dominios funcionales:

## 1. Geografía y datos de referencia
Incluye tablas como: time_zone, continent, country, state_province, city, district, address, currency.

Este dominio permite gestionar la ubicación geográfica y datos base necesarios para el sistema.

## 2. Aerolínea
Incluye la tabla: airline.

Permite gestionar la información de las aerolíneas.

## 3. Identidad
Incluye tablas como: person_type, document_type, contact_type, person, person_document, person_contact.

Este dominio gestiona la información personal de los usuarios.

## 4. Seguridad
Incluye tablas como: user_status, security_role, security_permission, user_account, user_role, role_permission.

Permite gestionar usuarios, roles y permisos dentro del sistema.

## 5. Clientes y fidelización
Incluye tablas como: customer_category, benefit_type, loyalty_program, loyalty_tier, customer, loyalty_account, loyalty_account_tier, miles_transaction, customer_benefit.

Gestiona clientes y programas de fidelización.

## 6. Aeropuerto
Incluye tablas como: airport, terminal, boarding_gate, runway, airport_regulation.

Gestiona la infraestructura aeroportuaria.

## 7. Aeronaves
Incluye tablas como: aircraft_manufacturer, aircraft_model, cabin_class, aircraft, aircraft_cabin, aircraft_seat, maintenance_provider, maintenance_type, maintenance_event.

Gestiona la información de aeronaves y mantenimiento.

## 8. Operaciones de vuelo
Incluye tablas como: flight_status, delay_reason_type, flight, flight_segment, flight_delay.

Gestiona los vuelos y sus operaciones.

## 9. Ventas y reservas
Incluye tablas como: reservation_status, sale_channel, fare_class, fare, ticket_status, reservation, reservation_passenger, sale, ticket, ticket_segment, seat_assignment, baggage.

Gestiona el proceso de venta, reservas y tiquetes.

## 10. Abordaje
Incluye tablas como: boarding_group, check_in_status, check_in, boarding_pass, boarding_validation.

Gestiona el proceso de abordaje de pasajeros.

## 11. Pagos y facturación
Incluye tablas como: payment_status, payment_method, payment, payment_transaction, refund, tax, exchange_rate, invoice_status, invoice, invoice_line.

Gestiona pagos, transacciones y facturación del sistema.