package com.sajikitchen.saji_cashier.services.cashier;

import com.sajikitchen.saji_cashier.dto.cashier.CreateOrderRequest;
import com.sajikitchen.saji_cashier.dto.cashier.OrderResponse;
import jakarta.transaction.Transactional;

public interface OrderService {
    @Transactional
    OrderResponse createOrder(CreateOrderRequest request);
    OrderResponse confirmPayment(String orderId);
    OrderResponse getOrderById(String orderId);
}