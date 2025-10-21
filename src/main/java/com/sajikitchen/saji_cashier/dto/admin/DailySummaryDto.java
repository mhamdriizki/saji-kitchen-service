package com.sajikitchen.saji_cashier.dto.admin;

import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;

@Data
@Builder
public class DailySummaryDto {
    private BigDecimal gross;
    private BigDecimal expenses;
    private BigDecimal net;
}