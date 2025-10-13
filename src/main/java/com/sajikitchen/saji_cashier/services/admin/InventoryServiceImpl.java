package com.sajikitchen.saji_cashier.services.admin;

import com.sajikitchen.saji_cashier.dto.admin.InventoryResponeDto;
import com.sajikitchen.saji_cashier.models.InventoryItem;
import com.sajikitchen.saji_cashier.repositories.InventoryItemRepository;
import com.sajikitchen.saji_cashier.services.email.EmailService;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class InventoryServiceImpl implements InventoryService {

    private static final Logger log = LoggerFactory.getLogger(InventoryServiceImpl.class);
    private final InventoryItemRepository inventoryItemRepository;
    private final EmailService emailService; // Asumsi EmailService sudah di-inject

    @Override
    public void decreaseStock(UUID itemId, int amountToDecrease) {
        InventoryItem item = inventoryItemRepository.findById(itemId)
                .orElseThrow(() -> new EntityNotFoundException("Inventory item not found: " + itemId));

        if (item.getQuantity() < amountToDecrease) {
            log.warn("Stok tidak mencukupi untuk item: {}. Stok saat ini: {}, Kebutuhan: {}", item.getName(), item.getQuantity(), amountToDecrease);
            // Di aplikasi production, Anda mungkin ingin melempar exception khusus
            // Untuk saat ini, kita tetap kurangi agar tidak memblokir penjualan
        }

        int newQuantity = item.getQuantity() - amountToDecrease;
        item.setQuantity(newQuantity);
        inventoryItemRepository.save(item);

        // Cek ambang batas
        if (newQuantity <= item.getThreshold()) {
            log.info("Stok untuk item {} telah mencapai ambang batas. Mengirim notifikasi...", item.getName());
            emailService.sendLowStockNotification(item);
        }
    }

    @Override
    public List<InventoryResponeDto> getAllInventoryItems() {
        return inventoryItemRepository.findAllByOrderByIsActiveDescNameAsc().stream() // <-- GANTI DI SINI
                .map(this::mapToInventoryResponeDto)
                .collect(Collectors.toList());
    }

    private InventoryResponeDto mapToInventoryResponeDto(InventoryItem item) {
        return InventoryResponeDto.builder()
                .itemId(item.getItemId())
                .name(item.getName())
                .quantity(item.getQuantity())
                .threshold(item.getThreshold())
                .isActive(item.isActive())
                .build();
    }
}
