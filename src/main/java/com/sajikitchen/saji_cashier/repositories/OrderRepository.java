package com.sajikitchen.saji_cashier.repositories;

import com.sajikitchen.saji_cashier.dto.admin.BestSellerDto;
import com.sajikitchen.saji_cashier.dto.admin.CashierSalesDto;
import com.sajikitchen.saji_cashier.dto.admin.DailySalesDetailDto;
import com.sajikitchen.saji_cashier.dto.admin.DailySalesDto;
import com.sajikitchen.saji_cashier.models.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.time.OffsetDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface OrderRepository extends JpaRepository<Order, String> {
    @Query("SELECT o FROM Order o " +
            "JOIN FETCH o.customer " +
            "JOIN FETCH o.user " +
            "LEFT JOIN FETCH o.orderItems oi " +
            "LEFT JOIN FETCH oi.productVariant pv " +
            "LEFT JOIN FETCH pv.product " +
            "LEFT JOIN FETCH oi.topping " +
            "WHERE o.orderId = :orderId")
    Optional<Order> findByIdWithDetails(String orderId);

    @Query("SELECT COALESCE(SUM(o.totalAmount), 0) FROM Order o WHERE o.paymentStatus = 'PAID' AND o.orderDate >= :startOfDay AND o.orderDate < :endOfDay")
    BigDecimal findRevenueByDate(OffsetDateTime startOfDay, OffsetDateTime endOfDay);

    @Query("SELECT new com.sajikitchen.saji_cashier.dto.admin.DailySalesDto(CAST(o.orderDate AS java.time.LocalDate), SUM(o.totalAmount)) " +
            "FROM Order o WHERE o.paymentStatus = 'PAID' AND o.orderDate >= :startDate " +
            "GROUP BY CAST(o.orderDate AS java.time.LocalDate) ORDER BY CAST(o.orderDate AS java.time.LocalDate) ASC")
    List<DailySalesDto> findTotalSalesPerDay(OffsetDateTime startDate);

    @Query("SELECT new com.sajikitchen.saji_cashier.dto.admin.CashierSalesDto(o.user.username, SUM(o.totalAmount)) " +
            "FROM Order o WHERE o.paymentStatus = 'PAID' AND o.orderDate >= :startDate " +
            "GROUP BY o.user.username ORDER BY SUM(o.totalAmount) DESC")
    List<CashierSalesDto> findTotalSalesByCashier(OffsetDateTime startDate);

    @Query("SELECT new com.sajikitchen.saji_cashier.dto.admin.DailySalesDetailDto(" +
            "oi.productVariant.product.name, " +
            "oi.productVariant.name, " +
            "oi.topping.name, " +
            "SUM(oi.quantity)) " +
            "FROM OrderItem oi " +
            "WHERE oi.order.paymentStatus = 'PAID' AND oi.order.orderDate >= :startDate AND oi.order.orderDate < :endDate " +
            "GROUP BY oi.productVariant.product.name, oi.productVariant.name, oi.topping.name")
    List<DailySalesDetailDto> findSalesDetailByDate(OffsetDateTime startDate, OffsetDateTime endDate);

    // --- QUERY BARU UNTUK BEST SELLER ---
    @Query("SELECT new com.sajikitchen.saji_cashier.dto.admin.BestSellerDto(" +
            "CONCAT(pv.product.name, ' (', pv.name, ')', " +
            "CASE WHEN t.name IS NOT NULL THEN CONCAT(' + ', t.name) ELSE '' END), " +
            "SUM(oi.quantity)) " +
            "FROM OrderItem oi " +
            "JOIN oi.productVariant pv " +
            "LEFT JOIN oi.topping t " +
            "WHERE oi.order.paymentStatus = 'PAID' AND oi.order.orderDate >= :startDate " +
            "GROUP BY pv.product.name, pv.name, t.name " +
            "ORDER BY SUM(oi.quantity) DESC")
    List<BestSellerDto> findBestSellers(OffsetDateTime startDate);
}
