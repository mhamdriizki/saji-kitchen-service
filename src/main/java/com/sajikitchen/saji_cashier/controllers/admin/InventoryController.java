package com.sajikitchen.saji_cashier.controllers.admin;

import com.sajikitchen.saji_cashier.dto.admin.InventoryRequestDto;
import com.sajikitchen.saji_cashier.dto.admin.InventoryResponeDto;
import com.sajikitchen.saji_cashier.dto.admin.InventoryUsageDto;
import com.sajikitchen.saji_cashier.services.admin.InventoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/inventory")
@RequiredArgsConstructor
public class InventoryController {

    private final InventoryService inventoryService;

    @GetMapping
    public ResponseEntity<List<InventoryResponeDto>> getAllInventoryItems() {
        List<InventoryResponeDto> items = inventoryService.getAllInventoryItems(); // Buat method ini di service
        return ResponseEntity.ok(items);
    }

    // Endpoint ini akan digunakan oleh kasir untuk mengurangi stok manual (sumpit, plastik)
    @PutMapping("/usage")
    public ResponseEntity<Void> decreaseStockManually(@RequestBody InventoryUsageDto usageDTO) {
        inventoryService.decreaseStock(usageDTO.getItemId(), usageDTO.getAmount());
        return ResponseEntity.ok().build();
    }

    // Endpoint untuk GET, POST, DELETE akan ada di AdminController
}
