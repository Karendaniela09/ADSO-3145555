# Análisis de Dominios Funcionales del Modelo

## Dominios identificados (12 dominios funcionales)

| # | Dominio | Tablas principales | Relación clave con otros dominios |
|---|---------|--------------------|-----------------------------------|
| 1 | **Geography & Reference** | `time_zone`, `continent`, `country`, `state_province`, `city`, `district`, `address`, `currency` | Base para Airport, Person, Airline |
| 2 | **Airline** | `airline` | Relacionado con Customer, Aircraft, Fare |
| 3 | **Identity** | `person_type`, `document_type`, `contact_type`, `person`, `person_document`, `person_contact` | Usado por User, Customer, Passenger |
| 4 | **Security** | `user_status`, `security_role`, `security_permission`, `user_account`, `user_role`, `role_permission` | Seguridad transversal |
| 5 | **Customer & Loyalty** | `customer_category`, `benefit_type`, `loyalty_program`, `loyalty_tier`, `customer`, `loyalty_account`, `miles_transaction`, `customer_benefit` | Fidelización de clientes |
| 6 | **Airport** | `airport`, `terminal`, `boarding_gate`, `runway`, `airport_regulation` | Origen/Destino de vuelos |
| 7 | **Aircraft** | `aircraft_manufacturer`, `aircraft_model`, `cabin_class`, `aircraft`, `aircraft_cabin`, `aircraft_seat`, `maintenance_event` | Usado por Flight y Seat Assignment |
| 8 | **Flight Operations** | `flight_status`, `delay_reason_type`, `flight`, `flight_segment`, `flight_delay` | Operación real de vuelos |
| 9 | **Sales & Reservation** | `reservation_status`, `sale_channel`, `fare_class`, `fare`, `reservation`, `reservation_passenger`, `sale`, `ticket`, `ticket_segment`, `seat_assignment`, `baggage` | Flujo comercial principal |
| 10 | **Boarding** | `boarding_group`, `check_in_status`, `check_in`, `boarding_pass`, `boarding_validation` | Proceso de embarque |
| 11 | **Payment** | `payment_status`, `payment_method`, `payment`, `payment_transaction`, `refund` | Pagos y reembolsos |
| 12 | **Billing** | `tax`, `exchange_rate`, `invoice_status`, `invoice`, `invoice_line` | Facturación y impuestos |

**Observación:** El modelo ya está muy bien organizado por dominios (separación clara en el SQL original). Solo falta el versionamiento con Liquibase y un nuevo dominio de auditoría.

**Relaciones más críticas:**
- `address` → `airport` y `maintenance_provider`
- `person` → `customer`, `user_account`, `reservation_passenger`
- `fare` → `ticket_segment`
- `flight_segment` → `ticket_segment` y `seat_assignment`