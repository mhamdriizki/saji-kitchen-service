package com.sajikitchen.saji_cashier.services.admin;

import com.sajikitchen.saji_cashier.dto.admin.*;
import com.sajikitchen.saji_cashier.models.*;
import com.sajikitchen.saji_cashier.repositories.*;
import com.sajikitchen.saji_cashier.services.admin.s3.S3Service;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.OffsetDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class AdminServiceImpl implements AdminService {

    private final OrderRepository orderRepository;
    private final ZoneId jakartaZone = ZoneId.of("Asia/Jakarta");
    private final ProductRepository productRepository;
    private final ProductVariantRepository productVariantRepository;
    private final ToppingRepository toppingRepository;
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final PasswordEncoder passwordEncoder;
    private final InventoryItemRepository inventoryItemRepository;
    private final ExpenseRepository expenseRepository;
    private final S3Service s3Service; // Injeksi S3Service

    @Override
    public DashboardDataDto getDashboardData() {
        // Tentukan rentang waktu (misal: 30 hari terakhir untuk chart)
        LocalDate today = LocalDate.now(jakartaZone);
        OffsetDateTime todayStart = LocalDate.now(jakartaZone).atStartOfDay().atOffset(jakartaZone.getRules().getOffset(java.time.Instant.now()));
        OffsetDateTime todayEnd = LocalDate.now(jakartaZone).atTime(LocalTime.MAX).atOffset(jakartaZone.getRules().getOffset(java.time.Instant.now()));
        OffsetDateTime last30Days = todayStart.minusDays(30);
        OffsetDateTime startOfMonth = today.withDayOfMonth(1).atStartOfDay().atOffset(jakartaZone.getRules().getOffset(java.time.Instant.now()));

        // 1. Panggil query untuk total omzet hari ini dan bulan ini
        BigDecimal todayGrossRevenue = orderRepository.findRevenueByDate(todayStart, todayEnd);
        BigDecimal todayExpenses = expenseRepository.sumExpensesByDate(todayStart, todayEnd);
        BigDecimal todayNetRevenue = todayGrossRevenue.subtract(todayExpenses);
        BigDecimal monthlyGrossRevenue = orderRepository.findRevenueByDate(startOfMonth, todayEnd);

        // 2. Panggil query untuk chart penjualan harian
        List<DailySalesDto> dailySales = orderRepository.findTotalSalesPerDay(last30Days);

        // 3. Panggil query untuk chart penjualan per kasir
        List<CashierSalesDto> salesByCashier = orderRepository.findTotalSalesByCashier(last30Days);

        // 4. Panggil Best sellers
        List<BestSellerDto> bestSellers = orderRepository.findBestSellers(last30Days);


        // Gabungkan semua data ke dalam satu DTO
        return DashboardDataDto.builder()
                .todayGrossRevenue(todayGrossRevenue)
                .todayExpenses(todayExpenses)
                .todayNetRevenue(todayNetRevenue)
                .monthlyGrossRevenue(monthlyGrossRevenue)
                .dailySales(dailySales)
                .salesByCashier(salesByCashier)
                .bestSellers(bestSellers)
                .build();
    }

    @Override
    public List<DailySalesDetailDto> getDailySalesDetail(String date) {
        LocalDate localDate;
        try {
            localDate = LocalDate.parse(date); // Parsing tanggal dari string format "YYYY-MM-DD"
        } catch (DateTimeParseException e) {
            // Jika format tanggal salah, gunakan tanggal hari ini sebagai default
            localDate = LocalDate.now(jakartaZone);
        }

        OffsetDateTime startOfDay = localDate.atStartOfDay().atOffset(jakartaZone.getRules().getOffset(java.time.Instant.now()));
        OffsetDateTime endOfDay = localDate.atTime(LocalTime.MAX).atOffset(jakartaZone.getRules().getOffset(java.time.Instant.now()));

        return orderRepository.findSalesDetailByDate(startOfDay, endOfDay);
    }

    @Override
    public Product createProduct(ProductRequestDto request) {
        Product newProduct = new Product();
        newProduct.setName(request.getName());
        newProduct.setDescription(request.getDescription());
        newProduct.setImageUrl(request.getImageUrl());
        newProduct.setActive(request.getIsActive() != null ? request.getIsActive() : true);
        return productRepository.save(newProduct);
    }

    @Override
    public Product updateProduct(UUID productId, ProductRequestDto request) {
        Product existingProduct = productRepository.findById(productId)
                .orElseThrow(() -> new EntityNotFoundException("Product not found with id: " + productId));

        existingProduct.setName(request.getName());
        existingProduct.setDescription(request.getDescription());
        if (request.getImageUrl() != null && !request.getImageUrl().isEmpty()) {
            existingProduct.setImageUrl(request.getImageUrl());
        }
        if (request.getIsActive() != null) {
            existingProduct.setActive(request.getIsActive());
        }
        return productRepository.save(existingProduct);
    }

    @Override
    public void deleteProduct(UUID productId) {
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new EntityNotFoundException("Product not found with id: " + productId));

        // 1. Hapus gambar dari S3 terlebih dahulu
        s3Service.deleteFile(product.getImageUrl());

        // 2. Hapus produk dari database (hard delete)
        productRepository.deleteById(productId);
    }

    @Override
    public ProductVariant createVariant(UUID productId, VariantRequestDto request) {
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new EntityNotFoundException("Product not found with id: " + productId));

        ProductVariant newVariant = new ProductVariant();
        newVariant.setProduct(product);
        newVariant.setName(request.getName());
        newVariant.setPrice(request.getPrice());

        return productVariantRepository.save(newVariant);
    }

    @Override
    public ProductVariant updateVariant(UUID variantId, VariantRequestDto request) {
        ProductVariant existingVariant = productVariantRepository.findById(variantId)
                .orElseThrow(() -> new EntityNotFoundException("Product Variant not found with id: " + variantId));

        existingVariant.setName(request.getName());
        existingVariant.setPrice(request.getPrice());

        return productVariantRepository.save(existingVariant);
    }

    @Override
    public void deleteProductVariant(UUID variantId) { // Buat method ini jika belum ada
        productVariantRepository.deleteById(variantId);
    }

    @Override
    public Topping createTopping(ToppingRequestDto request) {
        Topping newTopping = new Topping();
        newTopping.setName(request.getName());
        newTopping.setPrice(request.getPrice());
        newTopping.setImageUrl(request.getImageUrl());
        newTopping.setActive(request.getIsActive() != null ? request.getIsActive() : true);

        return toppingRepository.save(newTopping);
    }

    @Override
    public Topping updateTopping(UUID toppingId, ToppingRequestDto request) {
        Topping existingTopping = toppingRepository.findById(toppingId)
                .orElseThrow(() -> new EntityNotFoundException("Topping not found with id: " + toppingId));

        existingTopping.setName(request.getName());
        existingTopping.setPrice(request.getPrice());
        if (request.getImageUrl() != null && !request.getImageUrl().isEmpty()) {
            existingTopping.setImageUrl(request.getImageUrl());
        }
        if (request.getIsActive() != null) {
            existingTopping.setActive(request.getIsActive());
        }

        return toppingRepository.save(existingTopping);
    }

    @Override
    public void deleteTopping(UUID toppingId) { // Buat method ini jika belum ada
        Topping topping = toppingRepository.findById(toppingId)
                .orElseThrow(() -> new EntityNotFoundException("Topping not found"));

        s3Service.deleteFile(topping.getImageUrl());
        toppingRepository.deleteById(toppingId);
    }

    @Override
    public List<UserResponseDto> findAllUsers() {
        return userRepository.findAllByOrderByRoleRoleNameAscUsernameAsc().stream()
                .map(this::mapUserToResponseDto)
                .collect(Collectors.toList());
    }

    @Override
    public UserResponseDto createCashier(CreateUserRequestDto request) {
        if (userRepository.findByUsername(request.getUsername()).isPresent()) {
            throw new IllegalStateException("Username already exists");
        }

        // Cari role berdasarkan ID dari request, bukan di-hardcode
        Role userRole = roleRepository.findById(request.getRoleId())
                .orElseThrow(() -> new EntityNotFoundException("Role not found"));

        User newUser = new User();
        newUser.setUsername(request.getUsername());
        newUser.setPassword(passwordEncoder.encode(request.getPassword()));
        newUser.setRole(userRole);
        newUser.setActive(true);

        User savedUser = userRepository.save(newUser);
        return mapUserToResponseDto(savedUser);
    }

    @Override
    public UserResponseDto updateUser(UUID userId, UpdateUserRequestDto request) {
        User existingUser = userRepository.findById(userId)
                .orElseThrow(() -> new EntityNotFoundException("User not found with id: " + userId));

        if (request.getIsActive() != null) {
            existingUser.setActive(request.getIsActive());
        }

        // Logika baru untuk mengubah role
        if (request.getRoleId() != null) {
            Role newRole = roleRepository.findById(request.getRoleId())
                    .orElseThrow(() -> new EntityNotFoundException("Role not found with id: " + request.getRoleId()));
            existingUser.setRole(newRole);
        }

        User updatedUser = userRepository.save(existingUser);
        return mapUserToResponseDto(updatedUser);
    }

    // Method baru untuk mengambil semua roles
    @Override
    public List<RoleResponseDto> findAllRoles() {
        return roleRepository.findAll().stream()
                .map(role -> RoleResponseDto.builder()
                        .roleId(role.getRoleId())
                        .roleName(role.getRoleName())
                        .build())
                .collect(Collectors.toList());
    }

    @Override
    public void deleteUser(UUID userId) {
        if (!userRepository.existsById(userId)) {
            throw new EntityNotFoundException("User not found with id: " + userId);
        }

        // Hapus user secara permanen dari database
        userRepository.deleteById(userId);
    }

    private UserResponseDto mapUserToResponseDto(User user) {
        return UserResponseDto.builder()
                .userId(user.getUserId())
                .username(user.getUsername())
                .roleName(user.getRole().getRoleName())
                .isActive(user.isActive())
                .build();
    }

    @Override
    public InventoryResponeDto createInventoryItem(InventoryRequestDto request) {
        InventoryItem newItem = new InventoryItem();
        newItem.setName(request.getName());
        newItem.setQuantity(request.getQuantity() != null ? request.getQuantity() : 0);
        newItem.setThreshold(request.getThreshold() != null ? request.getThreshold() : 10);
        newItem.setActive(request.getIsActive() != null ? request.getIsActive() : true);

        InventoryItem savedItem = inventoryItemRepository.save(newItem);
        return mapToInventoryResponeDto(savedItem);
    }

    @Override
    public InventoryResponeDto updateInventoryItem(UUID itemId, InventoryRequestDto request) {
        InventoryItem existingItem = inventoryItemRepository.findById(itemId)
                .orElseThrow(() -> new EntityNotFoundException("Inventory item not found: " + itemId));

        if (request.getName() != null) existingItem.setName(request.getName());
        if (request.getQuantity() != null) existingItem.setQuantity(request.getQuantity());
        if (request.getThreshold() != null) existingItem.setThreshold(request.getThreshold());
        if (request.getIsActive() != null) existingItem.setActive(request.getIsActive());

        InventoryItem updatedItem = inventoryItemRepository.save(existingItem);
        return mapToInventoryResponeDto(updatedItem);
    }

    @Override
    public void deleteInventoryItem(UUID itemId) {
        // Cek dulu apakah item-nya ada untuk memberikan pesan error yang jelas
        if (!inventoryItemRepository.existsById(itemId)) {
            throw new EntityNotFoundException("Inventory item not found: " + itemId);
        }

        // Hapus baris secara permanen dari database
        inventoryItemRepository.deleteById(itemId);
    }

    // Helper method untuk mapping
    private InventoryResponeDto mapToInventoryResponeDto(InventoryItem item) {
        return InventoryResponeDto.builder()
                .itemId(item.getItemId())
                .name(item.getName())
                .quantity(item.getQuantity())
                .threshold(item.getThreshold())
                .isActive(item.isActive())
                .build();
    }

    @Override
    public DailySummaryDto getRevenueForDate(String date) {
        LocalDate localDate;
        try {
            // Parsing tanggal dari string format "YYYY-MM-DD"
            localDate = LocalDate.parse(date);
        } catch (DateTimeParseException e) {
            // Jika format tanggal salah, gunakan tanggal hari ini
            localDate = LocalDate.now(jakartaZone);
        }

        OffsetDateTime startOfDay = localDate.atStartOfDay().atOffset(jakartaZone.getRules().getOffset(java.time.Instant.now()));
        OffsetDateTime endOfDay = localDate.atTime(LocalTime.MAX).atOffset(jakartaZone.getRules().getOffset(java.time.Instant.now()));

        BigDecimal grossRevenue = orderRepository.findRevenueByDate(startOfDay, endOfDay);
        BigDecimal expenses = expenseRepository.sumExpensesByDate(startOfDay, endOfDay);
        BigDecimal netRevenue = grossRevenue.subtract(expenses);

        // Menggunakan kembali query yang sudah ada untuk omzet harian
        return DailySummaryDto.builder()
                .gross(grossRevenue)
                .expenses(expenses)
                .net(netRevenue)
                .build();
    }
}
