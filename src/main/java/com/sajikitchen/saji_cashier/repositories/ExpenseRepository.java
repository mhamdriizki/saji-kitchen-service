package com.sajikitchen.saji_cashier.repositories;

import com.sajikitchen.saji_cashier.models.Expense;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;

@Repository
public interface ExpenseRepository extends JpaRepository<Expense, UUID> {

    // Mengambil semua pengeluaran oleh user tertentu pada rentang tanggal
    List<Expense> findByUser_UserIdAndExpenseDateBetween(UUID userId, OffsetDateTime startOfDay, OffsetDateTime endOfDay);

    // Menjumlahkan semua pengeluaran pada rentang tanggal
    @Query("SELECT COALESCE(SUM(e.amount), 0) FROM Expense e WHERE e.expenseDate >= :startOfDay AND e.expenseDate < :endOfDay")
    BigDecimal sumExpensesByDate(OffsetDateTime startOfDay, OffsetDateTime endOfDay);
}
