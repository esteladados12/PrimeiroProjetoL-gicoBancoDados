
CREATE TABLE `Clients` (
  `idCliente` int NOT NULL AUTO_INCREMENT,
  `Fname` varchar(15) DEFAULT NULL,
  `Lname` varchar(20) DEFAULT NULL,
  `CPF` char(11) NOT NULL,
  `Adress` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE KEY `unique_cpf_client` (`CPF`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Orders` (
  `idOrder` int NOT NULL AUTO_INCREMENT,
  `idOrderClient` int DEFAULT NULL,
  `OrderStatus` enum('Cancelado','Confirmado','Em processamento') DEFAULT 'Em processamento',
  `OrderDescription` varchar(255) DEFAULT NULL,
  `SendValue` float DEFAULT '10',
  `PaymentCash` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`idOrder`),
  KEY `fk_orders_client` (`idOrderClient`),
  CONSTRAINT `fk_orders_client` FOREIGN KEY (`idOrderClient`) REFERENCES `Clients` (`idCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Product` (
  `idProduto` int NOT NULL AUTO_INCREMENT,
  `Pname` varchar(15) NOT NULL,
  `Classification_kids` tinyint(1) DEFAULT '0',
  `Category` enum('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis') NOT NULL,
  `Avaliação` float DEFAULT '0',
  `Size` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`idProduto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ProductOrder` (
  `idProductOrderProduct` int NOT NULL,
  `idProductOrder` int NOT NULL,
  `ProductOrderQuantity` int DEFAULT '1',
  `ProductOrderStatus` enum('Disponível','Sem estoque') DEFAULT 'Disponível',
  PRIMARY KEY (`idProductOrderProduct`,`idProductOrder`),
  KEY `fk_productorder_product` (`idProductOrder`),
  CONSTRAINT `fk_productorder_product` FOREIGN KEY (`idProductOrder`) REFERENCES `Orders` (`idOrder`),
  CONSTRAINT `fk_productorder_seller` FOREIGN KEY (`idProductOrderProduct`) REFERENCES `Product` (`idProduto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ProductSeller` (
  `idProductSeller` int NOT NULL,
  `idProduct` int NOT NULL,
  `ProductQuantity` int DEFAULT '1',
  PRIMARY KEY (`idProductSeller`,`idProduct`),
  KEY `fk_product_product` (`idProduct`),
  CONSTRAINT `fk_product_product` FOREIGN KEY (`idProduct`) REFERENCES `Product` (`idProduto`),
  CONSTRAINT `fk_product_seller` FOREIGN KEY (`idProductSeller`) REFERENCES `Seller` (`idSeller`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ProductStorage` (
  `idProductStorage` int NOT NULL AUTO_INCREMENT,
  `StorageLocation` varchar(255) DEFAULT NULL,
  `Quantity` int DEFAULT '0',
  PRIMARY KEY (`idProductStorage`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ProductSupplier` (
  `idProductSupplier` int NOT NULL,
  `idProductSupplierProduct` int NOT NULL,
  `Quantity` int NOT NULL,
  PRIMARY KEY (`idProductSupplier`,`idProductSupplierProduct`),
  KEY `fk_product_supplier_product` (`idProductSupplierProduct`),
  CONSTRAINT `fk_product_supplier_product` FOREIGN KEY (`idProductSupplierProduct`) REFERENCES `Product` (`idProduto`),
  CONSTRAINT `fk_product_supplier_supplier` FOREIGN KEY (`idProductSupplier`) REFERENCES `Supplier` (`idSupplier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Seller` (
  `idSeller` int NOT NULL AUTO_INCREMENT,
  `SocialName` varchar(255) NOT NULL,
  `AbstractName` varchar(255) DEFAULT NULL,
  `CNPJ` char(15) DEFAULT NULL,
  `CPF` char(9) DEFAULT NULL,
  `TelephoneNumber` char(11) NOT NULL,
  `EmailSellerr` varchar(100) NOT NULL,
  `Location` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idSeller`),
  UNIQUE KEY `unique_cnpj_seller` (`CNPJ`),
  UNIQUE KEY `unique_cpf_seller` (`CPF`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `StorageLocation` (
  `idLocalProduct` int NOT NULL,
  `idLocalStorage` int NOT NULL,
  `Location` varchar(255) NOT NULL,
  PRIMARY KEY (`idLocalProduct`,`idLocalStorage`),
  KEY `fk_storage_location_storage` (`idLocalStorage`),
  CONSTRAINT `fk_storage_location_product` FOREIGN KEY (`idLocalProduct`) REFERENCES `Product` (`idProduto`),
  CONSTRAINT `fk_storage_location_storage` FOREIGN KEY (`idLocalStorage`) REFERENCES `ProductStorage` (`idProductStorage`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Supplier` (
  `idSupplier` int NOT NULL AUTO_INCREMENT,
  `SocialName` varchar(255) NOT NULL,
  `CNPJ` char(15) NOT NULL,
  `TelephoneNumber` char(11) NOT NULL,
  `EmailSupplier` varchar(100) NOT NULL,
  PRIMARY KEY (`idSupplier`),
  UNIQUE KEY `unique_supplier` (`CNPJ`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
