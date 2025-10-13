package com.sajikitchen.saji_cashier.dto.admin;

import lombok.Data;

import java.util.UUID;

@Data
public class InventoryUsageDto {
    private UUID itemId;
    private int amount;
}
