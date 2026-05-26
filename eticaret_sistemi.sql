-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Anamakine: mysql_db
-- Üretim Zamanı: 26 May 2026, 18:38:24
-- Sunucu sürümü: 8.0.46
-- PHP Sürümü: 8.3.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `eticaret_sistemi`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `categories`
--

CREATE TABLE `categories` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text,
  `is_active` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`, `is_active`) VALUES
(1, 'Teknoloji', 'Bilgisayar, telefon ve aksesuarlar', 1),
(2, 'Moda', 'Giyim, ayakkabı ve çanta ürünleri', 1),
(3, 'Ev & Yaşam', 'Ev dekorasyonu ve mutfak gereçleri', 1),
(4, 'Kitap', 'Roman, eğitim ve hobi kitapları', 1);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `orders`
--

CREATE TABLE `orders` (
  `id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `order_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `total_amount` decimal(10,2) NOT NULL,
  `status` varchar(50) DEFAULT 'Beklemede',
  `shipping_address` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `order_date`, `total_amount`, `status`, `shipping_address`) VALUES
(1, 2, '2026-05-18 21:51:37', 117000.00, 'Hazırlanıyor', '123'),
(2, 2, '2026-05-18 21:55:39', 42000.00, 'Hazırlanıyor', '1'),
(3, 2, '2026-05-18 22:01:02', 75000.00, 'Kargoya Verildi', 'e'),
(4, 2, '2026-05-19 18:11:33', 75000.00, 'Kargoya Verildi', 'r'),
(5, 1, '2026-05-19 20:38:06', 177.00, 'Teslim Edildi', 'n'),
(6, 1, '2026-05-26 15:24:00', 198.00, 'Hazırlanıyor', 'm');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `order_items`
--

CREATE TABLE `order_items` (
  `id` int NOT NULL,
  `order_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `unit_price`, `subtotal`) VALUES
(1, 1, 2, 1, 42000.00, 42000.00),
(2, 1, 1, 1, 75000.00, 75000.00),
(3, 2, 2, 1, 42000.00, 42000.00),
(4, 3, 1, 1, 75000.00, 75000.00),
(5, 4, 1, 1, 75000.00, 75000.00),
(6, 5, 10, 1, 159.00, 159.00),
(7, 5, 9, 1, 12.00, 12.00),
(8, 5, 11, 1, 6.00, 6.00),
(9, 6, 21, 2, 99.00, 198.00);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `products`
--

CREATE TABLE `products` (
  `id` int NOT NULL,
  `category_id` int DEFAULT NULL,
  `name` varchar(150) NOT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `stock` int NOT NULL DEFAULT '0',
  `image_url` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `category` varchar(100) NOT NULL DEFAULT 'Genel'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `products`
--

INSERT INTO `products` (`id`, `category_id`, `name`, `description`, `price`, `stock`, `image_url`, `is_active`, `created_at`, `category`) VALUES
(1, 1, 'iPhone 15 Pro', '256GB, Titanyum kasa akıllı telefon', 75000.00, 8, 'https://placehold.co/400x400?text=iPhone+15', 0, '2026-05-13 18:48:22', 'Genel'),
(2, 2, 'MacBook Air M2', '8GB RAM, 256GB SSD, Uzay Grisi', 42000.00, 3, 'https://placehold.co/400x400?text=MacBook', 0, '2026-05-13 18:48:22', 'Genel'),
(3, 2, 'Gaming Laptop', 'RTX 4060 Ekran Kartı, 16GB RAM', 38500.00, 0, 'https://placehold.co/400x400?text=Gaming+Laptop', 0, '2026-05-13 18:48:22', 'Genel'),
(4, 3, 'Logitech MX Master 3S', 'Ergonomik kablosuz ofis mouse', 4200.00, 25, 'https://placehold.co/400x400?text=Mouse', 0, '2026-05-13 18:48:22', 'Genel'),
(5, 3, 'Bluetooth Kulaklık', 'Gürültü engelleyici özellikli', 3500.00, 15, 'https://placehold.co/400x400?text=Kulaklik', 0, '2026-05-13 18:48:22', 'Genel'),
(6, 4, 'Java MVC Rehberi', 'Adım adım Java web geliştirme', 450.00, 50, 'https://placehold.co/400x400?text=Java+Kitabi', 0, '2026-05-13 18:48:22', 'Genel'),
(7, NULL, 'deneme', NULL, 23.00, 33, NULL, 0, '2026-05-18 21:18:10', 'Genel'),
(8, NULL, 'llll', NULL, 4.00, 4, NULL, 0, '2026-05-18 21:18:28', 'Genel'),
(9, NULL, 'ağaç', NULL, 12.00, 11, 'images/agac.png', 0, '2026-05-18 21:37:38', 'Genel'),
(10, NULL, 'kalemlik', NULL, 159.00, 9, 'images/ana_goruntu.png', 0, '2026-05-19 18:48:59', 'Ev & Yaşam'),
(11, NULL, 'nn', NULL, 6.00, 8, 'images/default.jpg', 0, '2026-05-19 19:04:47', 'Elektronik'),
(12, NULL, 'Ipone 17', NULL, 10000.00, 10, 'images/Ekran Görüntüsü - 2026-05-26 01-32-56.png', 0, '2026-05-25 22:36:03', 'Elektronik'),
(13, NULL, ' Ipone 17', NULL, 70000.00, 10, 'images/Ekran Görüntüsü - 2026-05-26 01-51-17.png', 0, '2026-05-25 22:52:49', 'Elektronik'),
(14, NULL, 'Ipone 17', NULL, 70000.00, 10, 'images/Ekran Görüntüsü - 2026-05-26 01-53-14.png', 0, '2026-05-25 22:55:00', 'Elektronik'),
(15, NULL, 'Ipone 17', NULL, 70000.00, 10, 'images/Ekran Görüntüsü - 2026-05-26 01-53-14.png', 1, '2026-05-25 22:59:14', 'Elektronik'),
(16, NULL, 'MacBook', NULL, 50000.00, 10, 'images/v2-74024-2_large.jpg', 1, '2026-05-25 23:00:50', 'Elektronik'),
(17, NULL, 'Kalemlik', NULL, 100.00, 20, 'images/Ekran Görüntüsü - 2026-05-26 02-01-32.png', 1, '2026-05-25 23:02:07', 'Diğer'),
(18, NULL, '1984', NULL, 150.00, 30, 'images/1984.webp', 1, '2026-05-25 23:03:19', 'Kitap'),
(19, NULL, 'Şapka', NULL, 199.90, 4, 'images/Ekran Görüntüsü - 2026-05-26 02-04-19.png', 1, '2026-05-25 23:04:56', 'Giyim'),
(20, NULL, 'Gömlek', NULL, 299.00, 9, 'images/Ekran Görüntüsü - 2026-05-26 18-19-45.png', 1, '2026-05-26 15:20:19', 'Giyim'),
(21, NULL, 'Alamut Kalesi', NULL, 99.00, 10, 'images/Ekran Görüntüsü - 2026-05-26 18-21-31.png', 1, '2026-05-26 15:21:58', 'Kitap'),
(22, NULL, 'Sehpa', NULL, 899.90, 5, 'images/Ekran Görüntüsü - 2026-05-26 18-23-03.png', 1, '2026-05-26 15:23:29', 'Ev & Yaşam'),
(23, NULL, 'Masa Lambası', NULL, 380.00, 7, 'images/Ekran Görüntüsü - 2026-05-26 18-24-47.png', 1, '2026-05-26 15:25:12', 'Ev & Yaşam'),
(24, NULL, 'deneme', NULL, 2.00, 2, 'images/default.jpg', 0, '2026-05-26 15:29:16', 'Genel');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text,
  `role` varchar(20) DEFAULT 'CUSTOMER',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `users`
--

INSERT INTO `users` (`id`, `full_name`, `email`, `password`, `phone`, `address`, `role`, `created_at`) VALUES
(1, 'Burak Bayrak', 'root@gmail.com', 'root', '5060980019', 'çorum\r\n', 'admin', '2026-05-13 21:53:24'),
(2, 'Burak Bayrak', 'root1@gmail.com', 'root', '5060980019', 'q', 'customer', '2026-05-18 21:46:23');

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Tablo için indeksler `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Tablo için indeksler `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Tablo için indeksler `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Tablo için AUTO_INCREMENT değeri `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Tablo için AUTO_INCREMENT değeri `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Tablo için AUTO_INCREMENT değeri `products`
--
ALTER TABLE `products`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- Tablo için AUTO_INCREMENT değeri `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Tablo kısıtlamaları `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Tablo kısıtlamaları `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
