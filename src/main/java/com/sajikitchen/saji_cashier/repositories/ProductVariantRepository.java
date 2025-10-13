package com.sajikitchen.saji_cashier.repositories;

import com.sajikitchen.saji_cashier.models.ProductVariant;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface ProductVariantRepository extends JpaRepository<ProductVariant, UUID> {
    @Query("SELECT pv FROM ProductVariant pv LEFT JOIN FETCH pv.inventoryMappings WHERE pv.variantId = :variantId")
    Optional<ProductVariant> findByIdWithMappings(UUID variantId);
}
