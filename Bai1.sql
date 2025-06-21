-- 1. Tạo cơ sở dữ liệu
CREATE DATABASE IF NOT EXISTS Ecommerce;
USE Ecommerce;

-- 2. Bảng User
CREATE TABLE User (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Bảng Category
CREATE TABLE Category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- 4. Bảng Product
CREATE TABLE Product (
    product_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    price FLOAT NOT NULL CHECK (price > 0),
    stock INT DEFAULT 0,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- 5. Bảng Order
CREATE TABLE `Order` (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount FLOAT,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- 6. Bảng Order_Detail
CREATE TABLE Order_Detail (
    order_id INT,
    product_id VARCHAR(10),
    quantity INT NOT NULL CHECK (quantity > 0),
    price_at_time FLOAT NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES `Order`(order_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

# Insert bảng Category
INSERT INTO Category(name, description) VALUES
('Điện tử', 'Thiết bị công nghệ'),
('Thời trang', 'Quần áo, phụ kiện'),
('Gia dụng', 'Đồ dùng gia đình'),
('Thể thao', 'Thiết bị thể thao'),
('Sách', 'Sách học, kỹ năng, kỹ thuật');

# Insert bảng User
INSERT INTO User(name, email, password) VALUES
('Nguyễn Văn An', 'annv@gmail.com', '123456'),
('Trần Thị Bình', 'binhtt@rikkeisoft.com', '123456'),
('Lê Văn Chiến', 'chienlv@rikkei.academy.com', '123456'),
('Nguyễn Hà Quyên', 'quyennh@rikkei.education.com', '123456'),
('Võ Văn Hải', 'haivv@rikkei.education.com', '123456');

# Insert bảng Product
INSERT INTO Product(product_id, name, price, stock, category_id) VALUES
('P001', 'Iphone 14', 20000000, 10, 1),
('P002', 'Laptop Dell XPS', 30000000, 5, 1),
('P003', 'Áo thun nam', 250000, 50, 2),
('P004', 'Quần jeans nữ', 400000, 40, 2),
('P005', 'Nồi cơm điện Sharp', 800000, 20, 3);

# Insert bảng Order
INSERT INTO `Order`(user_id, total_amount, created_at) VALUES
(1, 20200000, '2024-06-01'),
(2, 325000, '2024-06-01'),
(3, 800000, '2024-06-02'),
(4, 1500000, '2024-06-02'),
(5, 700000, '2024-08-03'),
(1, 150000, '2024-08-03'),
(2, 3000000, '2024-08-03'),
(3, 400000, '2024-08-03'),
(4, 600000, '2024-09-20'),
(5, 800000, '2024-09-20');

# Insert bảng Order_Detail
INSERT INTO Order_Detail(order_id, product_id, quantity, price_at_time) VALUES
(1, 'P001', 1, 20000000),
(1, 'P003', 1, 250000),
(2, 'P004', 1, 400000),
(2, 'P005', 1, 800000),
(3, 'P003', 2, 250000),
(4, 'P002', 1, 30000000),
(5, 'P005', 1, 800000),
(6, 'P001', 1, 20000000),
(7, 'P002', 1, 30000000),
(8, 'P004', 1, 400000),
(9, 'P003', 2, 250000),
(10, 'P005', 1, 800000);

# Cập nhật dữ liệu
-- Cập nhật số lượng tồn kho của sản phẩm có product_id = ‘P002’ thành 3
UPDATE Product
SET stock = 3
WHERE product_id = 'P002';

-- Cập nhật tên danh mục ‘Thời trang’ thành ‘Thời trang & Phụ kiện’
UPDATE Category
SET name = 'Thời trang & Phụ kiện'
WHERE name = 'Thời trang';

SELECT * FROM Product WHERE product_id = 'P002';
SELECT * FROM Category WHERE name LIKE '%Phụ kiện%';

-- Xóa danh mục có tên là ‘Sách’ 
DELETE FROM Category
WHERE name = 'Sách';
