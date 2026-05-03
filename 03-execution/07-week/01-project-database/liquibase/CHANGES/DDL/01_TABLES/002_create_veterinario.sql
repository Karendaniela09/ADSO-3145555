-- changeset daniela:2
CREATE TABLE veterinario (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    especialidad VARCHAR(100)
); 