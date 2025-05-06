/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE IF NOT EXISTS `bodegon10` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `bodegon10`;

CREATE TABLE IF NOT EXISTS `bebidas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `bebidas` (`id`, `nombre`, `precio`) VALUES
	(3, 'fanta', 23.00);

CREATE TABLE IF NOT EXISTS `clientes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `telefono` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `apellido` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `clientes` (`id`, `nombre`, `telefono`, `email`, `apellido`) VALUES
	(2, 'dsds', '1233334444', 'jsjsjs@ddd', 'dsada'),
	(3, 'fsfs2', '1533334444', '12s@gmail.com', 'sss33e');

CREATE TABLE IF NOT EXISTS `combos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `ingredientes` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '',
  `descripcion` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `combos` (`id`, `nombre`, `precio`, `ingredientes`, `descripcion`) VALUES
	(1, 'papasss', 12.00, '', 'dark'),
	(2, '112', 22.00, '', '321');

CREATE TABLE IF NOT EXISTS `cuentas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mesa_id` int DEFAULT NULL,
  `fecha_apertura` datetime NOT NULL,
  `fecha_cierre` datetime DEFAULT NULL,
  `estado` enum('abierta','cerrada') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'abierta',
  `total` decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`),
  KEY `mesa_id` (`mesa_id`),
  CONSTRAINT `cuentas_ibfk_1` FOREIGN KEY (`mesa_id`) REFERENCES `mesas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `cuentas` (`id`, `mesa_id`, `fecha_apertura`, `fecha_cierre`, `estado`, `total`) VALUES
	(4, 4, '2024-10-24 00:00:00', NULL, 'cerrada', 0.00),
	(5, NULL, '2024-10-24 00:00:00', NULL, 'abierta', 0.00),
	(6, 2, '2024-10-29 00:00:00', NULL, 'cerrada', 0.00),
	(7, 4, '2024-10-29 00:00:00', NULL, 'abierta', 0.00),
	(8, 2, '2024-11-04 00:00:00', NULL, 'cerrada', 0.00),
	(9, 2, '2024-11-05 00:00:00', NULL, 'abierta', 0.00);

CREATE TABLE IF NOT EXISTS `detalles_bebidas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cuenta_id` int DEFAULT NULL,
  `bebida_id` int DEFAULT NULL,
  `cantidad` int NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cuenta_id` (`cuenta_id`),
  KEY `bebida_id` (`bebida_id`),
  CONSTRAINT `detalles_bebidas_ibfk_1` FOREIGN KEY (`cuenta_id`) REFERENCES `cuentas` (`id`),
  CONSTRAINT `detalles_bebidas_ibfk_2` FOREIGN KEY (`bebida_id`) REFERENCES `bebidas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE IF NOT EXISTS `detalles_cuenta` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cuenta_id` int DEFAULT NULL,
  `producto_id` int DEFAULT NULL,
  `tipo_producto` char(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `cantidad` int NOT NULL,
  `precio_unitario` float NOT NULL DEFAULT '0',
  `subtotal` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_cuenta` (`cuenta_id`),
  CONSTRAINT `detalles_cuenta_ibfk_1` FOREIGN KEY (`cuenta_id`) REFERENCES `cuentas` (`id`),
  CONSTRAINT `fk_cuenta` FOREIGN KEY (`cuenta_id`) REFERENCES `cuentas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE IF NOT EXISTS `ingredientes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(250) COLLATE utf8mb4_general_ci NOT NULL,
  `combo_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `combo_id` (`combo_id`),
  KEY `ix_ingredientes_id` (`id`),
  CONSTRAINT `ingredientes_ibfk_1` FOREIGN KEY (`combo_id`) REFERENCES `combos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `ingredientes` (`id`, `nombre`, `combo_id`) VALUES
	(1, 'papas', 1),
	(2, 'ensalada', 2),
	(3, 'papas', NULL),
	(4, 'ensalada', NULL);

CREATE TABLE IF NOT EXISTS `mesas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `numero_mesa` int NOT NULL,
  `capacidad` int NOT NULL,
  `disponible` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `mesas` (`id`, `numero_mesa`, `capacidad`, `disponible`) VALUES
	(2, 32, 33, 0),
	(3, 4, 2, 0),
	(4, 5, 3, 1);

CREATE TABLE IF NOT EXISTS `pedidos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cliente_id` int DEFAULT NULL,
  `mesa_id` int DEFAULT NULL,
  `combo_id` int DEFAULT NULL,
  `fecha_pedido` datetime DEFAULT NULL,
  `total_pedido` float DEFAULT NULL,
  `bebida_id` int DEFAULT NULL,
  `estado` varchar(20) COLLATE utf8mb4_general_ci DEFAULT 'activo',
  `cant_combo` int DEFAULT '0',
  `cant_bebida` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cliente_id` (`cliente_id`),
  KEY `mesa_id` (`mesa_id`),
  KEY `combo_id` (`combo_id`),
  KEY `ix_pedidos_id` (`id`),
  KEY `fk_pedidos_bebida_id` (`bebida_id`),
  CONSTRAINT `fk_pedidos_bebida` FOREIGN KEY (`bebida_id`) REFERENCES `bebidas` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_pedidos_bebida_id` FOREIGN KEY (`bebida_id`) REFERENCES `bebidas` (`id`),
  CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  CONSTRAINT `pedidos_ibfk_2` FOREIGN KEY (`mesa_id`) REFERENCES `mesas` (`id`),
  CONSTRAINT `pedidos_ibfk_3` FOREIGN KEY (`combo_id`) REFERENCES `combos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `pedidos` (`id`, `cliente_id`, `mesa_id`, `combo_id`, `fecha_pedido`, `total_pedido`, `bebida_id`, `estado`, `cant_combo`, `cant_bebida`) VALUES
	(1, 2, 2, 1, '2024-11-05 15:17:12', 35, 3, 'cerrado', 0, 0),
	(2, 2, 3, 2, '2024-11-05 18:11:27', 45, 3, 'finalizado', 0, 0),
	(3, 3, 3, 2, '2024-11-05 18:30:54', 45, 3, 'finalizado', 0, 0),
	(4, 2, 2, 2, '2024-11-05 18:46:26', 45, 3, 'cerrado', 0, 0),
	(5, 2, 3, 2, '2024-11-05 18:46:45', 45, 3, 'finalizado', 0, 0),
	(6, 2, 3, 2, '2024-11-05 20:31:45', 45, 3, 'finalizado', 0, 0),
	(7, 2, 2, 2, '2024-11-05 20:34:52', 45, 3, 'cerrado', 0, 0),
	(8, 2, 2, 1, '2025-02-06 03:07:03', 35, 3, 'cerrado', 0, 0),
	(9, 2, 2, 1, '2025-02-07 17:15:30', 140, 3, 'cerrado', 4, 4),
	(10, 3, 2, 1, '2025-02-07 17:19:36', 175, 3, 'cerrado', 5, 5),
	(11, 3, 4, 2, '2025-02-08 22:39:07', 266, 3, 'activo', 10, 2);

CREATE TABLE IF NOT EXISTS `pedido_detalles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pedido_id` int DEFAULT NULL,
  `producto_tipo` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `producto_id` int DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `precio_unitario` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pedido_id` (`pedido_id`),
  KEY `ix_pedido_detalles_id` (`id`),
  CONSTRAINT `pedido_detalles_ibfk_1` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE IF NOT EXISTS `productos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_general_ci DEFAULT 'Sin descripción',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE IF NOT EXISTS `reservas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cliente_id` int DEFAULT NULL,
  `mesa_id` int DEFAULT NULL,
  `fecha_reserva` date NOT NULL,
  `cuenta_id` int DEFAULT NULL,
  `hora_reserva` time DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mesa_id` (`mesa_id`),
  KEY `cliente_id` (`cliente_id`) USING BTREE,
  CONSTRAINT `reservas_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  CONSTRAINT `reservas_ibfk_2` FOREIGN KEY (`mesa_id`) REFERENCES `mesas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `reservas` (`id`, `cliente_id`, `mesa_id`, `fecha_reserva`, `cuenta_id`, `hora_reserva`) VALUES
	(6, 2, 2, '2025-02-06', NULL, '23:25:00');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
