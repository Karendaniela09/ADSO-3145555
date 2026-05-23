# Sistema Hotelero

## Enlace backlog: https://trello.com/c/hhFy2mGA/40-hu-11-cargar-datos-semilla-operativos
## Reposiorio db - Sistema Hotelero: https://github.com/JohanAceroSalazar/Sistema-Hotelero.git


Este proyecto consiste en el desarrollo de una solución integral para la gestión de servicios hoteleros, permitiendo la administración eficiente de reservaciones, huéspedes y disponibilidad de habitaciones.

 Equipo de Desarrollo y Responsabilidades
A continuación se detalla la contribución y las tareas específicas que cada integrante ha realizado hasta el momento:

👥 Trabajo Grupal — Equipo Completo
HU-01. Estructura de carpetas de la base de datos
Descripción:

Como equipo, se organizó la estructura de carpetas de la base de datos con el objetivo de separar migraciones, semillas, consultas de prueba y documentación técnica, permitiendo que cualquier integrante pudiera ubicar y ejecutar los archivos SQL sin confusiones.

Actividades realizadas
Creación de las carpetas:
01_ddl/
02_dml/
05_rollbacks/
Organización de subcarpetas internas para migraciones y documentación.
Configuración de archivos 0000changelog.yaml en cada dominio.
Definición de convenciones de nombres para:
Migraciones SQL.
Rollbacks SQL.
Configuración de changelog-master.yaml.
Actualización del README.md con instrucciones de ejecución.
Configuración de docker-compose.yml y .env.example.
Validación grupal del levantamiento de la base de datos usando Docker Compose.

👩‍💻 José Amaya
HU-02. Subir dominio de seguridad
Descripción

Se encargó de subir y estructurar el script DDL correspondiente al dominio de seguridad del sistema, permitiendo versionar y ejecutar correctamente las tablas relacionadas con usuarios, roles, permisos y módulos mediante Liquibase en el ambiente compartido.

Actividades realizadas
Creación del archivo:
01_ddl/03_tables/001-create-domain-security.sql
Desarrollo de las tablas:
persona
rol_aplicacion
permiso
modulo
vista_aplicacion
usuario_aplicacion
usuario_rol
rol_permiso
modulo_vista
Configuración de identificadores UUID usando:
DEFAULT gen_random_uuid()
Implementación de campos de auditoría en cada tabla:
created_by
created_at
updated_by
updated_at
deleted_by
deleted_at
status
Registro de la migración en:
01_ddl/03_tables/0000changelog.yaml
Validación de ejecución correcta de la migración desde cero usando Liquibase.
Revisión y preparación del Pull Request para aprobación antes del merge.

👨‍💻 Johan Acero
HU-03. Subir dominio de parametrización
Descripción

Se encargó de desarrollar y subir el script DDL correspondiente al dominio de parametrización del sistema, permitiendo versionar y ejecutar las tablas relacionadas con clientes, empresas, empleados, métodos de pago y configuraciones generales dentro del ambiente compartido.

Actividades realizadas
Creación del archivo:
01_ddl/03_tables/002-create-domain-parameterization.sql
Desarrollo de las tablas:
cliente
empresa
tipo_dia
metodo_pago
informacion_legal
empleado
Configuración de relaciones entre tablas mediante claves foráneas (FK).
Implementación de relación entre:
empleado → persona
usando FK y restricción:
UNIQUE (person_id)
Configuración de restricciones únicas:
cliente
UNIQUE (document_type, document_number)
UNIQUE (email)
empresa
UNIQUE (tax_id)
Implementación de tipos de datos monetarios usando:
NUMERIC(12,2)
Registro de la migración en:
01_ddl/03_tables/0000changelog.yaml
Validación de ejecución correcta después del dominio de seguridad.
Preparación y revisión del Pull Request antes del merge a la rama principal.

👨‍💻 Johan Acero
HU-04. Subir dominio de distribución
Descripción

Se encargó de desarrollar y subir el script DDL correspondiente al dominio de distribución del sistema, permitiendo versionar y ejecutar las tablas relacionadas con sedes, habitaciones, estados y tarifas dentro del ambiente compartido.

Actividades realizadas
Creación del archivo:
01_ddl/03_tables/003-create-domain-distribution.sql
Desarrollo de las tablas:
sede
tipo_habitacion
estado_habitacion
habitacion
tarifa
Configuración de relaciones mediante claves foráneas (FK).
Implementación de relación:
sede → empresa
Configuración de restricciones:
UNIQUE (company_id, name) en sede
UNIQUE (branch_id, room_number) en habitacion
Implementación de validaciones:
CHECK (capacity > 0) en habitacion
CHECK (amount > 0) en tarifa
Configuración de referencias en:
tarifa → tipo_habitacion
tarifa → tipo_dia
Registro de la migración en:
01_ddl/03_tables/0000changelog.yaml
Validación de ejecución correcta después del dominio de parametrización.
Preparación y revisión del Pull Request antes del merge a la rama principal.

👨‍💻 Karen Holguín
HU-05. Subir dominio de inventario
Descripción

Se encargó de desarrollar y subir el script DDL correspondiente al dominio de inventario del sistema, permitiendo versionar y ejecutar las tablas relacionadas con proveedores, productos, servicios y movimientos de inventario dentro del ambiente compartido.

Actividades realizadas
Creación del archivo:
01_ddl/03_tables/004-create-domain-inventory.sql
Desarrollo de las tablas:
proveedor
producto
servicio
movimiento_producto
disponibilidad_inventario
Configuración de relaciones mediante claves foráneas (FK) hacia dominios anteriores:
Parametrización
Distribución
Implementación de campos de auditoría en todas las tablas:
created_by
created_at
updated_by
updated_at
deleted_by
deleted_at
status
Validación de integridad y relaciones del modelo de inventario.
Registro de la migración en:
01_ddl/03_tables/0000changelog.yaml
Validación de ejecución correcta después del dominio de distribución.
Preparación y revisión del Pull Request antes del merge a la rama principal.

👨‍💻 Valery Sinaí
HU-06. Subir dominio de prestación de servicio
Descripción

Se encargó de desarrollar y subir el script DDL correspondiente al dominio de prestación de servicio del sistema, permitiendo versionar y ejecutar las tablas relacionadas con reservas, estadías, check-in/check-out y consumos dentro del ambiente compartido.

Actividades realizadas
Creación del archivo:
01_ddl/03_tables/005-create-domain-service.sql
Desarrollo de las tablas:
reserva_habitacion
cancelacion_habitacion
disponibilidad_habitacion
catalogo_habitacion
estadia
check_in
check_out
venta_producto
venta_servicio
Configuración de relaciones mediante claves foráneas (FK) hacia los dominios:
Distribución
Parametrización
Inventario
Implementación de campos de auditoría en todas las tablas:
created_by
created_at
updated_by
updated_at
deleted_by
deleted_at
status
Validación de integridad y relaciones del dominio de prestación de servicio.
Registro de la migración en:
01_ddl/03_tables/0000changelog.yaml
Validación de ejecución correcta después del dominio de inventario.
Preparación y revisión del Pull Request antes del merge a la rama principal.

👨‍💻 Karen Holguín
HU-07. Subir dominio de facturación
Descripción

Se encargó de desarrollar y subir el script DDL correspondiente al dominio de facturación del sistema, permitiendo versionar y ejecutar las tablas relacionadas con prefacturas, facturas, detalles de facturación y pagos parciales dentro del ambiente compartido.

Actividades realizadas
Creación del archivo:
01_ddl/03_tables/006-create-domain-billing.sql
Desarrollo de las tablas:
prefactura
factura
detalle_factura
pago_parcial
Configuración de relaciones mediante claves foráneas (FK) hacia los dominios:
Prestación de servicio
Parametrización
Implementación de referencias en:
pago_parcial: reserva_habitacion
pago_parcial: factura
pago_parcial:  metodo_pago
Configuración de validación:
CHECK (amount > 0) en pago_parcial
Validación de integridad y relaciones del dominio de facturación.
Registro de la migración en:
01_ddl/03_tables/0000changelog.yaml
Validación de ejecución correcta después del dominio de prestación de servicio.
Preparación y revisión del Pull Request antes del merge a la rama principal.

👨‍💻 Valery Sinaí
HU-08. Subir dominio de notificación
Descripción

Se encargó de desarrollar y subir el script DDL correspondiente al dominio de notificación del sistema, permitiendo versionar y ejecutar las tablas relacionadas con promociones, alertas, términos y fidelización de clientes dentro del ambiente compartido.

Actividades realizadas
Creación del archivo:
01_ddl/03_tables/007-create-domain-notification.sql
Desarrollo de las tablas:
promocion
alerta
termino_condicion
fidelizacion_cliente
Configuración de restricciones:
UNIQUE (version) en termino_condicion
UNIQUE (customer_id) en fidelizacion_cliente
Implementación de validación:
CHECK (points >= 0) en fidelizacion_cliente
Configuración de relaciones mediante claves foráneas (FK) hacia dominios anteriores.
Definición de canales de notificación:
EMAIL
SMS
PUSH
Implementación de campos de auditoría y control de estado en las tablas.
Registro de la migración en:
01_ddl/03_tables/0000changelog.yaml
Validación de ejecución correcta después del dominio de prestación de servicio.
Preparación y revisión del Pull Request antes del merge a la rama principal.

👨‍💻 José Amaya
HU-09. Subir dominio de mantenimiento
Descripción

Se encargó de desarrollar y subir el script DDL correspondiente al dominio de mantenimiento del sistema, permitiendo versionar y ejecutar las tablas relacionadas con mantenimiento de habitaciones, remodelaciones y control operativo dentro del ambiente compartido.

Actividades realizadas
Creación del archivo:
01_ddl/03_tables/008-create-domain-maintenance.sql
Desarrollo de las tablas:
mantenimiento_habitacion
mantenimiento_uso
mantenimiento_remodelacion
dashboard_mantenimiento
Configuración de relaciones mediante claves foráneas (FK) hacia los dominios:
Distribución
Parametrización
Implementación de restricción:
UNIQUE (room_maintenance_id) en mantenimiento_uso
Implementación de validación:
CHECK (estimated_budget IS NULL OR estimated_budget >= 0) en mantenimiento_remodelacion
Definición de tipos de mantenimiento:
USO
REMODELACION
PREVENTIVO
Implementación de campos de auditoría y control de estado en las tablas.
Registro de la migración en:
01_ddl/03_tables/0000changelog.yaml
Validación de ejecución correcta después de los dominios de distribución y parametrización.
Preparación y revisión del Pull Request antes del merge a la rama principal

👨‍💻 Johan Acero
HU-10. Crear rol de instructor
Descripción

Se encargó de crear y configurar el rol de instructor dentro de la base de datos del sistema, permitiendo que el docente tuviera acceso de solo lectura al ambiente de revisión sin posibilidad de modificar la información almacenada.

Actividades realizadas
Creación del rol:
INSTRUCTOR
Configuración de permisos de:
SELECT sobre todas las tablas de los 8 dominios del sistema.
Restricción de permisos para evitar:
INSERT
UPDATE
DELETE
Creación y configuración de un usuario en:
usuario_aplicacion
Asociación del usuario con el rol de instructor mediante:
usuario_rol
Creación del script de inserción en:
02_dml/00_inserts/
Documentación de credenciales del instructor en:
README.md
Validación del acceso mediante pruebas de consultas SQL sin errores de permisos.
Verificación de seguridad y acceso controlado para el ambiente de revisión

👨‍💻 Johan Acero
HU-11. Cargar datos semilla operativos
Descripción

Se encargó de crear y cargar los datos semilla operativos del sistema, permitiendo que el ambiente de revisión contara con información representativa para ejecutar pruebas funcionales y validar correctamente las relaciones entre dominios.

Actividades realizadas
Creación de archivos seed para los dominios:
Seguridad
Parametrización
Distribución
Inventario
Prestación de servicio
Facturación
Notificación
Mantenimiento
Organización de seeds respetando el orden de dependencias y claves foráneas (FK).
Creación de archivos:
001 a 008 en:
02_dml/00_inserts/
Registro de entradas en:
02_dml/00_inserts/0000changelog.yaml
Carga de datos mínimos operativos incluyendo:
1 empresa
2 sedes
3 tipos de habitación
5 habitaciones
2 clientes
2 empleados
1 reserva
1 factura
Validación de integridad de datos entre dominios.
Verificación del levantamiento completo del ambiente mediante:
docker-compose up
Validación de ejecución de seeds sin errores de migración o FK.
Preparación y revisión del Pull Request antes del merge a la rama principal.

👥 Trabajo Grupal — Equipo Completo
HU-12. Crear vistas, funciones, procedimientos, triggers e índices de prueba por dominio
Descripción: 

Como equipo, se desarrollaron objetos avanzados de base de datos para cada dominio del sistema, permitiendo implementar lógica de negocio reutilizable, automatización de procesos y optimización del acceso a la información mediante vistas, funciones, procedimientos almacenados, triggers e índices.

Actividades realizadas
Creación de al menos una vista por dominio para consolidar información de múltiples tablas.
Desarrollo de funciones reutilizables para cálculos y consultas de negocio.
Implementación de procedimientos almacenados para operaciones transaccionales completas.
Creación de triggers para automatizar procesos ante eventos:
INSERT
UPDATE
DELETE
Implementación de índices sobre:
Claves foráneas (FK)
Columnas de búsqueda frecuente
Campos de filtrado
Validación de funcionamiento correcto utilizando los datos semilla cargados previamente.
Documentación de cada objeto SQL mediante comentarios explicativos sobre su propósito de negocio.
Organización y subida de scripts en:
01_ddl/
o carpetas equivalentes del proyecto.
Registro de entradas en los archivos changelog correspondientes.
Validación grupal de ejecución sin errores en el ambiente completo.
Objetos desarrollados por dominio
Vistas SQL
Funciones SQL
Procedimientos almacenados
Triggers
Índices

👥 Trabajo Grupal — Equipo Completo
HU-13 Validar llaves y checks
Descripción:

Como equipo, se realizaron pruebas de validación sobre las restricciones de integridad de la base de datos con el objetivo de garantizar el correcto funcionamiento de las llaves foráneas, restricciones UNIQUE y validaciones CHECK antes de la revisión final del proyecto.

Actividades realizadas
Creación de scripts de validación de integridad para los diferentes dominios del sistema.
Ejecución de pruebas para validar:
Llaves foráneas (FK)
Restricciones UNIQUE
Restricciones CHECK
Validación de errores esperados al intentar:
Insertar registros sin relaciones válidas.
Duplicar registros en tablas puente.
Insertar valores inválidos en campos numéricos.
Verificación de restricciones:
amount > 0
capacity > 0
points >= 0
Confirmación de que el motor de base de datos genera errores correctamente ante violaciones de integridad.
Registro y documentación de resultados:
PASS para errores esperados correctamente detectados.
Revisión de índices de soporte para llaves foráneas en tablas con alto volumen estimado.
Organización de scripts de validación en:
02_dml/
docs/
Actualización de documentación en:
README.md
o archivos dedicados de validación.
Validación grupal del correcto funcionamiento de restricciones e integridad referencial.

👥 Trabajo Grupal — Equipo Completo
HU-14 Definir scripts de rollback
Descripción:

Como equipo, se desarrollaron y validaron los scripts de rollback para los dominios DDL del sistema con el objetivo de permitir la reversión segura y ordenada de las migraciones en caso de fallos o inconsistencias durante el despliegue.

Actividades realizadas
Creación de scripts de rollback para los 8 dominios DDL del sistema.
Organización de scripts en:
05_rollbacks/01_ddl/03_tables/
Desarrollo de scripts:
001 a 008 de rollback.
Implementación de sentencias:
DROP TABLE IF EXISTS
Configuración del orden inverso de eliminación de tablas respetando:
Llaves foráneas (FK)
Dependencias entre dominios
Registro de los rollbacks en:
0000changelog.yaml
Validación de ejecución correcta de al menos un rollback completo.
Verificación de eliminación segura de tablas sin errores.
Pruebas de re-ejecución de migraciones después del rollback para confirmar estabilidad del ambiente.
Revisión grupal de integridad y consistencia de los scripts de reversión.

👥 Trabajo Grupal — Equipo Completo
HU-15 Actualizar diccionario de datos
Descripción:

Como equipo, se actualizó el diccionario de datos del proyecto con el objetivo de documentar completamente el modelo final implementado en la base de datos, incluyendo tablas, columnas, tipos de datos, restricciones y relaciones correspondientes a los 8 dominios del sistema hotelero.

Actividades realizadas
Documentación completa de las tablas pertenecientes a los 8 dominios del sistema.
Registro detallado de información por cada tabla:
Nombre de columnas
Tipo de dato
Nulabilidad
Valores por defecto
Llaves primarias (PK)
Llaves foráneas (FK)
Restricciones UNIQUE
Restricciones CHECK
Descripción funcional de negocio
Documentación de relaciones entre tablas incluyendo:
Dependencias
Cardinalidades
Referencias entre dominios
Validación de consistencia entre:
Modelo implementado
Scripts DDL
Diccionario de datos
Verificación de inexistencia de:
Tablas faltantes
Columnas fantasma
Relaciones inconsistentes
Organización del documento en:
docs/diccionario-de-datos.md
o formato .pdf
Revisión grupal de estructura, claridad y consistencia técnica de la documentación.
Validación final del diccionario contra la base de datos real del proyecto.


👥 Trabajo Grupal — Equipo Completo
HU-16 Preparar ejecución con Liquibase
Descripción:

Como equipo, se preparó y validó la configuración de Liquibase con el objetivo de automatizar y organizar correctamente el pipeline de migraciones de la base de datos sobre el ambiente compartido, evitando configuraciones manuales y garantizando estabilidad en las ejecuciones.

Actividades realizadas
Configuración y actualización del archivo:
changelog-master.yaml
Organización de changelogs de dominio en el orden correcto de ejecución.
Validación de ejecución de migraciones mediante:
liquibase update
Pruebas de ejecución desde una base de datos vacía para garantizar funcionamiento completo del pipeline.
Verificación y corrección de:
Conflictos de checksum
Dependencias entre changelogs
Parametrización de variables de conexión utilizando:
.env
.env.example
Eliminación de credenciales en texto plano para mejorar la seguridad del proyecto.
Configuración de ejecución de Liquibase mediante:
Docker
Variables de entorno
Documentación de comandos de ejecución y configuración en:
README.md
Validación grupal de ejecución correcta en los ambientes de desarrollo.


👥 Trabajo Grupal — Equipo Completo
HU-17 Ejecutar revisión final de base de datos
Descripción:

Como equipo, se realizó una revisión final integral de la base de datos con el objetivo de validar que todos los dominios, migraciones, datos semilla, configuraciones de Liquibase, scripts de rollback y consultas de prueba funcionaran correctamente antes de la entrega oficial al instructor.

Actividades realizadas
Ejecución completa del pipeline de Liquibase sobre una base de datos limpia.
Validación del orden correcto de ejecución de los 8 dominios DDL.
Verificación de carga correcta de:
Datos semilla
Relaciones entre dominios
Restricciones y validaciones
Ejecución de consultas de prueba por cada dominio para validar:
Integridad de datos
Relaciones FK
Resultados esperados
Validación del acceso mediante el:
Rol de instructor
Confirmación de permisos de solo lectura para el instructor.
Revisión y validación del:
Diccionario de datos
Modelo real implementado
Ejecución y prueba de scripts de rollback.
Verificación de re-ejecución de migraciones después de rollback.
Actualización del:
README.md
Documentación del flujo completo de ejecución:
Setup
Migraciones
Seeds
Pruebas
Rollbacks
Validación del pipeline por al menos dos integrantes en ambientes distintos.
Registro de checklist o acta final de revisión en:
docs/
Revisión final de Pull Requests y resolución de conflictos antes del merge en main.




# Estado Actual del Proyecto
Actualmente, el equipo ha completado las siguientes fases:

Definición de Requerimientos: Documentación de todas las necesidades del hotel.

Arquitectura de Datos: Base de datos estructurada y funcional.

Módulos Base: Registro de usuarios y gestión de inventario de habitaciones terminados. 
