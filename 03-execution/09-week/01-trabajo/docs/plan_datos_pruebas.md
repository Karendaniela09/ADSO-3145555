# Plan de datos de prueba

## Orden de inserción

1. time_zone
2. continent
3. country
4. state_province
5. city
6. district
7. address
8. currency
9. airline
10. person_type
11. document_type
12. contact_type
13. person
14. person_document
15. person_contact
16. user_status
17. security_role
18. security_permission
19. user_account
20. user_role
21. role_permission

## Descripción

El orden de inserción se define según las dependencias entre tablas, iniciando por aquellas que no dependen de otras y continuando con las que requieren claves foráneas.

## Scripts de inserción

Se deben crear scripts de inserción organizados respetando el orden de dependencias para evitar errores de integridad referencial.

## Validaciones

Se deben realizar pruebas que verifiquen la correcta inserción de datos y el cumplimiento de las restricciones definidas en el modelo.

## Seguimiento

Se debe documentar el proceso de carga de datos y las validaciones realizadas.