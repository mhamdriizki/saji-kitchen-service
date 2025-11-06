package com.sajikitchen.saji_cashier.controllers.admin;

import com.sajikitchen.saji_cashier.dto.admin.*;
import com.sajikitchen.saji_cashier.models.InventoryItem;
import com.sajikitchen.saji_cashier.models.Product;
import com.sajikitchen.saji_cashier.models.ProductVariant;
import com.sajikitchen.saji_cashier.models.Topping;
import com.sajikitchen.saji_cashier.services.admin.AdminService;
import com.sajikitchen.saji_cashier.services.admin.InventoryService;
import com.sajikitchen.saji_cashier.services.admin.s3.S3Service;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/admin")
@RequiredArgsConstructor
public class AdminController {

    private static final Logger log = LoggerFactory.getLogger(AdminController.class);

    private final AdminService adminService;
    private final InventoryService inventoryService;
    private final S3Service s3Service;

    // == ENDPOINT BARU UNTUK UPLOAD FILE ==
    @PostMapping(value = "/upload-image", consumes = "multipart/form-data")
    public ResponseEntity<Map<String, String>> uploadImage(@RequestParam("file") MultipartFile file) throws IOException {
        String imageUrl = s3Service.uploadFile(file);
        return ResponseEntity.ok(Collections.singletonMap("imageUrl", imageUrl));
    }

    @GetMapping("/dashboard")
    public ResponseEntity<DashboardDataDto> getDashboardData() {
        DashboardDataDto dashboardData = adminService.getDashboardData();
        return ResponseEntity.ok(dashboardData);
    }

    @GetMapping("/dashboard/sales-detail")
    public ResponseEntity<List<DailySalesDetailDto>> getSalesDetailByDate(
            @RequestParam(value = "date", required = false) String dateStr) {

        // Jika parameter tanggal tidak disediakan, gunakan tanggal hari ini
        String dateToQuery = (dateStr == null || dateStr.isEmpty())
                ? java.time.LocalDate.now().toString()
                : dateStr;

        List<DailySalesDetailDto> salesDetail = adminService.getDailySalesDetail(dateToQuery);
        return ResponseEntity.ok(salesDetail);
    }

    // == MODIFIKASI ENDPOINT CREATE PRODUCT ==
    @PostMapping(value = "/products", consumes = "application/json")
    public ResponseEntity<Product> createProduct(@RequestBody ProductRequestDto request) {
        Product newProduct = adminService.createProduct(request);
        return new ResponseEntity<>(newProduct, HttpStatus.CREATED);
    }

    @PutMapping(value = "/products/{productId}", consumes = "application/json") // <-- UBAH KONSUMSI
    public ResponseEntity<Product> updateProduct(
            @PathVariable UUID productId,
            @RequestBody ProductRequestDto request) { // <-- UBAH PARAMETER

        // Service sudah siap menerima DTO, jadi tidak perlu ubah apa-apa
        Product updatedProduct = adminService.updateProduct(productId, request);
        return ResponseEntity.ok(updatedProduct);
    }

    @DeleteMapping("/products/{productId}")
    public ResponseEntity<Void> deleteProduct(@PathVariable UUID productId) {
        adminService.deleteProduct(productId);
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/products/{productId}/variants")
    public ResponseEntity<ProductVariant> createVariant(
            @PathVariable UUID productId,
            @RequestBody VariantRequestDto request) {
        ProductVariant newVariant = adminService.createVariant(productId, request);
        return new ResponseEntity<>(newVariant, HttpStatus.CREATED);
    }

    @PutMapping("/variants/{variantId}")
    public ResponseEntity<ProductVariant> updateVariant(
            @PathVariable UUID variantId,
            @RequestBody VariantRequestDto request) {
        ProductVariant updatedVariant = adminService.updateVariant(variantId, request);
        return ResponseEntity.ok(updatedVariant);
    }

    @DeleteMapping("/variants/{variantId}")
    public ResponseEntity<Void> deleteProductVariant(@PathVariable UUID variantId) {
        adminService.deleteProductVariant(variantId);
        return ResponseEntity.noContent().build();
    }

    // ==========================================================
    // ENDPOINT UNTUK MANAJEMEN TOPPING
    // ==========================================================
    @PostMapping(value = "/toppings", consumes = "application/json") // <-- UBAH KONSUMSI
    public ResponseEntity<Topping> createTopping(@RequestBody ToppingRequestDto request) { // <-- UBAH PARAMETER
        Topping newTopping = adminService.createTopping(request);
        return new ResponseEntity<>(newTopping, HttpStatus.CREATED);
    }

    @PutMapping(value = "/toppings/{toppingId}", consumes = "application/json") // <-- UBAH KONSUMSI
    public ResponseEntity<Topping> updateTopping(
            @PathVariable UUID toppingId,
            @RequestBody ToppingRequestDto request) { // <-- UBAH PARAMETER

        Topping updatedTopping = adminService.updateTopping(toppingId, request);
        return ResponseEntity.ok(updatedTopping);
    }

    @DeleteMapping("/toppings/{toppingId}")
    public ResponseEntity<Void> deleteTopping(@PathVariable UUID toppingId) {
        adminService.deleteTopping(toppingId);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/users")
    public ResponseEntity<List<UserResponseDto>> getAllUsers() {
        return ResponseEntity.ok(adminService.findAllUsers());
    }

    @PostMapping("/users")
    public ResponseEntity<UserResponseDto> createCashier(@RequestBody CreateUserRequestDto request) {
        UserResponseDto newCashier = adminService.createCashier(request);
        return new ResponseEntity<>(newCashier, HttpStatus.CREATED);
    }

    @PutMapping("/users/{userId}")
    public ResponseEntity<UserResponseDto> updateCashier(
            @PathVariable UUID userId,
            @RequestBody UpdateUserRequestDto request) {
        UserResponseDto updatedCashier = adminService.updateUser(userId, request);
        return ResponseEntity.ok(updatedCashier);
    }

    @GetMapping("/roles")
    public ResponseEntity<List<RoleResponseDto>> getAllRoles() {
        return ResponseEntity.ok(adminService.findAllRoles());
    }

    @DeleteMapping("/users/{userId}")
    public ResponseEntity<Void> deleteUser(@PathVariable UUID userId) {
        adminService.deleteUser(userId);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/inventory") // <-- 3. TAMBAHKAN ENDPOINT GET INI
    public ResponseEntity<List<InventoryResponeDto>> getAllInventoryItems() {
        return ResponseEntity.ok(inventoryService.getAllInventoryItems());
    }

    @PostMapping("/inventory")
    public ResponseEntity<InventoryResponeDto> createInventoryItem(@RequestBody InventoryRequestDto request) {
        InventoryResponeDto newItem = adminService.createInventoryItem(request); // Anda perlu membuat method ini di service
        return new ResponseEntity<>(newItem, HttpStatus.CREATED);
    }

    @PutMapping("/inventory/{itemId}")
    public ResponseEntity<InventoryResponeDto> updateInventoryItem(@PathVariable UUID itemId, @RequestBody InventoryRequestDto request) {
        InventoryResponeDto updatedItem = adminService.updateInventoryItem(itemId, request); // Anda perlu membuat method ini
        return ResponseEntity.ok(updatedItem);
    }

    @DeleteMapping("/inventory/{itemId}")
    public ResponseEntity<Void> deleteInventoryItem(@PathVariable UUID itemId) {
        adminService.deleteInventoryItem(itemId); // Anda perlu membuat method ini
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/dashboard/revenue-by-date")
    public ResponseEntity<DailySummaryDto> getRevenueByDate(
            @RequestParam(value = "date") String dateStr) {

        DailySummaryDto revenue = adminService.getRevenueForDate(dateStr);
        return ResponseEntity.ok(revenue);
    }
}
