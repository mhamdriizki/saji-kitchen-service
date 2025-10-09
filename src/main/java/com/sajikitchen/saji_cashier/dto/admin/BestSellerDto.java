package com.sajikitchen.saji_cashier.dto.admin;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class BestSellerDto {
    private String itemName;
    private Long totalQuantity;
}
