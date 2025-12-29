package com.sajikitchen.saji_cashier.services.admin;

import com.sajikitchen.saji_cashier.models.Image;
import com.sajikitchen.saji_cashier.repositories.ImageRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.io.IOException;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ImageService {

    private final ImageRepository imageRepository;

    public String uploadImage(MultipartFile file) throws IOException {
        Image image = Image.builder()
                .name(file.getOriginalFilename())
                .type(file.getContentType())
                .data(file.getBytes())
                .build();

        Image savedImage = imageRepository.save(image);

        return ServletUriComponentsBuilder.fromCurrentContextPath()
                .path("/api/v1/images/")
                .path(savedImage.getImageId().toString())
                .toUriString();
    }

    public Image getImage(UUID id) {
        return imageRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Image not found"));
    }
}
