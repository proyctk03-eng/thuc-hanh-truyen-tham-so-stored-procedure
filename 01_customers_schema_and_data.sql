-- =============================================================================
-- BÀI THỰC HÀNH: TRUYỀN THAM SỐ VÀO STORED PROCEDURE
-- File: 01_customers_schema_and_data.sql
-- Mô tả: Khởi tạo CSDL classicmodels, bảng customers và nạp dữ liệu mẫu
-- =============================================================================

CREATE DATABASE IF NOT EXISTS classicmodels CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE classicmodels;

-- 1. Xóa bảng customers nếu đã tồn tại
DROP TABLE IF EXISTS customers;

-- 2. Tạo cấu trúc bảng customers
CREATE TABLE customers (
    customerNumber INT NOT NULL,
    customerName VARCHAR(50) NOT NULL,
    contactLastName VARCHAR(50) NOT NULL,
    contactFirstName VARCHAR(50) NOT NULL,
    phone VARCHAR(50) NOT NULL,
    addressLine1 VARCHAR(50) NOT NULL,
    addressLine2 VARCHAR(50) DEFAULT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) DEFAULT NULL,
    postalCode VARCHAR(15) DEFAULT NULL,
    country VARCHAR(50) NOT NULL,
    salesRepEmployeeNumber INT DEFAULT NULL,
    creditLimit DECIMAL(10,2) DEFAULT NULL,
    PRIMARY KEY (customerNumber)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. Chèn tập dữ liệu mẫu chuẩn (bao gồm khách hàng số 175 và nhiều khách hàng tại thành phố 'Lyon')
INSERT INTO customers (customerNumber, customerName, contactLastName, contactFirstName, phone, addressLine1, addressLine2, city, state, postalCode, country, salesRepEmployeeNumber, creditLimit) VALUES
(103, 'Atelier graphique', 'Schmitt', 'Carine', '40.32.2555', '54, rue Royale', NULL, 'Nantes', NULL, '44000', 'France', 1370, 21000.00),
(112, 'Signal Gift Stores', 'King', 'Jean', '7025551838', '8489 Strong St.', NULL, 'Las Vegas', 'NV', '83030', 'USA', 1166, 71800.00),
(114, 'Ferguson Antique Cars', 'Ferguson', 'Peter', '03 9520 4555', '636 St Kilda Road', 'Level 3', 'Melbourne', 'Victoria', '3004', 'Australia', 1611, 65800.00),
(119, 'La Rochelle Gifts', 'Labrune', 'Janine', '40.67.8555', '67, rue des Cinquante Otages', NULL, 'Nantes', NULL, '44000', 'France', 1370, 118200.00),
(121, 'Baane Mini Imports', 'Bergulfsen', 'Jonas', '07-98 9555', 'Erling Skakkes gate 78', NULL, 'Stavern', NULL, '4110', 'Norway', 1504, 81700.00),
(124, 'Mini Gifts Distributors Ltd.', 'Nelson', 'Susan', '4155551450', '5677 Strong St.', NULL, 'San Rafael', 'CA', '97562', 'USA', 1165, 210500.00),
(131, 'Land of Toys Inc.', 'Yu', 'Kwai', '2125557818', '897 Long Airport Avenue', NULL, 'NYC', 'NY', '10022', 'USA', 1323, 114900.00),
(141, 'Euro+ Shopping Channel', 'Freyre', 'Diego', '(91) 555 94 44', 'C/ Moralzarzal, 86', NULL, 'Madrid', NULL, '28034', 'Spain', 1370, 227600.00),
(146, 'Saveley & Henriot, Co.', 'Saveley', 'Mary', '78.32.5555', '2, rue du Commerce', NULL, 'Lyon', NULL, '69004', 'France', 1337, 123900.00),
(151, 'Muscle Machine Inc', 'Simpson', 'Allen', '2125552345', '798 West Road', NULL, 'NYC', 'NY', '10022', 'USA', 1286, 138500.00),
(166, 'Handtkopen Shopping Imports', 'King', 'Jean', '+31 71 5236155', 'Bredavägen 7', NULL, 'Leiden', NULL, '2300 AA', 'Netherlands', 1504, 97900.00),
(175, 'Cambridge Collectables Co.', 'Tseng', 'Jerry', '6175555555', '4658 Baden Av.', NULL, 'Cambridge', 'MA', '51247', 'USA', 1188, 43400.00),
(181, 'Vitachrome Inc.', 'Frick', 'Michael', '2125551500', '2678 Kingston Rd.', 'Suite 101', 'NYC', 'NY', '10022', 'USA', 1286, 76400.00),
(186, 'Volvo Model Replicas, Co', 'Berglund', 'Christina', '0921-12 355', 'Berguvsvägen  8', NULL, 'Luleå', NULL, 'S-958 22', 'Sweden', 1504, 53100.00),
(187, 'AV Stores, Co.', 'Ashworth', 'Rachel', '(171) 555-1555', 'Fauntleroy Circus', NULL, 'Manchester', NULL, 'EC2 5NT', 'UK', 1501, 136800.00),
(198, 'Auto-Moto Classics', 'Perrier', 'Dominique', '78.32.5555', '12, rue de la République', NULL, 'Lyon', NULL, '69002', 'France', 1337, 85000.00),
(201, 'UK Collectables, Ltd.', 'Edwards', 'Latifah', '(171) 555-2282', '12, Berkeley Gardens', 'Boulevard', 'Liverpool', NULL, 'WX1 6LT', 'UK', 1501, 92700.00),
(202, 'Lyon Miniatures', 'Da Silva', 'Daniel', '78.32.7777', '45, cours Lafayette', NULL, 'Lyon', NULL, '69003', 'France', 1337, 68000.00);
