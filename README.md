# Saji Kitchen Service (Backend)

Backend service untuk sistem Point of Sales (POS) dan Manajemen Inventaris **Saji Kitchen**. Aplikasi ini dibangun menggunakan Java Spring Boot dan menangani logika bisnis utama mulai dari manajemen stok, transaksi kasir, manajemen pengguna, hingga pelaporan keuangan.

## 🛠 Tech Stack

* **Language:** Java 21
* **Framework:** Spring Boot 3.x
* **Database:** PostgreSQL
* **Security:** Spring Security & JWT (JSON Web Token)
* **Build Tool:** Maven
* **Deployment:** Docker / Systemd Service (VPS)
* **CI/CD:** GitHub Actions
* **Other Libraries:**
    * *Lombok* (Boilerplate reduction)
    * *iText* (PDF Receipt Generation)
    * *Java Mail Sender* (Email Notifications)

## 📋 Prerequisites

Sebelum menjalankan aplikasi ini, pastikan local machine kamu sudah terinstall:

1.  **Java JDK 21**
2.  **PostgreSQL** (Running di port 5432 atau 5433)
3.  **Maven** (Optional, bisa pakai `./mvnw` bawaan)

## 🚀 Getting Started (Local Development)

Ikuti langkah-langkah ini untuk menjalankan aplikasi di local machine:

### 1. Clone Repository
```
git clone [https://github.com/mhamdriizki/saji-kitchen-service.git](https://github.com/mhamdriizki/saji-kitchen-service.git)
cd saji-kitchen-service
```

### 2. Create Database
```sql
CREATE DATABASE saji_kitchen;
```

### 3. Setup Environment Variables
```
cp src/main/resources/application-local.properties.example src/main/resources/application-local.properties
```
Edit file `src/main/resources/application-local.properties` dan sesuaikan dengan kredensial DB lokal kamu:
```properties
spring.datasource.url=jdbc:postgresql://localhost:5433/saji_kitchen
spring.datasource.username=postgres
spring.datasource.password=password_lokal_kamu
```

### 4. Build & Run
```
# Untuk Mac/Linux
./mvnw clean spring-boot:run -Dspring-boot.run.profiles=local

# Untuk Windows
.\mvnw.cmd clean spring-boot:run -Dspring-boot.run.profiles=local
```
Aplikasi akan berjalan di `http://localhost:8080`.

## ⚙️ Configuration Profiles
Aplikasi ini mendukung beberapa profile konfigurasi:

Profile | File Config                  | Kegunaan
--- |------------------------------| ---
local | application-local.properties |Untuk development di laptop lokal. File ini di-ignore oleh git.
dev | application-dev.properties | Konfigurasi default development.
prod| application-prod.properties | Konfigurasi production. Di GitHub isinya dummy/placeholder. Config asli disimpan aman di Server VPS.

## 🔑 Critical Properties (Production)
Config berikut wajib diatur di server production (/opt/saji-cashier/application-prod.properties):
- spring.datasource.password: Password DB Production.
- application.security.jwt.secret-key: Key acak 256-bit untuk sign token JWT.
- spring.mail.password: App Password Gmail untuk notifikasi.

## 📡 API Endpoints Overview
Berikut adalah overview endpoint utama. Tersedia file .http di root folder project untuk testing langsung via IntelliJ IDEA / VS Code.

### Authentication
- POST /api/v1/auth/login - Login untuk Admin & Cashier (mendapatkan JWT).

### Admin (Role: ADMIN)
- Dashboard: GET /api/v1/admin/dashboard (Statistik penjualan, best seller).
- Products: CRUD Produk & Upload Gambar.
- Inventory: Manajemen stok bahan baku.
- Users: Manajemen user (tambah kasir/admin).
- Toppings: Manajemen varian topping.

### Cashier (Role: CASHIER)
- Orders:
    - POST /api/v1/cashier/orders - Membuat pesanan baru. 
    - GET /api/v1/cashier/orders/{id}/receipt - Download struk PDF.
- Expenses: Mencatat pengeluaran operasional harian.

### Public / Utility
- GET /api/v1/images/{id} - Serve gambar produk. 
- GET /actuator/health - Cek status kesehatan aplikasi & DB.

## 💾 Database Seeding
Untuk inisialisasi data awal (Admin default, Role, kategori dasar), kamu bisa menggunakan file SQL yang tersedia:

File: src/main/resources/seed.sql

Jalankan script ini di query tool database kamu setelah tabel terbentuk oleh Hibernate (ddl-auto=update).

---
Saji Kitchen Tech Team © 2025