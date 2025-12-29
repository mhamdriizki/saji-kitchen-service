package com.sajikitchen.saji_cashier.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Entity
@Table(name = "images")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Image {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "image_id")
    private UUID imageId;

    private String name;

    private String type; // misal: image/png, image/jpeg

    @Lob
    @Column(name = "data", nullable = false)
    private byte[] data; // Data gambar tersimpan di sini
}
