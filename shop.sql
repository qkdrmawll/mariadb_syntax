
CREATE TABLE `customer` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `created_time` datetime DEFAULT current_timestamp(),
  `modified_time` datetime DEFAULT current_timestamp(),
  `del_yn` char(1) DEFAULT 'n',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
)

CREATE TABLE `orders` (
  `id` bigint(20) NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  `status` enum('PAID','DELIVERING','CALCLE','DELIVERED') DEFAULT 'PAID',
  `created_time` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`)
) 

CREATE TABLE `seller` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `created_time` datetime DEFAULT current_timestamp(),
  `modified_time` datetime DEFAULT current_timestamp(),
  `del_yn` char(1) DEFAULT 'n',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) 

CREATE TABLE `item` (
  `id` bigint(20) NOT NULL,
  `seller_id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL UNIQUE,
  `stock` int(11) NOT NULL,
  `created_time` datetime DEFAULT current_timestamp(),
  `modified_time` datetime DEFAULT current_timestamp(),
  `del_yn` char(1) DEFAULT 'n',
  PRIMARY KEY (`id`),
  KEY `seller_id` (`seller_id`),
  CONSTRAINT `item_ibfk_1` FOREIGN KEY (`seller_id`) REFERENCES `seller` (`id`)
) 

CREATE TABLE `order_details` (
  `id` bigint(20) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `item_id` bigint(20) NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_details_fk1` (`order_id`),
  KEY `order_details_fk2` (`item_id`),
  CONSTRAINT `order_details_fk1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `order_details_fk2` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci

CREATE TABLE `address` (
  `id` bigint(20) NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  `address` varchar(255) NOT NULL,
  `zip_code` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `address_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`)
)

CREATE TABLE `shipment` (
  `id` bigint(20) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `delivery_address` varchar(255) NOT NULL,
  `start_date` date DEFAULT NULL,
  `complete_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `shipment_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci

-- 회원가입
DELIMITER //
CREATE PROCEDURE 회원가입(in 이메일 varchar(255), in 비밀번호 varchar(255), in 이름 varchar(255))
BEGIN
    insert into customer(name, email, password) values(이름, 이메일, 비밀번호);
END
// DELIMITER ;
-- 판매 등록
DELIMITER //
CREATE PROCEDURE 판매자등록(in 이메일 varchar(255), in 비밀번호 varchar(255), in 이름 varchar(255))
BEGIN
    insert into seller(name, email, password) values(이름, 이메일, 비밀번호);
END
// DELIMITER ;
-- 상품 조회
DELIMITER //
CREATE PROCEDURE 상품조회(in 상품아이디 int)
BEGIN
	SELECT i.name as 상품명, i.stock as 재고, i.price as 가격, s.name as 판매자 from item i inner join seller s on i.seller_id = s.id WHERE id = 상품아이디;
END;
// DELIMITER ;
-- 주소지 등록
INSERT into address (customer_id,address,zip_code) values(1,'seoul dongjak','08327');
-- 주문 생성 
INSERT into orders(customer_id) values(1);
-- 주문 상세 생성
INSERT into order_details (item_id,quantity,order_id) values(1,1,1);
-- 배송 생성
INSERT into shipment (order_id, delivery_address) values (1,(select a.address from customer c inner join address a on a.customer_id = c.id where 
(SELECT c.id from orders o inner join customer c on o.customer_id = c.id WHERE o.id= 1)));
-- 주문 내역 조회
SELECT i.name, CONCAT( od.quantity, '개')  from order_details od inner join item i ON od.item_id = i.id  WHERE od.order_id = 1;

