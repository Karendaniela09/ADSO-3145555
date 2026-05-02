# ADR-001: Ampliar nuevo dominio funcional - NOTIFICATIONS

**Título:** Introducir dominio de Notificaciones (Notifications)

**Contexto**  
El modelo de datos entregado (`modelo_postgresql.sql`) está organizado en 12 dominios funcionales bien definidos y maduros. Sin embargo, no existe ninguna tabla, entidad ni estructura relacionada con el envío, registro o gestión de notificaciones hacia los pasajeros, clientes o personal operativo. El sistema actual solo cuenta con tablas operativas (reservas, vuelos, pagos, abordaje, fidelización), pero carece de un mecanismo formal para comunicar eventos importantes al usuario final.

**Problema**  
En un sistema de aerolínea es fundamental notificar en tiempo real eventos críticos tales como:
- Confirmación o modificación de reserva
- Retrasos o cancelaciones de vuelo (`flight_delay`)
- Boarding pass listo o cambio de gate
- Crédito o redención de millas (`miles_transaction`)
- Confirmación de pago o reembolso (`payment`, `refund`)
- Actualización de estado de check-in o boarding

La ausencia de este dominio impide ofrecer una buena experiencia al pasajero y dificulta el seguimiento interno de las comunicaciones enviadas.

**Decisión**  
Crear un nuevo dominio funcional llamado **Notifications** con las siguientes tablas principales:

- `notification_type` (catálogo de tipos: CONFIRMATION, DELAY, BOARDING, PAYMENT, MILES, etc.)
- `notification` (mensaje principal, canal de envío, estado)
- `notification_recipient` (relaciona la notificación con `person_id` o `customer_id`)
- `notification_log` (histórico de envíos reales: fecha, canal, resultado, error)

Todas las tablas seguirán el estándar del modelo: clave primaria UUID, campos `created_at` / `updated_at`, y relaciones referenciales consistentes.

**Justificación técnica**  
- Es un dominio **transversal** que se integra naturalmente con los dominios existentes: Flight Operations, Sales & Reservation, Boarding, Payment, Loyalty y Customer.  
- Mantiene la filosofía de separación por dominios que ya tiene el modelo original.  
- Prepara el sistema para integración futura con servicios externos (SendGrid, Firebase Cloud Messaging, AWS SNS, WhatsApp Business API).  
- Facilita la trazabilidad y auditoría de las comunicaciones enviadas al pasajero.  
- Cumple con requisitos reales de experiencia de usuario y cumplimiento normativo en la industria aérea.

**Consecuencias / Impacto esperado**  
- **Positivas:**  
  - +1 dominio funcional (total 13 dominios).  
  - Gran mejora en la experiencia del pasajero y en la operación interna.  
  - Base sólida para futuras funcionalidades (push notifications, recordatorios automáticos, etc.).  
  - Fácil de implementar con Liquibase (un changelog propio).  

- **Negativas / Consideraciones:**  
  - Añade 4 tablas nuevas (impacto mínimo en tamaño del esquema).  
  - Requiere definir lógica de envío en la capa de aplicación (no se resuelve solo en BD).

**Estado:** Aprobado para implementación en la fase desescolarizada.