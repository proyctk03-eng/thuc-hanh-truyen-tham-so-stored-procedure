-- =============================================================================
-- BÀI THỰC HÀNH: TRUYỀN THAM SỐ VÀO STORED PROCEDURE
-- File: 02_stored_procedure_parameters.sql
-- Mô tả: Cú pháp tạo và gọi thủ tục lưu trữ với 3 loại tham số: IN, OUT, INOUT
-- =============================================================================

USE classicmodels;

-- =============================================================================
-- PHẦN 1: THAM SỐ LOẠI IN (INPUT PARAMETER)
-- - IN là chế độ mặc định nếu không khai báo loại tham số.
-- - Giá trị được truyền từ bên ngoài vào bên trong Procedure và chỉ dùng để đọc/lọc.
-- - Mọi thay đổi đối với biến IN bên trong Procedure sẽ KHÔNG ảnh hưởng ra bên ngoài.
-- =============================================================================

DROP PROCEDURE IF EXISTS getCusById;

DELIMITER //

CREATE PROCEDURE getCusById (
    IN cusNum INT
)
BEGIN
    -- Lấy toàn bộ thông tin khách hàng có mã tương ứng với tham số cusNum
    SELECT * 
    FROM customers 
    WHERE customerNumber = cusNum;
END //

DELIMITER ;

-- Gọi thủ tục getCusById với mã khách hàng 175:
CALL getCusById(175);

-- Thử nghiệm gọi với mã khách hàng khác (ví dụ: 103):
CALL getCusById(103);


-- =============================================================================
-- PHẦN 2: THAM SỐ LOẠI OUT (OUTPUT PARAMETER)
-- - Tham số OUT dùng để nhận giá trị được tính toán từ trong Procedure trả ra ngoài.
-- - Giá trị ban đầu của biến truyền vào luôn được coi là NULL (kể cả khi đã gán trước).
-- - Sử dụng cú pháp `SELECT ... INTO tên_biến_out` để gán giá trị trả về.
-- - Khi gọi, phải truyền vào một biến phiên (session variable) có tiền tố '@'.
-- =============================================================================

DROP PROCEDURE IF EXISTS GetCustomersCountByCity;

DELIMITER //

CREATE PROCEDURE GetCustomersCountByCity (
    IN  in_city VARCHAR(50),
    OUT total INT
)
BEGIN
    -- Đếm số lượng khách hàng thuộc thành phố in_city và gán vào biến OUT total
    SELECT COUNT(customerNumber)
    INTO total
    FROM customers
    WHERE city = in_city;
END //

DELIMITER ;

-- Gọi thủ tục GetCustomersCountByCity tìm số khách hàng tại thành phố 'Lyon':
CALL GetCustomersCountByCity('Lyon', @total);

-- Xem kết quả được trả ra biến @total:
SELECT @total AS TotalCustomersInLyon;

-- Thử nghiệm gọi với thành phố 'NYC':
CALL GetCustomersCountByCity('NYC', @total_nyc);
SELECT @total_nyc AS TotalCustomersInNYC;


-- =============================================================================
-- PHẦN 3: THAM SỐ LOẠI INOUT (INPUT/OUTPUT PARAMETER)
-- - INOUT là sự kết hợp giữa IN và OUT:
--   + Vừa nhận giá trị truyền vào ban đầu từ bên ngoài (như IN).
--   + Vừa cho phép Procedure thay đổi và lưu lại giá trị mới ra bên ngoài (như OUT).
-- - Hoạt động tương tự như truyền tham chiếu (pass by reference).
-- =============================================================================

DROP PROCEDURE IF EXISTS SetCounter;

DELIMITER //

CREATE PROCEDURE SetCounter (
    INOUT counter INT,
    IN    inc INT
)
BEGIN
    -- Tăng giá trị của counter lên thêm inc đơn vị
    SET counter = counter + inc;
END //

DELIMITER ;

-- Khởi tạo biến đếm ban đầu là 1
SET @counter = 1;

-- Lần gọi 1: Tăng thêm 1 => @counter trở thành 2
CALL SetCounter(@counter, 1);
SELECT @counter AS Counter_After_Step1; -- Kết quả: 2

-- Lần gọi 2: Tăng tiếp 1 => @counter trở thành 3
CALL SetCounter(@counter, 1);
SELECT @counter AS Counter_After_Step2; -- Kết quả: 3

-- Lần gọi 3: Tăng thêm 5 => @counter trở thành 8
CALL SetCounter(@counter, 5);
SELECT @counter AS Counter_After_Step3; -- Kết quả: 8

-- Xem giá trị cuối cùng của biến @counter
SELECT @counter AS FinalCounter; -- Kết quả: 8
