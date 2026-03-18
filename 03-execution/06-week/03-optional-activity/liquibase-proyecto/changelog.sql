--liquibase formatted sql

CREATE TABLE usuarios (
    id BIGINT PRIMARY KEY,
    nombre VARCHAR(255),
    email VARCHAR(255),
    contrasena_hash VARCHAR(255),
    activo BOOLEAN,
    fecha_creacion TIMESTAMP
);

CREATE TABLE roles (
    id BIGINT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE usuario_rol (
    id BIGINT PRIMARY KEY,
    usuario_id BIGINT,
    rol_id BIGINT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (rol_id) REFERENCES roles(id)
);