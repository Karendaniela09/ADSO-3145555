-- changeset daniela:1
CREATE TABLE mascota (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    especie VARCHAR(50),
    edad INT
); 