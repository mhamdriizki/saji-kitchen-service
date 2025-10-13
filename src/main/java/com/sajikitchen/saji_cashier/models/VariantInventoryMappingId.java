package com.sajikitchen.saji_cashier.models;

import lombok.Data;

import java.io.Serializable;
import java.util.UUID;

@Data
public class VariantInventoryMappingId implements Serializable {
    private UUID variant;
    private UUID inventoryItem;
}
