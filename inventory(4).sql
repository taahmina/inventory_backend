-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 03, 2025 at 07:46 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `inventory`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `description` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `created_at`, `updated_at`, `description`) VALUES
(6, 'Grocery', '2025-11-01 00:31:31', '2025-11-01 00:40:35', 'Daily grocery items'),
(7, 'Bakery', '2025-11-01 00:31:53', '2025-11-01 00:40:20', 'Breads, cakes, and pastries'),
(8, 'Dairy', '2025-11-01 00:40:53', '2025-11-01 00:40:53', 'Milk, cheese, and butter'),
(9, 'Beverages', '2025-11-01 00:41:11', '2025-11-01 00:41:11', 'Soft drinks and juices'),
(10, 'Fresh Produce', '2025-11-01 00:41:27', '2025-11-01 00:41:27', 'Fruits and vegetables'),
(11, 'Household Items', '2025-11-01 00:41:57', '2025-11-01 00:41:57', 'Cleaning and utility items'),
(12, 'Personal Care', '2025-11-01 00:42:16', '2025-11-01 00:42:16', 'Health & beauty products');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `name`, `email`, `phone`, `address`, `created_at`, `updated_at`) VALUES
(3, 'Mehedi Hasan', 'mehedi@gmail.com', '01811-111111', 'Mirpur, Dhaka', '2025-11-01 00:28:25', '2025-11-01 00:28:25'),
(4, 'Nusrat Jahan', 'nusrat@yahoo.com', '01812-222222', 'Uttara, Dhaka', '2025-11-01 00:29:09', '2025-11-01 00:29:09'),
(5, 'Sharmin Akter', 'sharmin@live.com', '01814-444444', 'Dhanmondi, Dhaka', '2025-11-01 00:29:53', '2025-11-01 00:29:53');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `position` varchar(255) DEFAULT NULL,
  `salary` decimal(10,2) NOT NULL DEFAULT 0.00,
  `joining_date` date DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `profile_photo` varchar(255) DEFAULT NULL,
  `termination_date` date DEFAULT NULL,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`id`, `name`, `email`, `phone`, `address`, `position`, `salary`, `joining_date`, `status`, `created_at`, `updated_at`, `username`, `password`, `profile_photo`, `termination_date`, `notes`) VALUES
(3, 'shompa', 'sm@yahoo.com', '0181-32542', 'chittagong', 'cashier', 20000.00, '2025-11-01', 1, '2025-11-02 00:11:15', '2025-11-03 00:40:49', 'shompa', '$2y$12$I.SZ5DGzg3N8ieNAyZIHluZlp1EzAAO7U/NgZNCh/bV22ft1/zcqq', 'uploads/employees/1762063875_chat-img1.jpg', '2025-11-01', 'asffdhfg'),
(4, 'sgh', 'sgh@yahoo.com', '236475', 'fhxfhfgjmhb', 'storekeeper', 5643.00, '2025-11-03', 1, '2025-11-03 00:26:08', '2025-11-03 00:41:56', 'bcn', '$2y$12$ene88mz/8o38QgMlt2guMOHzfAbNZE6tS42ZKQctbS56L1MOV8EFK', 'uploads/employees/1762151168_caution-sign.png', NULL, 'fhdhgsfyhtgjkghlyjvhkmvh');

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `expense_date` date NOT NULL,
  `category` varchar(255) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`id`, `expense_date`, `category`, `amount`, `note`, `created_at`, `updated_at`) VALUES
(1, '2025-11-01', 'Rent', 25738.00, 'rrt', '2025-10-31 21:28:15', '2025-10-31 21:28:15'),
(2, '2025-11-03', 'Maintenance', 12312.00, 'gaf', '2025-11-02 00:09:56', '2025-11-02 00:09:56');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inventory_logs`
--

CREATE TABLE `inventory_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `change_type` enum('IN','OUT') NOT NULL,
  `quantity` int(11) NOT NULL,
  `reference_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2025_10_25_032621_create_roles_table', 1),
(6, '2025_10_25_032820_create_categories_table', 1),
(7, '2025_10_25_032835_create_suppliers_table', 1),
(8, '2025_10_25_032845_create_products_table', 1),
(9, '2025_10_25_032900_create_customers_table', 1),
(10, '2025_10_25_032911_create_orders_table', 1),
(11, '2025_10_25_032923_create_order_items_table', 1),
(12, '2025_10_25_032937_create_inventory_logs_table', 1),
(13, '2025_10_25_035030_add_role_id_to_users_table', 1),
(14, '2025_10_25_035840_create_employees_table', 1),
(15, '2025_10_25_041611_create_purchases_table', 1),
(16, '2025_10_25_041624_create_sales_table', 1),
(17, '2025_10_25_041633_create_expenses_table', 1),
(18, '2025_10_25_041646_create_salary_payments_table', 1),
(19, '2025_10_25_041731_create_settings_table', 1),
(20, '2025_10_26_061815_add_columns_to_products_table', 1),
(21, '2025_10_27_040608_add_extra_columns_to_purchases_table', 1),
(22, '2025_10_27_041500_create_purchase_items_table', 1),
(23, '2025_10_28_050502_remove_price_from_products_table', 1),
(24, '2025_10_28_051149_remove_cost_from_products_table', 1),
(25, '2025_10_28_193038_create_sale_items_table', 2),
(26, '2025_10_28_193910_add_columns_to_sales_table', 3),
(27, '2025_10_29_062151_add_total_price_to_sale_items_table', 4),
(28, '2025_10_30_054637_add_extra_columns_to_employees_table', 5),
(29, '2025_11_01_063449_add_new_column_to_categories_table', 6);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `status` enum('pending','completed','cancelled') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `profit` decimal(10,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'kamal-AuthToken', '7a55293f7b0a5f4b0722352f46e14700faef373bcb167c000df50ca1b7eac5c4', '[\"*\"]', NULL, NULL, '2025-10-28 05:30:37', '2025-10-28 05:30:37'),
(2, 'App\\Models\\User', 1, 'kamal-AuthToken', 'c1c2d6a69c819dad79863ab080d703ea9735f2a9f3ca59b8157e3d5705d279d2', '[\"*\"]', NULL, NULL, '2025-10-28 11:52:39', '2025-10-28 11:52:39'),
(3, 'App\\Models\\User', 1, 'kamal-AuthToken', 'd82cda8c894a98faf438d12c31c503fd716096cec1ba24b209bf306c2a855bfc', '[\"*\"]', NULL, NULL, '2025-10-28 21:46:27', '2025-10-28 21:46:27'),
(4, 'App\\Models\\User', 1, 'kamal-AuthToken', '2722a2114997c841548178bb2e5abb521c1d98360638867c582d790e085b0e3f', '[\"*\"]', NULL, NULL, '2025-10-28 22:51:35', '2025-10-28 22:51:35'),
(5, 'App\\Models\\User', 1, 'kamal-AuthToken', '3e9248ec718dcf962fdc22ea058d25d679a19f20121fb2cf61e779005047b50f', '[\"*\"]', NULL, NULL, '2025-10-29 21:39:10', '2025-10-29 21:39:10'),
(6, 'App\\Models\\User', 1, 'kamal-AuthToken', '81eb469d4c29da7373c4c266a02dc335b9d5a64e23d900bf094ffc07478ebb48', '[\"*\"]', NULL, NULL, '2025-10-31 21:23:20', '2025-10-31 21:23:20'),
(7, 'App\\Models\\User', 1, 'kamal-AuthToken', '911d0624d35b674ce3e4c0b809ebe43aecb5c5b235f1efae6f3484d026e5b042', '[\"*\"]', NULL, NULL, '2025-10-31 22:43:12', '2025-10-31 22:43:12'),
(8, 'App\\Models\\User', 1, 'kamal-AuthToken', '07418ad5a303fde820d7261a7b1862732433a2ed024674aec3883f866b29ab0e', '[\"*\"]', NULL, NULL, '2025-10-31 22:57:26', '2025-10-31 22:57:26'),
(9, 'App\\Models\\User', 1, 'kamal-AuthToken', '5713e41b21b25ee0b3cbae547a17699ec52a9e67d3e9fdc66db137987d11386a', '[\"*\"]', NULL, NULL, '2025-10-31 23:00:53', '2025-10-31 23:00:53'),
(10, 'App\\Models\\User', 1, 'kamal-AuthToken', '4b411c79f89b583f763c12ca97c00ce4ba4b2bc5ed52b921c1d226eb5a3db829', '[\"*\"]', NULL, NULL, '2025-10-31 23:10:47', '2025-10-31 23:10:47'),
(11, 'App\\Models\\User', 1, 'kamal-AuthToken', '8afb307016eb10c32f02bd7a9ce5a9d6bbd1356981143ae2dbca8d5c45fc3073', '[\"*\"]', NULL, NULL, '2025-10-31 23:12:28', '2025-10-31 23:12:28'),
(12, 'App\\Models\\User', 1, 'kamal-AuthToken', '5ef71473dfccfc8418b7482ab02c967d3c768ccd49117eedebabcf53f59024b4', '[\"*\"]', NULL, NULL, '2025-10-31 23:13:46', '2025-10-31 23:13:46'),
(13, 'App\\Models\\User', 1, 'kamal-AuthToken', 'be5ecd2d6c84f7488f444a76e0f476ed301bc2efb3ca36050c80e39bb2f82bd5', '[\"*\"]', NULL, NULL, '2025-10-31 23:15:58', '2025-10-31 23:15:58'),
(14, 'App\\Models\\User', 1, 'kamal-AuthToken', '808dc86e02582cdad1244f34d187166626f20ab23e9f7ab3b2f397e9c580a7e5', '[\"*\"]', NULL, NULL, '2025-10-31 23:16:02', '2025-10-31 23:16:02'),
(15, 'App\\Models\\User', 1, 'kamal-AuthToken', '1468ae81b18e196e81a4ce0d5182b2402073740b4ff9c22e7d245653b3659c19', '[\"*\"]', NULL, NULL, '2025-10-31 23:30:38', '2025-10-31 23:30:38'),
(16, 'App\\Models\\User', 1, 'kamal-AuthToken', 'f78f96c017f2fa8c84906994e843e52625a932011fb6d4252f399c099e412b42', '[\"*\"]', NULL, NULL, '2025-10-31 23:30:50', '2025-10-31 23:30:50'),
(17, 'App\\Models\\User', 1, 'kamal-AuthToken', '60a3942145d5e21198f7daf886ee2bc0f63eab8e7fa6ec8d7381b3a3a74a6a86', '[\"*\"]', NULL, NULL, '2025-10-31 23:31:03', '2025-10-31 23:31:03'),
(18, 'App\\Models\\User', 1, 'kamal-AuthToken', 'c7e2d128e398c2cba90ad8bc8d06660ac7c7dd559410bb33f1e086edb48164be', '[\"*\"]', NULL, NULL, '2025-10-31 23:36:09', '2025-10-31 23:36:09'),
(19, 'App\\Models\\User', 1, 'kamal-AuthToken', 'a344f443e75e2bfaf6859e3a9afcdebedb0227698c34d256b98725b6da606e4b', '[\"*\"]', NULL, NULL, '2025-10-31 23:42:59', '2025-10-31 23:42:59'),
(20, 'App\\Models\\User', 1, 'kamal-AuthToken', '608bc4b2cbfd4931e47e6a376d1d55515918046d2906d727519d71287e83a9b6', '[\"*\"]', NULL, NULL, '2025-11-01 00:05:08', '2025-11-01 00:05:08'),
(21, 'App\\Models\\User', 1, 'kamal-AuthToken', 'ca06c376491d9d5a0a419d7324ef8bc1f22a776d33cb9b9cb53492e545e358ed', '[\"*\"]', NULL, NULL, '2025-11-01 00:05:14', '2025-11-01 00:05:14'),
(22, 'App\\Models\\User', 1, 'kamal-AuthToken', 'e601278cecef6d91260ca885255e1be0c2d56fbda66491af5e129de397e1dbc7', '[\"*\"]', NULL, NULL, '2025-11-01 00:05:28', '2025-11-01 00:05:28'),
(23, 'App\\Models\\User', 1, 'kamal-AuthToken', '5ee76ff78864a44319fdac3be4dfc695533aa72d230cda4d693efe369213be81', '[\"*\"]', NULL, NULL, '2025-11-01 00:05:32', '2025-11-01 00:05:32'),
(24, 'App\\Models\\User', 1, 'kamal-AuthToken', '044e0ad5e099d552bc8725eaa7cae6894817579e1a53485eb41a283a2f5bf2b3', '[\"*\"]', NULL, NULL, '2025-11-01 00:05:33', '2025-11-01 00:05:33'),
(25, 'App\\Models\\User', 1, 'kamal-AuthToken', 'bbccc0b5379203340a73db962e7b295fc819f79556cb6934620a54e538d2645a', '[\"*\"]', NULL, NULL, '2025-11-01 00:05:38', '2025-11-01 00:05:38'),
(26, 'App\\Models\\User', 1, 'kamal-AuthToken', '3c3bd61c92ae29f83aed7c3c67d87bc0248fb99808a71f4d1cf39dfa42861ac5', '[\"*\"]', NULL, NULL, '2025-11-01 00:05:38', '2025-11-01 00:05:38'),
(27, 'App\\Models\\User', 1, 'kamal-AuthToken', '54f6e1743516b709eade85b460390b40cd04c283c1cfce8f9da666dce227695f', '[\"*\"]', NULL, NULL, '2025-11-01 00:05:43', '2025-11-01 00:05:43'),
(28, 'App\\Models\\User', 1, 'kamal-AuthToken', '0566f5ff90607f175c6a178283dd567650bf7d8397d0dd749d1cb9a02bab9e92', '[\"*\"]', NULL, NULL, '2025-11-01 00:06:27', '2025-11-01 00:06:27'),
(29, 'App\\Models\\User', 1, 'kamal-AuthToken', '82553f96d73e858020c7d6df0660ec790f4b357b2bdb47eba1dc8d215b317f4a', '[\"*\"]', NULL, NULL, '2025-11-01 00:06:28', '2025-11-01 00:06:28'),
(30, 'App\\Models\\User', 1, 'kamal-AuthToken', '08e59976254186fb7cbfd5caf072cba36ad85797095fcdaad0cb8dc687949c37', '[\"*\"]', NULL, NULL, '2025-11-01 00:06:28', '2025-11-01 00:06:28'),
(31, 'App\\Models\\User', 1, 'kamal-AuthToken', 'c3ad29e0c4309f8f6f14716d031a6bf8812d0c480052f1803627a015d9321a5f', '[\"*\"]', NULL, NULL, '2025-11-01 00:06:29', '2025-11-01 00:06:29'),
(32, 'App\\Models\\User', 1, 'kamal-AuthToken', '89c9e93d134b9e09d192e3d01d4c7e43f7fb6928775a918aff7e723d843a82e2', '[\"*\"]', NULL, NULL, '2025-11-01 00:06:35', '2025-11-01 00:06:35'),
(33, 'App\\Models\\User', 1, 'kamal-AuthToken', 'c9e277847843b19dbc7639089ae15ce49925a913c4e01aabe6d03ca520cdfd3f', '[\"*\"]', NULL, NULL, '2025-11-01 00:06:54', '2025-11-01 00:06:54'),
(34, 'App\\Models\\User', 1, 'kamal-AuthToken', 'c85bc900cce2c645208de34ffccc8eb7baba104de81f7fb2426d1bab4cd2b88f', '[\"*\"]', NULL, NULL, '2025-11-01 00:06:55', '2025-11-01 00:06:55'),
(35, 'App\\Models\\User', 1, 'kamal-AuthToken', 'd8ea6f9ea2b5be0035c5b87ac6915573629ada3566d9baf6fbcc17aec8d5a93f', '[\"*\"]', NULL, NULL, '2025-11-01 00:06:55', '2025-11-01 00:06:55'),
(36, 'App\\Models\\User', 1, 'kamal-AuthToken', '2eae5be9428cd245165d9d3a7729056c4020ec65b96c793a3b9c15ac2c9d2dc9', '[\"*\"]', NULL, NULL, '2025-11-01 00:06:56', '2025-11-01 00:06:56'),
(37, 'App\\Models\\User', 1, 'kamal-AuthToken', 'e8684d5e26b7ddfd3575037c20541c69715b74ce388e9bf9910361e452e1d4b9', '[\"*\"]', NULL, NULL, '2025-11-01 00:07:06', '2025-11-01 00:07:06'),
(38, 'App\\Models\\User', 1, 'kamal-AuthToken', '539133668093d83b7b2059ab8e3ce946e7c12e0acef104598b27684690655f08', '[\"*\"]', NULL, NULL, '2025-11-01 00:07:26', '2025-11-01 00:07:26'),
(39, 'App\\Models\\User', 1, 'kamal-AuthToken', '258282ac5e989c9ec8eebdb80281aca35994b7338d4a8ddb983766ac43a8f21b', '[\"*\"]', NULL, NULL, '2025-11-01 00:07:29', '2025-11-01 00:07:29'),
(40, 'App\\Models\\User', 1, 'kamal-AuthToken', '759e9eac71da29a01fd98c399788c513d417127d54ed27995c93812f453a5fa1', '[\"*\"]', NULL, NULL, '2025-11-01 00:07:42', '2025-11-01 00:07:42'),
(41, 'App\\Models\\User', 1, 'kamal-AuthToken', '27b78403586774c7f1a60381963485a9ac02610273785cfc4f3f12062b44be04', '[\"*\"]', NULL, NULL, '2025-11-01 00:07:44', '2025-11-01 00:07:44'),
(42, 'App\\Models\\User', 1, 'kamal-AuthToken', 'cf9c048f63ceb4864c3c841d75038f2d99c2b32d8748532779937161616553da', '[\"*\"]', NULL, NULL, '2025-11-01 00:07:44', '2025-11-01 00:07:44'),
(43, 'App\\Models\\User', 1, 'kamal-AuthToken', '29c933408872715a5f1b6782d0d4cb564fd48faf71e5c5b45cb48d8d8b690e7e', '[\"*\"]', NULL, NULL, '2025-11-01 00:07:45', '2025-11-01 00:07:45'),
(44, 'App\\Models\\User', 1, 'kamal-AuthToken', '8955805fc817a684c25f8e362a47612932bd1a260d0eb9453f00f7e39e2db90f', '[\"*\"]', NULL, NULL, '2025-11-01 00:07:46', '2025-11-01 00:07:46'),
(45, 'App\\Models\\User', 1, 'kamal-AuthToken', 'a473059ab0fb23eece87e07c04421f4aa47ed9cfa72d06279adad618e794077e', '[\"*\"]', NULL, NULL, '2025-11-01 00:08:01', '2025-11-01 00:08:01'),
(46, 'App\\Models\\User', 1, 'kamal-AuthToken', '73b9200a9b070765c20a37491f4d09d9968a1c23ebf89a6d9b8a3e30e3eae7c4', '[\"*\"]', NULL, NULL, '2025-11-01 00:08:01', '2025-11-01 00:08:01'),
(47, 'App\\Models\\User', 1, 'kamal-AuthToken', '8c4ed9f1a43ff30da7111a5926ce123f7f828ae71c937de1a8971609a61f4a9e', '[\"*\"]', NULL, NULL, '2025-11-01 00:08:02', '2025-11-01 00:08:02'),
(48, 'App\\Models\\User', 1, 'kamal-AuthToken', '5eacaaa0c5d6d341de2e3c1be1ffb0fad331dc03389a378108c765f7b04be6f8', '[\"*\"]', NULL, NULL, '2025-11-01 00:08:53', '2025-11-01 00:08:53'),
(49, 'App\\Models\\User', 1, 'kamal-AuthToken', 'ef137ab4ecc0ce474b64b3c888fb7c5e44a7ae266acaa12d205145cc61271644', '[\"*\"]', NULL, NULL, '2025-11-01 00:08:54', '2025-11-01 00:08:54'),
(50, 'App\\Models\\User', 1, 'kamal-AuthToken', '5ccb85ad287fea166f3257a4d5ccd2d22ac45e661942bd50d2e82c255096d3d9', '[\"*\"]', NULL, NULL, '2025-11-01 00:08:55', '2025-11-01 00:08:55'),
(51, 'App\\Models\\User', 1, 'kamal-AuthToken', 'f6e51864cfa0089982244bcdde519a2b71839990d2a151988cce02d567c815fa', '[\"*\"]', NULL, NULL, '2025-11-01 00:08:56', '2025-11-01 00:08:56'),
(52, 'App\\Models\\User', 1, 'kamal-AuthToken', '2d097cee6be40d1103319a22c379fc72665e1385073894cddeeba0ec1b8d14ae', '[\"*\"]', NULL, NULL, '2025-11-01 00:08:56', '2025-11-01 00:08:56'),
(53, 'App\\Models\\User', 1, 'kamal-AuthToken', '325f7b2d7c82204f658dea02450dd01c615728b19ab281cdf6785987ae10fa29', '[\"*\"]', NULL, NULL, '2025-11-01 00:08:57', '2025-11-01 00:08:57'),
(54, 'App\\Models\\User', 1, 'kamal-AuthToken', 'e04e2f7b6c3083ee0c2222775148ca49667c393d5d6270b36a0009edb29600c4', '[\"*\"]', NULL, NULL, '2025-11-01 00:08:59', '2025-11-01 00:08:59'),
(55, 'App\\Models\\User', 1, 'kamal-AuthToken', '3c36c7f44689460aa0b4cb9b5348c1b1e9ac1b324cf462b8e645209a97ecc874', '[\"*\"]', NULL, NULL, '2025-11-01 00:09:05', '2025-11-01 00:09:05'),
(56, 'App\\Models\\User', 1, 'kamal-AuthToken', '6a8245783ac5f7485b7cdfddd4ed6bf03cfdc9f56ece56ce8809291f08d5715c', '[\"*\"]', NULL, NULL, '2025-11-01 00:09:16', '2025-11-01 00:09:16'),
(57, 'App\\Models\\User', 1, 'kamal-AuthToken', 'ca4c3888655454f5ba87d10520a026852718c26082c982bede5ecd850dfb1181', '[\"*\"]', NULL, NULL, '2025-11-01 00:09:17', '2025-11-01 00:09:17'),
(58, 'App\\Models\\User', 1, 'kamal-AuthToken', 'c950b87ae3c8d6538ecd444c1de4d435d894ec3920f2f20aef284a9996e0e4b7', '[\"*\"]', NULL, NULL, '2025-11-01 00:09:46', '2025-11-01 00:09:46'),
(59, 'App\\Models\\User', 1, 'kamal-AuthToken', 'e7cf8151eb8a3e02b63519ccb9ac129903de2788ca0bc55bab3b02bcf160dcbc', '[\"*\"]', NULL, NULL, '2025-11-01 00:10:05', '2025-11-01 00:10:05'),
(60, 'App\\Models\\User', 1, 'kamal-AuthToken', '5c005e59c9123c39e5d71630379115fa70639fb4e12fbc8685cedc26bbfea8d5', '[\"*\"]', NULL, NULL, '2025-11-01 00:10:06', '2025-11-01 00:10:06'),
(61, 'App\\Models\\User', 1, 'kamal-AuthToken', '6fa640ef2828fcd855559a17249cb4e1978e4e2acbf7678775d6d9d9b3f71574', '[\"*\"]', NULL, NULL, '2025-11-01 00:10:06', '2025-11-01 00:10:06'),
(62, 'App\\Models\\User', 1, 'kamal-AuthToken', 'cdc800ddc509dd816b8fe9dc0322684c04f3f57baccd18f53d9eb69c2b8dc971', '[\"*\"]', NULL, NULL, '2025-11-01 00:10:16', '2025-11-01 00:10:16'),
(63, 'App\\Models\\User', 2, 'jamal-AuthToken', '60038af6da1ccde5a42d5f875fdb54dc3875916661740e867f4c570d71268221', '[\"*\"]', NULL, NULL, '2025-11-01 00:11:03', '2025-11-01 00:11:03'),
(64, 'App\\Models\\User', 2, 'jamal-AuthToken', '5ba93c5ef328e577146b0205a37902f38090113b1c7ccbeffcd79ebec1e50672', '[\"*\"]', NULL, NULL, '2025-11-01 00:11:10', '2025-11-01 00:11:10'),
(65, 'App\\Models\\User', 2, 'jamal-AuthToken', '6d3ea13c8dfb9a441eff9234a84dfcc96d807691d2d6c44054eb0fbff72b8e56', '[\"*\"]', NULL, NULL, '2025-11-01 00:14:46', '2025-11-01 00:14:46'),
(66, 'App\\Models\\User', 1, 'kamal-AuthToken', 'e515c685e7d4d3a77f735b2289a92e44ee7652c60090952b63294283aa6f8eef', '[\"*\"]', NULL, NULL, '2025-11-01 00:18:12', '2025-11-01 00:18:12'),
(67, 'App\\Models\\User', 1, 'kamal-AuthToken', '6e167c63fb481b2f93fe36a0a6ea5b39255e703b1260979c3dcc2651aecc59e0', '[\"*\"]', NULL, NULL, '2025-11-01 21:30:57', '2025-11-01 21:30:57'),
(68, 'App\\Models\\User', 1, 'kamal-AuthToken', '160a87a04b29e0e9535f811e6b8f7933fa47d4fa70e9313b6a3b613b9a59a6e6', '[\"*\"]', NULL, NULL, '2025-11-02 21:14:07', '2025-11-02 21:14:07'),
(69, 'App\\Models\\User', 1, 'kamal-AuthToken', '33ccc4f6704014c1cfdf33884ae94be01486fcbee7aba1cc0101f5c80badabba', '[\"*\"]', NULL, NULL, '2025-11-02 21:22:32', '2025-11-02 21:22:32'),
(70, 'App\\Models\\User', 1, 'kamal-AuthToken', 'f73ccdadc153bddb9fe2b378ff90f48eefd9604447eb5766fff55e031e638a58', '[\"*\"]', NULL, NULL, '2025-11-02 23:59:08', '2025-11-02 23:59:08'),
(71, 'App\\Models\\User', 1, 'kamal-AuthToken', '722a67daffdf5bdb0cf5344f4d571c2f6916ac0b55392b0abfadf10ca0e7eaf6', '[\"*\"]', NULL, NULL, '2025-11-02 23:59:21', '2025-11-02 23:59:21'),
(72, 'App\\Models\\User', 1, 'kamal-AuthToken', 'f6329d84d5b98b6ce4aeeabb373ff7be8b034387890163d38f95f668bc6e163c', '[\"*\"]', NULL, NULL, '2025-11-03 00:00:46', '2025-11-03 00:00:46'),
(73, 'App\\Models\\User', 1, 'kamal-AuthToken', '5e9a900c38b663be207ca393ff85db6cb3d69d663b6a4e0edc35b6d2e058636e', '[\"*\"]', NULL, NULL, '2025-11-03 00:01:19', '2025-11-03 00:01:19'),
(74, 'App\\Models\\User', 1, 'kamal-AuthToken', '302fcb5b65ce7dc02484a39ec67de2c7500fadbc8d3c5cde5c6e6c90cc29fb79', '[\"*\"]', NULL, NULL, '2025-11-03 00:01:24', '2025-11-03 00:01:24');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `category_id` bigint(20) NOT NULL,
  `supplier_id` bigint(20) NOT NULL,
  `sku` varchar(255) NOT NULL,
  `stock_qty` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `description` text DEFAULT NULL,
  `unit` varchar(255) DEFAULT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `brand` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `buy_price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `sell_price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `status` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `category_id`, `supplier_id`, `sku`, `stock_qty`, `created_at`, `updated_at`, `description`, `unit`, `stock`, `brand`, `image`, `buy_price`, `sell_price`, `status`) VALUES
(6, 'Coca-Cola', 9, 4, 'CC-1500ML', 0, '2025-11-01 23:28:11', '2025-11-02 23:41:46', 'Refreshing soft drink loved by all ages', '1.5L', 168, 'Coca-Cola', 'uploads/products/1762061291_png-clipart-coca-cola-soda-bottle-coca-cola-soft-drink-diet-coke-coke-the-cocacola-company-cola-thumbnail.png', 68.00, 75.00, 1),
(7, 'Sprite 500ml', 9, 4, 'SP-500ML', 0, '2025-11-01 23:48:03', '2025-11-02 23:40:44', 'Lemon-lime soft drink with a crisp taste', '500ml', 190, 'Coca-Cola', 'uploads/products/1762062483_sprite-png-153y79tdva0ckmkw.png', 35.00, 45.00, 1),
(8, 'Lifebuoy Hand Wash', 12, 5, 'LB-HW200', 0, '2025-11-01 23:50:34', '2025-11-01 23:56:03', 'Kills 99.9% of germs for healthy hands', '200ml', 100, 'Unilever', 'uploads/products/1762062634_lifebuoy.png', 90.00, 110.00, 1),
(9, 'Dove Beauty Soap 100g', 12, 11, 'DV-SOAP100', 0, '2025-11-01 23:58:28', '2025-11-01 23:58:28', 'Moisturizing beauty bar for soft, smooth skin', '100g Bar', 100, 'Dove', 'uploads/products/1762063108_dove.jpg', 80.00, 95.00, 1),
(10, 'DANO Milk Powder 500g', 8, 3, 'DN-MP500', 0, '2025-11-02 00:00:35', '2025-11-02 00:00:35', 'Full cream milk powder rich in calcium and vitamins', '500g Pack', 130, 'DANO', 'uploads/products/1762063235_Arla-Dano-Full-Cream-Milk-Powder-500gm-450x540.jpg', 380.00, 420.00, 1);

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE `purchases` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `invoice_no` varchar(255) NOT NULL,
  `supplier_id` bigint(20) NOT NULL,
  `purchase_date` date NOT NULL DEFAULT '2025-10-28',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `subtotal` decimal(10,2) NOT NULL DEFAULT 0.00,
  `discount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `tax` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total_cost` decimal(10,2) NOT NULL DEFAULT 0.00,
  `paid_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `due_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `payment_status` varchar(255) NOT NULL DEFAULT 'due',
  `note` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`id`, `invoice_no`, `supplier_id`, `purchase_date`, `created_at`, `updated_at`, `subtotal`, `discount`, `tax`, `total_cost`, `paid_amount`, `due_amount`, `payment_status`, `note`) VALUES
(7, 'PUR-20251102060404', 10, '2025-11-02', '2025-11-02 00:04:04', '2025-11-02 00:04:04', 420.00, 20.00, 10.00, 410.00, 410.00, 0.00, 'paid', 'as'),
(8, 'PUR-20251102060547', 4, '2025-11-02', '2025-11-02 00:05:47', '2025-11-02 00:27:40', 420.10, 0.00, 0.00, 420.10, 350.00, 70.10, 'partial', 'c'),
(9, 'PUR-20251103032340', 4, '2025-11-03', '2025-11-02 21:23:40', '2025-11-02 22:01:40', 6800.00, 0.00, 0.00, 6800.00, 6800.00, 0.00, 'paid', NULL),
(10, 'PUR-20251103040102', 4, '2025-11-03', '2025-11-02 22:01:02', '2025-11-02 22:01:02', 650.00, 0.00, 0.00, 650.00, 650.00, 0.00, 'paid', NULL),
(11, 'PUR-20251103040403', 4, '2025-11-03', '2025-11-02 22:04:03', '2025-11-02 22:17:12', 4530.00, 0.00, 0.00, 4530.00, 4520.00, 10.00, 'partial', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `purchase_items`
--

CREATE TABLE `purchase_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `purchase_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `total_cost` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchase_items`
--

INSERT INTO `purchase_items` (`id`, `purchase_id`, `product_id`, `quantity`, `unit_price`, `total_cost`, `created_at`, `updated_at`) VALUES
(7, 7, 6, 7, 60.00, 420.00, '2025-11-02 00:04:04', '2025-11-02 00:04:04'),
(8, 8, 7, 10, 42.01, 420.10, '2025-11-02 00:05:47', '2025-11-02 00:27:40'),
(9, 9, 6, 100, 68.00, 6800.00, '2025-11-02 21:23:40', '2025-11-02 22:01:40'),
(10, 10, 6, 10, 65.00, 650.00, '2025-11-02 22:01:02', '2025-11-02 22:01:02'),
(11, 11, 6, 10, 68.00, 680.00, '2025-11-02 22:04:03', '2025-11-02 22:17:12'),
(12, 11, 7, 110, 35.00, 3850.00, '2025-11-02 22:04:03', '2025-11-02 22:16:47');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `salary_payments`
--

CREATE TABLE `salary_payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employee_id` bigint(20) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `pay_date` date NOT NULL DEFAULT '2025-10-28',
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `sale_date` date NOT NULL DEFAULT '2025-10-28',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `invoice_no` varchar(255) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL DEFAULT 0.00,
  `discount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `tax` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total_cost` decimal(10,2) NOT NULL DEFAULT 0.00,
  `paid_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `due_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `payment_status` enum('paid','partial','due') NOT NULL DEFAULT 'due',
  `note` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `customer_id`, `total_price`, `sale_date`, `created_at`, `updated_at`, `invoice_no`, `subtotal`, `discount`, `tax`, `total_cost`, `paid_amount`, `due_amount`, `payment_status`, `note`) VALUES
(17, 4, 450.00, '2025-11-02', '2025-11-02 00:09:14', '2025-11-02 23:40:44', 'SAL-20251102060914', 450.00, 0.00, 0.00, 0.00, 450.00, 0.00, 'paid', 'hfbg'),
(18, 3, 300.00, '2025-11-03', '2025-11-02 23:41:46', '2025-11-02 23:41:46', 'SAL-20251103054146', 300.00, 0.00, 0.00, 0.00, 300.00, 0.00, 'paid', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sale_items`
--

CREATE TABLE `sale_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sale_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `unit_price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total_cost` decimal(10,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `total_price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sale_items`
--

INSERT INTO `sale_items` (`id`, `sale_id`, `product_id`, `quantity`, `unit_price`, `total_cost`, `created_at`, `updated_at`, `total_price`) VALUES
(13, 17, 7, 10, 45.00, 0.00, '2025-11-02 00:09:14', '2025-11-02 23:40:44', 450.00),
(14, 18, 6, 4, 75.00, 0.00, '2025-11-02 23:41:46', '2025-11-02 23:41:46', 300.00);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `name`, `email`, `phone`, `address`, `created_at`, `updated_at`) VALUES
(3, 'Dairy Fresh Ltd', 'sales@dairyfresh.com', '01711-111111', 'Tejgaon, Dhaka', '2025-11-01 00:23:05', '2025-11-01 00:23:05'),
(4, 'Coca-Cola BD', 'contact@cocacolabd.com', '01715-555555', 'Gulshan, Dhaka', '2025-11-01 00:23:58', '2025-11-01 00:23:58'),
(5, 'Unilever BD', 'unileverbd@info.com', '01716-666666', 'Chittagong', '2025-11-01 00:25:07', '2025-11-01 00:25:07'),
(6, 'FreshFruits BD', 'sales@freshfruits.com', '01714-444444', 'Savar, Dhaka', '2025-11-01 00:25:49', '2025-11-01 00:25:49'),
(7, 'Daily Bread Co.', 'info@dailybread.com', '01712-222222', 'Dhanmondi, Dhaka', '2025-11-01 00:26:25', '2025-11-01 00:26:25'),
(8, 'Colgate BD', 'sales@colgatebd.com', '01717-777777', 'Motijheel, Dhaka', '2025-11-01 00:27:13', '2025-11-01 00:27:13'),
(9, 'PRAN', 'contactpran@yahoo.com', '0181-1245283', 'Dhaka', '2025-11-01 23:52:25', '2025-11-01 23:52:25'),
(10, 'BASHUNDHARA', 'contactbasundhara@yahoo.com', '0182-00000', 'Dhaka,Bangladesh', '2025-11-01 23:54:06', '2025-11-01 23:54:06'),
(11, 'Dove', 'dove@gmail.com', '01587-000000', 'Chittagong,Bangladesh', '2025-11-01 23:56:53', '2025-11-01 23:56:53');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `role_id` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `role_id`) VALUES
(1, 'kamal', 'kamal@yahoo.com', NULL, '$2y$12$0q8tp4pVB2B6fOtDir631.GyqhHOP3QCzs1rdP8zNM1rdadXpWHaO', NULL, '2025-10-28 05:30:28', '2025-10-28 05:30:28', NULL),
(2, 'jamal', 'jamal@yahoo.com', NULL, '$2y$12$ibCmRnfjBiMjunNa3BCgmuHUgdQUulIqH7.eczG.6nwmtLZjEnw..', NULL, '2025-11-01 00:10:42', '2025-11-01 00:10:42', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `categories_name_unique` (`name`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `employees_email_unique` (`email`),
  ADD UNIQUE KEY `employees_username_unique` (`username`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `inventory_logs`
--
ALTER TABLE `inventory_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `products_sku_unique` (`sku`);

--
-- Indexes for table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `purchases_invoice_no_unique` (`invoice_no`);

--
-- Indexes for table `purchase_items`
--
ALTER TABLE `purchase_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_unique` (`name`);

--
-- Indexes for table `salary_payments`
--
ALTER TABLE `salary_payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sales_invoice_no_unique` (`invoice_no`);

--
-- Indexes for table `sale_items`
--
ALTER TABLE `sale_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inventory_logs`
--
ALTER TABLE `inventory_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `purchase_items`
--
ALTER TABLE `purchase_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `salary_payments`
--
ALTER TABLE `salary_payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `sale_items`
--
ALTER TABLE `sale_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
