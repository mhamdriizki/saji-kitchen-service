package com.sajikitchen.saji_cashier.dto.cashier;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class ExpenseRequest {
    private BigDecimal amount;
    private String description;
}
