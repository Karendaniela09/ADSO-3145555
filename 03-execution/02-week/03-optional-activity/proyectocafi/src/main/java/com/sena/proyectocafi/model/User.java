package com.sena.proyectocafi.model;

import jakarta.persistence.*;
import lombok.*;

public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

};


