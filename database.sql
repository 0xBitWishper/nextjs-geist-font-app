-- RR Store Management Database Schema

-- Users Table
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'user') DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Stores Master Table
CREATE TABLE IF NOT EXISTS toko (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nama_toko VARCHAR(100) NOT NULL,
    kategori ENUM('Senapan Angin', 'Fashion') NOT NULL,
    alamat TEXT,
    kontak VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Product Categories Table
CREATE TABLE IF NOT EXISTS kategori_produk (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nama_kategori VARCHAR(100) NOT NULL,
    extra_detail JSON,
    parent_id INT,
    FOREIGN KEY (parent_id) REFERENCES kategori_produk(id)
);

-- Marketplace Admin Fees Table
CREATE TABLE IF NOT EXISTS biaya_admin (
    id INT PRIMARY KEY AUTO_INCREMENT,
    marketplace VARCHAR(50) NOT NULL,
    biaya_persen DECIMAL(5,2) NOT NULL,
    description TEXT
);

-- Products Table
CREATE TABLE IF NOT EXISTS produk (
    id INT PRIMARY KEY AUTO_INCREMENT,
    toko_id INT NOT NULL,
    nama_produk VARCHAR(255) NOT NULL,
    harga_pokok DECIMAL(15,2) NOT NULL,
    harga_label DECIMAL(15,2) DEFAULT 0,
    harga_packaging DECIMAL(15,2) DEFAULT 0,
    operasional_packing DECIMAL(15,2) DEFAULT 0,
    biaya_tak_terduga DECIMAL(15,2) DEFAULT 0,
    margin DECIMAL(15,2) DEFAULT 0,
    affiliator_persen DECIMAL(5,2) DEFAULT 0,
    admin_marketplace_persen DECIMAL(5,2) DEFAULT 0,
    presentase_up DECIMAL(5,2) DEFAULT 0,
    harga_hasil1 DECIMAL(15,2),
    harga2 DECIMAL(15,2),
    harga_final1 DECIMAL(15,2),
    harga_final2 DECIMAL(15,2),
    image_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (toko_id) REFERENCES toko(id)
);

-- Orders Table
CREATE TABLE IF NOT EXISTS orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    toko_id INT NOT NULL,
    produk_id INT NOT NULL,
    order_no VARCHAR(50) NOT NULL,
    order_date DATE NOT NULL,
    marketplace VARCHAR(50) NOT NULL,
    nominal_penjualan DECIMAL(15,2) NOT NULL,
    admin_fee DECIMAL(15,2) DEFAULT 0,
    penghasilan_kotor DECIMAL(15,2),
    penghasilan_bersih DECIMAL(15,2),
    note TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (toko_id) REFERENCES toko(id),
    FOREIGN KEY (produk_id) REFERENCES produk(id)
);

-- Insert dummy data
-- Default admin user (password: admin123)
INSERT INTO users (username, password, role) VALUES
('admin', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin');

-- Insert dummy stores
INSERT INTO toko (nama_toko, kategori, alamat, kontak) VALUES
('RR SPORTS', 'Senapan Angin', 'Jl. Raya Sport No. 123', '+62812345678'),
('RR MERCH', 'Fashion', 'Jl. Fashion Street No. 456', '+62887654321');

-- Insert dummy categories
INSERT INTO kategori_produk (nama_kategori, extra_detail) VALUES
('T-Shirt', '{"sizes": ["XS", "S", "M", "L", "XL"]}'),
('Kemeja', '{"sizes": ["S", "M", "L", "XL"]}'),
('Jaket', '{"sizes": ["S", "M", "L", "XL"]}'),
('Senapan', NULL);

-- Insert marketplace fees
INSERT INTO biaya_admin (marketplace, biaya_persen, description) VALUES
('Shopee', 5.00, 'Shopee Marketplace Fee'),
('Tokopedia', 4.50, 'Tokopedia Marketplace Fee'),
('TikTok', 5.50, 'TikTok Shop Fee'),
('Blibli', 4.00, 'Blibli Marketplace Fee'),
('TF Lunas', 0.00, 'Direct Transfer - No Fee');
