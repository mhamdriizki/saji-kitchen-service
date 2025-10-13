package com.sajikitchen.saji_cashier.services.admin;

import com.sajikitchen.saji_cashier.dto.admin.InventoryResponeDto;

import java.util.List;
import java.util.UUID;

public interface InventoryService {
    void decreaseStock(UUID itemId, int amountToDecrease);
    List<InventoryResponeDto> getAllInventoryItems();
}
