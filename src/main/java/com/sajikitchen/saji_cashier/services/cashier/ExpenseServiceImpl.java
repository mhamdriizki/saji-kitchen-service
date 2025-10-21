package com.sajikitchen.saji_cashier.services.cashier;

import com.sajikitchen.saji_cashier.dto.cashier.ExpenseRequest;
import com.sajikitchen.saji_cashier.dto.cashier.ExpenseResponse;
import com.sajikitchen.saji_cashier.models.Expense;
import com.sajikitchen.saji_cashier.models.User;
import com.sajikitchen.saji_cashier.repositories.ExpenseRepository;
import com.sajikitchen.saji_cashier.repositories.UserRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.OffsetDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ExpenseServiceImpl implements ExpenseService {

    private final ExpenseRepository expenseRepository;
    private final UserRepository userRepository;
    private final ZoneId jakartaZone = ZoneId.of("Asia/Jakarta");

    @Override
    public List<ExpenseResponse> getTodayExpensesForCurrentUser() {
        User currentUser = getCurrentUser();
        OffsetDateTime startOfDay = LocalDate.now(jakartaZone).atStartOfDay().atOffset(jakartaZone.getRules().getOffset(java.time.Instant.now()));
        OffsetDateTime endOfDay = LocalDate.now(jakartaZone).atTime(LocalTime.MAX).atOffset(jakartaZone.getRules().getOffset(java.time.Instant.now()));

        return expenseRepository.findByUser_UserIdAndExpenseDateBetween(currentUser.getUserId(), startOfDay, endOfDay)
                .stream().map(this::mapToDTO).collect(Collectors.toList());
    }

    @Override
    public ExpenseResponse createExpense(ExpenseRequest request) {
        User currentUser = getCurrentUser();

        Expense expense = new Expense();
        expense.setUser(currentUser);
        expense.setAmount(request.getAmount());
        expense.setDescription(request.getDescription());

        return mapToDTO(expenseRepository.save(expense));
    }

    @Override
    public ExpenseResponse updateExpense(UUID expenseId, ExpenseRequest request) {
        User currentUser = getCurrentUser();
        Expense expense = findExpenseByIdAndValidateOwnership(expenseId, currentUser);

        expense.setAmount(request.getAmount());
        expense.setDescription(request.getDescription());

        return mapToDTO(expenseRepository.save(expense));
    }

    @Override
    public void deleteExpense(UUID expenseId) {
        User currentUser = getCurrentUser();
        Expense expense = findExpenseByIdAndValidateOwnership(expenseId, currentUser);
        expenseRepository.delete(expense);
    }

    // --- Helper Methods ---
    private User getCurrentUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        return userRepository.findByUsername(username)
                .orElseThrow(() -> new EntityNotFoundException("User not found"));
    }

    private Expense findExpenseByIdAndValidateOwnership(UUID expenseId, User user) {
        Expense expense = expenseRepository.findById(expenseId)
                .orElseThrow(() -> new EntityNotFoundException("Expense not found"));

        if (!expense.getUser().getUserId().equals(user.getUserId())) {
            throw new SecurityException("User does not have permission to modify this expense");
        }

        LocalDate expenseDate = expense.getExpenseDate().atZoneSameInstant(jakartaZone).toLocalDate();
        if (!expenseDate.equals(LocalDate.now(jakartaZone))) {
            throw new IllegalStateException("Cannot modify expenses from a past date");
        }

        return expense;
    }

    private ExpenseResponse mapToDTO(Expense expense) {
        return ExpenseResponse.builder()
                .expenseId(expense.getExpenseId())
                .username(expense.getUser().getUsername())
                .amount(expense.getAmount())
                .description(expense.getDescription())
                .expenseDate(expense.getExpenseDate().format(DateTimeFormatter.ofPattern("dd MMM yyyy HH:mm:ss")))
                .build();
    }
}
