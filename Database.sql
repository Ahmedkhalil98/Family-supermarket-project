-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 05, 2022 at 03:12 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `grocery_delivery_storage_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `imageurl` mediumtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `showToUser` varchar(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `title`, `imageurl`, `showToUser`) VALUES
(1, 'Vegetables ', 'vegetables.jpg', '1'),
(2, 'Fruits', 'fruit.jpg', '1'),
(3, 'Drinks', 'drinks.jpeg', '1'),
(4, 'Baby Care', 'babycare.jpg', '1'),
(5, 'Baked goods', 'baked goods.jpg', '1'),
(6, 'Canned food', 'canned food.jpg', '1'),
(7, 'Eggs and Milk', 'Eggsandmilk.jpg', '1'),
(8, 'Frozen Foods', 'frozen foods.jpg', '1'),
(9, 'Grains', 'grains.jpg', '1'),
(10, 'Nuts and Snacks', 'Nuts and Snacks.jpg', '1');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `passcode` int(11) NOT NULL,
  `orderItems` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userLocation` text NOT NULL,
  `userId` varchar(255) NOT NULL,
  `userLatLng` varchar(255) NOT NULL,
  `userPhone` varchar(255) NOT NULL,
  `dateTime` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`passcode`, `orderItems`, `userLocation`, `userId`, `userLatLng`, `userPhone`, `dateTime`, `state`) VALUES
(31, '[\"{\"product\":{\"id\":\"4\",\"title\":\"ginger\",\"imageurl\":\"ginger.png\",\"price\":\"2500\",\"unit\":\"kg\",\"unitsize\":\"13\"},\"quantity\":2}\", \"{\"product\":{\"id\":\"5\",\"title\":\"banana\",\"imageurl\":\"bananas.png\",\"price\":\"2000\",\"unit\":\"kg\",\"unitsize\":\"35\"},\"quantity\":1}\"]', 'دهوك محافظة, سميل, بجركي دوميز, QVMJ+835، بجركي دوميز، العراق', 'olXXZaJaJzW5InedgGTHChQrUnw2', '36.84719443121472, 43.019315200083895', '07503456789', '9/5/2022 3:00 PM', 'pending');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `imageurl` text NOT NULL,
  `price` double NOT NULL,
  `unit` varchar(255) NOT NULL,
  `unitsize` varchar(255) NOT NULL,
  `typeId` int(11) NOT NULL,
  `showToUser` varchar(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `title`, `imageurl`, `price`, `unit`, `unitsize`, `typeId`, `showToUser`) VALUES
(1, 'Tomatoes', 'tomatoes.png', 1000, 'kg', '25', 43, '1'),
(2, 'Potato', 'potato.png', 1500, 'kg', '40', 43, '1'),
(3, 'pepper', 'pepper.png', 1750, 'kg', '15', 43, '1'),
(4, 'ginger', 'ginger.png', 2500, 'kg', '13', 43, '1'),
(5, 'banana', 'bananas.png', 2000, 'kg', '35', 44, '1'),
(6, 'apples', 'apples.png', 2750, 'kg', '35', 44, '1'),
(7, 'cherry', 'cherry.png', 2750, 'kg', '30', 44, '1'),
(8, 'Orange juice', 'juice_orange.png', 1000, 'L', '1', 4, '1'),
(9, 'Apple juice', 'juice_apple.png', 1000, 'L', '1', 4, '1'),
(10, 'Pepsi', 'pepsi.png', 500, 'ml', '250', 6, '1'),
(11, 'Sprite', 'sprite.png', 500, 'ml', '250', 6, '1'),
(12, 'Coca-cola', 'coca_cola.png', 500, 'ml', '250', 6, '1'),
(13, 'cola-diet', 'cola_diet.png', 500, 'ml', '250', 6, '1'),
(14, 'Coca Cola', 'cocacola6.png', 3000, 'ml', '6 x 500', 6, '1'),
(15, 'Coca Cola big', 'cocacolabig.png', 1250, 'L', '1', 6, '1'),
(16, 'Fanta', 'fanta.png', 1250, 'L', '1.5', 4, '1'),
(17, 'Justeau water', 'justeau water.png', 3500, 'L', '15', 3, '1'),
(18, 'Mqnster ', 'mqnster.png', 1000, 'ml', '500', 5, '1'),
(19, 'Nestle Pure Life', 'nestle pure life.png', 1500, 'L', '6 x 1', 3, '1'),
(20, 'No Sugar Added', 'nosugaradded.jpg', 1000, 'ml', '500', 2, '1'),
(21, 'Nougat', 'nougat.png', 1000, 'ml', '500', 2, '1'),
(22, 'Red Bull', 'redbull.png', 1000, 'ml', '500', 5, '1'),
(23, 'Vanilla', 'vanilla.png', 1000, 'ml', '500', 2, '1');

-- --------------------------------------------------------

--
-- Table structure for table `sliders`
--

CREATE TABLE `sliders` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `imageurl` text NOT NULL,
  `showToUser` varchar(255) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sliders`
--

INSERT INTO `sliders` (`id`, `title`, `imageurl`, `showToUser`) VALUES
(1, '50%ff', 'slider1.jpg', '1'),
(2, '20%gggg', 'slider2.jpg', '1');

-- --------------------------------------------------------

--
-- Table structure for table `types`
--

CREATE TABLE `types` (
  `id` int(11) NOT NULL,
  `typeName` varchar(255) NOT NULL,
  `categoryId` int(11) NOT NULL,
  `showToUser` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `types`
--

INSERT INTO `types` (`id`, `typeName`, `categoryId`, `showToUser`) VALUES
(1, 'Tea', 3, 1),
(2, 'coffee', 3, 1),
(3, 'Water', 3, 1),
(4, 'Juices', 3, 1),
(5, 'Energy drinks', 3, 1),
(6, 'Soft drinks', 3, 1),
(7, 'Diapers', 4, 1),
(8, 'Baby milk', 4, 1),
(9, 'Baby food', 4, 1),
(10, 'child\'s needs', 4, 1),
(11, 'Sweets', 5, 1),
(12, 'Bread and Samon', 5, 1),
(13, 'Jam and honey', 6, 1),
(14, 'Ketchup and hot sauces', 6, 1),
(15, 'canned fish', 6, 1),
(16, 'Tomato paste', 6, 1),
(17, 'oil', 6, 1),
(18, 'olive oil', 6, 1),
(19, 'egg', 7, 1),
(20, 'cream', 7, 1),
(21, 'milk', 7, 1),
(22, 'Cheese', 7, 1),
(27, 'rice and bulgur', 9, 1),
(28, 'salt and spices', 9, 1),
(29, 'Indomie and pasta', 9, 1),
(30, 'legumes', 9, 1),
(31, 'soup', 9, 1),
(32, 'flour and sugar', 9, 1),
(33, 'dish washing', 11, 1),
(34, 'Washing clothes', 11, 1),
(35, 'glass cleaner', 11, 1),
(36, 'bags', 11, 1),
(37, 'Military cleaning', 11, 1),
(38, 'Insecticide', 11, 1),
(39, 'Nuts', 10, 1),
(40, 'Chewing gum', 10, 1),
(41, 'Gypsum', 10, 1),
(42, 'Biscuit', 10, 1),
(43, 'vegetables', 1, 1),
(51, 'fruits', 2, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`passcode`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sliders`
--
ALTER TABLE `sliders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `types`
--
ALTER TABLE `types`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `passcode` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `sliders`
--
ALTER TABLE `sliders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `types`
--
ALTER TABLE `types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
