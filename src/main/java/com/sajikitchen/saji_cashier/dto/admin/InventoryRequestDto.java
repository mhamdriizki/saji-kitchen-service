package com.sajikitchen.saji_cashier.dto.admin;

import lombok.Data;

@Data
public class InventoryRequestDto {
    private String name;
    private Integer quantity;
    private Integer threshold;
    private Boolean isActive;
}