package com.sajikitchen.saji_cashier.services.cashier;

import com.sajikitchen.saji_cashier.dto.cashier.ExpenseRequest;
import com.sajikitchen.saji_cashier.dto.cashier.ExpenseResponse;

import java.util.List;
import java.util.UUID;

public interface ExpenseService {
    List<ExpenseResponse> getTodayExpensesForCurrentUser();
    ExpenseResponse createExpense(ExpenseRequest request);
    ExpenseResponse updateExpense(UUID expenseId, ExpenseRequest request);
    void deleteExpense(UUID expenseId);
}
