# [Thực hành] Truyền Tham Số Vào Stored Procedure Trong MySQL

## 📌 Giới Thiệu & Mục Tiêu

Thủ tục lưu trữ (**Stored Procedure**) là một tập hợp các câu lệnh SQL được biên dịch sẵn và lưu trữ trực tiếp trên Database Server. Việc truyền tham số vào Stored Procedure giúp tăng tính linh hoạt, khả năng tái sử dụng mã nguồn và bảo mật dữ liệu (chống SQL Injection).

### 🎯 Mục tiêu bài học:
- **Hiểu rõ bản chất 3 loại tham số trong MySQL**: `IN`, `OUT` và `INOUT`.
- **Thành thạo cú pháp định nghĩa Procedure**: Sử dụng `DELIMITER //`, `CREATE PROCEDURE`, `BEGIN ... END`.
- **Cách thức gọi và xử lý dữ liệu trả về**: Khởi tạo và sử dụng các biến phiên (`@variable`) để nhận kết quả từ tham số `OUT` và `INOUT`.

---

## 📊 So Sánh 3 Loại Tham Số Trong Stored Procedure

| Đặc điểm | Tham số `IN` (Mặc định) | Tham số `OUT` | Tham số `INOUT` |
| :--- | :--- | :--- | :--- |
| **Chiều truyền dữ liệu** | Từ ngoài **vào** Procedure (Input) | Từ Procedure **ra** ngoài (Output) | **Hai chiều**: Vào và Ra (Input & Output) |
| **Giá trị ban đầu** | Nhận giá trị được truyền vào từ bên ngoài | Luôn được khởi tạo là `NULL` | Nhận giá trị khởi tạo ban đầu từ bên ngoài |
| **Tác động ra bên ngoài** | Không thay đổi giá trị ban đầu bên ngoài | Ghi đè giá trị mới vào biến truyền vào | Ghi đè giá trị mới đã được biến đổi vào biến |
| **Cú pháp gọi** | Truyền giá trị trực tiếp hoặc biến: `CALL proc(175)` | Bắt buộc truyền biến có dấu `@`: `CALL proc('Lyon', @total)` | Bắt buộc truyền biến có dấu `@`: `CALL proc(@counter, 1)` |
| **Mục đích sử dụng** | Truyền điều kiện lọc `WHERE`, giá trị tính toán | Trả về kết quả tổng hợp, mã trạng thái, ID | Tăng/giảm bộ đếm, cập nhật tích lũy chuỗi |

---

## 🔬 Chi Tiết 3 Kịch Bản Thực Hành

### 1. Tham số loại `IN` (Lấy thông tin khách hàng theo mã)
- **Đặc điểm**: Chỉ nhận dữ liệu đầu vào để thực hiện câu truy vấn `WHERE`.
```sql
DELIMITER //

CREATE PROCEDURE getCusById (
    IN cusNum INT
)
BEGIN
    SELECT * 
    FROM customers 
    WHERE customerNumber = cusNum;
END //

DELIMITER ;
```
- **Cách gọi**:
```sql
CALL getCusById(175);
```
- **Kết quả**: Trả về tập bản ghi của khách hàng có `customerNumber = 175` (`Cambridge Collectables Co.`).

---

### 2. Tham số loại `OUT` (Đếm số lượng khách hàng theo thành phố)
- **Đặc điểm**: Nhận tên thành phố (`IN`) và xuất kết quả tính toán đếm số khách hàng ra biến ngoại vi (`OUT`).
```sql
DELIMITER //

CREATE PROCEDURE GetCustomersCountByCity (
    IN  in_city VARCHAR(50),
    OUT total INT
)
BEGIN
    SELECT COUNT(customerNumber)
    INTO total
    FROM customers
    WHERE city = in_city;
END //

DELIMITER ;
```
- **Cách gọi**:
```sql
-- Khởi tạo biến @total và truyền vào vị trí OUT
CALL GetCustomersCountByCity('Lyon', @total);

-- Đọc giá trị kết quả được lưu vào biến @total
SELECT @total AS TotalCustomersInLyon;
```
- **Kết quả**: Trả về số lượng khách hàng tại Lyon (`3` khách hàng: *Saveley & Henriot*, *Auto-Moto Classics*, *Lyon Miniatures*).

---

### 3. Tham số loại `INOUT` (Bộ đếm tích lũy - Counter)
- **Đặc điểm**: Biến `@counter` vừa mang giá trị đầu vào để tăng thêm một lượng `inc`, vừa lưu giữ giá trị mới sau mỗi lần thực thi.
```sql
DELIMITER //

CREATE PROCEDURE SetCounter (
    INOUT counter INT,
    IN    inc INT
)
BEGIN
    SET counter = counter + inc;
END //

DELIMITER ;
```
- **Cách gọi & Quá trình biến đổi giá trị**:
```sql
-- 1. Khởi tạo giá trị ban đầu là 1
SET @counter = 1;

-- 2. Lần gọi 1: tăng thêm 1 => @counter = 2
CALL SetCounter(@counter, 1);

-- 3. Lần gọi 2: tăng tiếp 1 => @counter = 3
CALL SetCounter(@counter, 1);

-- 4. Lần gọi 3: tăng thêm 5 => @counter = 8
CALL SetCounter(@counter, 5);

-- 5. Đọc giá trị sau cùng
SELECT @counter AS FinalCounter; -- Kết quả: 8
```

---

## 🚀 Hướng Dẫn Chạy Script

1. **Khởi tạo cơ sở dữ liệu và nạp dữ liệu mẫu**:
   ```bash
   mysql -u root -p < 01_customers_schema_and_data.sql
   ```
2. **Thực thi các stored procedure và kiểm tra kết quả**:
   ```bash
   mysql -u root -p classicmodels < 02_stored_procedure_parameters.sql
   ```
