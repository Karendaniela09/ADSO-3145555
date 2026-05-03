-- changeset daniela:3
CREATE TABLE cita (
    id SERIAL PRIMARY KEY,
    fecha DATE,
    motivo VARCHAR(255),
    id_mascota INT,
    id_veterinario INT,
    CONSTRAINT fk_mascota FOREIGN KEY (id_mascota) REFERENCES mascota(id),
    CONSTRAINT fk_veterinario FOREIGN KEY (id_veterinario) REFERENCES veterinario(id)
); 