package com.sajikitchen.saji_cashier.dto.admin;

import lombok.Builder;
import lombok.Data;

import java.util.UUID;

@Data
@Builder
public class InventoryResponeDto {
    private UUID itemId;
    private String name;
    private int quantity;
    private int threshold;
    private boolean isActive;
}
