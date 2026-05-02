# ADR-002: Diseñar manejo de roles con permisos diferenciados

**Título:** Implementar modelo RBAC (Role-Based Access Control) completo y granular

**Contexto**  
El modelo actual ya contiene las tablas `security_role`, `security_permission`, `user_role` y `role_permission`. Sin embargo, solo existen las estructuras básicas sin roles concretos definidos ni permisos específicos por dominio funcional.

**Problema**  
No hay una estrategia clara de autorización que permita diferenciar accesos según el perfil del usuario (ej: agente de ventas, personal de check-in, operador de vuelos, administrador de mantenimiento, pasajero, etc.). Esto genera riesgo de seguridad y falta de trazabilidad en las acciones críticas.

**Decisión**  
- Definir 6 roles iniciales: `ADMIN`, `OPERATIONS`, `SALES_AGENT`, `CHECKIN_STAFF`, `MAINTENANCE`, `CUSTOMER`.  
- Crear permisos granulares por dominio (ej: `flight:read`, `reservation:write`, `payment:refund`, `seat:assign`).  
- Utilizar el campo `assigned_by_user_id` ya existente para registrar quién asignó cada rol.  
- Integrar con el dominio Audit Log (futuro) para auditar cambios de roles.

**Justificación técnica**  
- Cumple con el principio de menor privilegio y con los requisitos de seguridad del proyecto.  
- Facilita la implementación de autorización en backend y frontend.  
- Se integra perfectamente con el nuevo dominio Notifications y con Audit Log.  
- Es un estándar ampliamente utilizado en sistemas empresariales y de aviación.

**Consecuencias / Impacto esperado**  
- **Positivas:** Mayor control de acceso, trazabilidad total y preparación para la interfaz de usuario.  
- **Negativas:** Requiere carga inicial de datos de roles y permisos (se incluirá en el plan de datos de prueba).  
- **Estado:** Aprobado para implementación en la HU-006. 