package com.sajikitchen.saji_cashier.dto.cashier;

import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;
import java.util.UUID;

@Data
@Builder
public class ExpenseResponse {
    private UUID expenseId;
    private String username;
    private BigDecimal amount;
    private String description;
    private String expenseDate;
}
