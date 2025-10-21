-- DDL for Saji Kitchen Service
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Table for user roles
CREATE TABLE roles (
    role_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    role_name VARCHAR(50) UNIQUE NOT NULL
);

-- Table for application users
CREATE TABLE users (
    user_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    username VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role_id UUID NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    CONSTRAINT fk_role
        FOREIGN KEY(role_id)
        REFERENCES roles(role_id)
);

-- Table for main products
CREATE TABLE products (
    product_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    image_url VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Table for product variations
CREATE TABLE product_variants (
    variant_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    product_id UUID NOT NULL,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    CONSTRAINT fk_product
        FOREIGN KEY(product_id)
        REFERENCES products(product_id)
);

-- Table for toppings
CREATE TABLE toppings (
    topping_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    image_url VARCHAR(255),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Table for customers
CREATE TABLE customers (
    customer_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) UNIQUE NOT NULL,
    name VARCHAR(255),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Table for orders/transactions
CREATE TABLE orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id UUID NOT NULL,
    user_id UUID NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    payment_status VARCHAR(50) NOT NULL,
    order_date TIMESTAMPTZ DEFAULT NOW(),
    payment_confirmed_at TIMESTAMPTZ,
    CONSTRAINT fk_customer
        FOREIGN KEY(customer_id)
        REFERENCES customers(customer_id),
    CONSTRAINT fk_user
        FOREIGN KEY(user_id)
        REFERENCES users(user_id)
);

-- Table for detailed order items
CREATE TABLE order_items (
    order_item_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_id VARCHAR(50) NOT NULL,
    variant_id UUID NOT NULL,
    topping_id UUID,
    quantity INT NOT NULL,
    price_at_purchase DECIMAL(10, 2) NOT NULL,
    topping_price_at_purchase DECIMAL(10, 2),
    CONSTRAINT fk_order
        FOREIGN KEY(order_id)
        REFERENCES orders(order_id) ON DELETE CASCADE,
    CONSTRAINT fk_variant
        FOREIGN KEY(variant_id)
        REFERENCES product_variants(variant_id),
    CONSTRAINT fk_topping
        FOREIGN KEY(topping_id)
        REFERENCES toppings(topping_id)
);


-- Table for API response codes
CREATE TABLE response_codes (
                                code VARCHAR(50) PRIMARY KEY,
                                message_en TEXT NOT NULL,
                                message_id TEXT NOT NULL,
                                description TEXT
);

-- Insert Response Codes
INSERT INTO response_codes (code, message_en, message_id, description) VALUES
                                                                        ('SAJI-00-001', 'Success.', 'Berhasil.', 'Generic success response'),
                                                                        ('SAJI-00-400', 'Bad Request.', 'Request Tidak Valid.', 'Generic bad request from client'),
                                                                        ('SAJI-01-404', 'Order not found.', 'Pesanan tidak ditemukan.', 'Used when an order ID does not exist');

-- Insert Roles
INSERT INTO roles (role_name) VALUES ('ADMIN'), ('CASHIER');

-- Insert User
INSERT INTO users (username, password, role_id) VALUES ('kasir01', '$2a$12$nYIt2xs6dRWK8XHV6/EdruuBuqiN3DQJ48cVXZEhR9yRi0RXT.HGS', (SELECT role_id FROM roles WHERE role_name = 'CASHIER'));

-- Insert Products
INSERT INTO products (name, image_url) VALUES ('Dimsum Mentai', 'https://saji-kitchen-asset.s3.ap-southeast-1.amazonaws.com/dimsum-mentai.png') ON CONFLICT DO NOTHING;
INSERT INTO products (name, image_url) VALUES ('Dimsum Original', 'https://saji-kitchen-asset.s3.ap-southeast-1.amazonaws.com/dimsum-ori.png') ON CONFLICT DO NOTHING;

-- Insert Product Variants
INSERT INTO product_variants (product_id, name, price) VALUES ((SELECT product_id FROM products WHERE name = 'Dimsum Mentai'), 'Isi 2', 10000.00) ON CONFLICT DO NOTHING;
INSERT INTO product_variants (product_id, name, price) VALUES ((SELECT product_id FROM products WHERE name = 'Dimsum Mentai'), 'Isi 2 + Topping', 12000.00) ON CONFLICT DO NOTHING;
INSERT INTO product_variants (product_id, name, price) VALUES ((SELECT product_id FROM products WHERE name = 'Dimsum Mentai'), 'Isi 4', 18000.00) ON CONFLICT DO NOTHING;
INSERT INTO product_variants (product_id, name, price) VALUES ((SELECT product_id FROM products WHERE name = 'Dimsum Mentai'), 'Isi 4 + Topping', 22000.00) ON CONFLICT DO NOTHING;
INSERT INTO product_variants (product_id, name, price) VALUES ((SELECT product_id FROM products WHERE name = 'Dimsum Mentai'), 'Isi 6', 25000.00) ON CONFLICT DO NOTHING;
INSERT INTO product_variants (product_id, name, price) VALUES ((SELECT product_id FROM products WHERE name = 'Dimsum Mentai'), 'Isi 6 + Topping', 30000.00) ON CONFLICT DO NOTHING;
INSERT INTO product_variants (product_id, name, price) VALUES ((SELECT product_id FROM products WHERE name = 'Dimsum Original'), 'Isi 2', 8000.00) ON CONFLICT DO NOTHING;
INSERT INTO product_variants (product_id, name, price) VALUES ((SELECT product_id FROM products WHERE name = 'Dimsum Original'), 'Isi 2 + Topping', 10000.00) ON CONFLICT DO NOTHING;
INSERT INTO product_variants (product_id, name, price) VALUES ((SELECT product_id FROM products WHERE name = 'Dimsum Original'), 'Isi 4', 16000.00) ON CONFLICT DO NOTHING;
INSERT INTO product_variants (product_id, name, price) VALUES ((SELECT product_id FROM products WHERE name = 'Dimsum Original'), 'Isi 4 + Topping', 20000.00) ON CONFLICT DO NOTHING;
INSERT INTO product_variants (product_id, name, price) VALUES ((SELECT product_id FROM products WHERE name = 'Dimsum Original'), 'Isi 6', 23000.00) ON CONFLICT DO NOTHING;
INSERT INTO product_variants (product_id, name, price) VALUES ((SELECT product_id FROM products WHERE name = 'Dimsum Original'), 'Isi 6 + Topping', 28000.00) ON CONFLICT DO NOTHING;

-- Insert Toppings
INSERT INTO toppings (name, price, image_url) VALUES ('Keju Cheddar', 0, 'https://saji-kitchen-asset.s3.ap-southeast-1.amazonaws.com/keju-cheddar.png') ON CONFLICT DO NOTHING;
INSERT INTO toppings (name, price, image_url) VALUES ('Keju Quickmelt', 0, 'https://saji-kitchen-asset.s3.ap-southeast-1.amazonaws.com/keju-quickmelt.png') ON CONFLICT DO NOTHING;
INSERT INTO toppings (name, price, image_url) VALUES ('Nori Flakes', 0, 'https://saji-kitchen-asset.s3.ap-southeast-1.amazonaws.com/nori-flakes.png') ON CONFLICT DO NOTHING;
INSERT INTO toppings (name, price, image_url) VALUES ('Katsuboshi', 0, 'https://saji-kitchen-asset.s3.ap-southeast-1.amazonaws.com/katsuboshi.png') ON CONFLICT DO NOTHING;

-- Tabel untuk menyimpan item-item inventaris
CREATE TABLE inventory_items (
    item_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) UNIQUE NOT NULL,
    quantity INT NOT NULL DEFAULT 0,
    threshold INT NOT NULL DEFAULT 10, -- Ambang batas notifikasi
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Tabel relasi untuk menghubungkan varian produk dengan item inventaris
CREATE TABLE variant_inventory_mapping (
    variant_id UUID NOT NULL,
    inventory_item_id UUID NOT NULL,
    quantity_to_decrement INT NOT NULL DEFAULT 1,
    PRIMARY KEY (variant_id, inventory_item_id),
    CONSTRAINT fk_variant FOREIGN KEY(variant_id) REFERENCES product_variants(variant_id) ON DELETE CASCADE,
    CONSTRAINT fk_inventory_item FOREIGN KEY(inventory_item_id) REFERENCES inventory_items(item_id) ON DELETE CASCADE
);

INSERT INTO inventory_items (name, quantity, threshold) VALUES
                                                            ('Sumpit', 200, 50),
                                                            ('Plastik Kecil', 200, 50),
                                                            ('Plastik Besar', 200, 50),
                                                            ('Mika', 100, 20),
                                                            ('Foil isi 4', 100, 20),
                                                            ('Foil isi 6', 100, 20)
    ON CONFLICT (name) DO NOTHING;

-- Aturan #1: Semua varian yang namanya mengandung 'Isi 2' akan mengurangi "Mika"
INSERT INTO variant_inventory_mapping (variant_id, inventory_item_id)
SELECT
    pv.variant_id,
    (SELECT item_id FROM inventory_items WHERE name = 'Mika')
FROM
    product_variants pv
WHERE
    pv.name LIKE '%Isi 2%'
    ON CONFLICT (variant_id, inventory_item_id) DO NOTHING;

-- Aturan #2: Semua varian yang namanya mengandung 'Isi 4' akan mengurangi "Foil isi 4"
INSERT INTO variant_inventory_mapping (variant_id, inventory_item_id)
SELECT
    pv.variant_id,
    (SELECT item_id FROM inventory_items WHERE name = 'Foil isi 4')
FROM
    product_variants pv
WHERE
    pv.name LIKE '%Isi 4%'
    ON CONFLICT (variant_id, inventory_item_id) DO NOTHING;

-- Aturan #3: Semua varian yang namanya mengandung 'Isi 6' akan mengurangi "Foil isi 6"
INSERT INTO variant_inventory_mapping (variant_id, inventory_item_id)
SELECT
    pv.variant_id,
    (SELECT item_id FROM inventory_items WHERE name = 'Foil isi 6')
FROM
    product_variants pv
WHERE
    pv.name LIKE '%Isi 6%'
    ON CONFLICT (variant_id, inventory_item_id) DO NOTHING;

CREATE TABLE expenses (
    expense_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    description TEXT,
    expense_date TIMESTAMPTZ DEFAULT NOW(),
    CONSTRAINT fk_user_expense
        FOREIGN KEY(user_id)
            REFERENCES users(user_id)
);