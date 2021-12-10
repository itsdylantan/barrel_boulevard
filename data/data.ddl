DROP TABLE IF EXISTS review;
DROP TABLE IF EXISTS shipment;
DROP TABLE IF EXISTS productinventory;
DROP TABLE IF EXISTS warehouse;
DROP TABLE IF EXISTS orderproduct;
DROP TABLE IF EXISTS incart;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS ordersummary;
DROP TABLE IF EXISTS paymentmethod;
DROP TABLE IF EXISTS customer;


CREATE TABLE customer (
    customerId          INT IDENTITY,
    firstName           VARCHAR(40),
    lastName            VARCHAR(40),
    email               VARCHAR(50),
    phonenum            VARCHAR(20),
    address             VARCHAR(50),
    city                VARCHAR(40),
    state               VARCHAR(20),
    postalCode          VARCHAR(20),
    country             VARCHAR(40),
    userid              VARCHAR(20),
    password            VARCHAR(30),
    PRIMARY KEY (customerId)
);

CREATE TABLE paymentmethod (
    paymentMethodId     INT IDENTITY,
    paymentType         VARCHAR(20),
    paymentNumber       VARCHAR(30),
    paymentExpiryDate   DATE,
    customerId          INT,
    PRIMARY KEY (paymentMethodId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE ordersummary (
    orderId             INT IDENTITY,
    orderDate           DATETIME,
    totalAmount         DECIMAL(10,2),
    shiptoAddress       VARCHAR(50),
    shiptoCity          VARCHAR(40),
    shiptoState         VARCHAR(20),
    shiptoPostalCode    VARCHAR(20),
    shiptoCountry       VARCHAR(40),
    customerId          INT,
    PRIMARY KEY (orderId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE category (
    categoryId          INT IDENTITY,
    categoryName        VARCHAR(50),    
    PRIMARY KEY (categoryId)
);

CREATE TABLE product (
    productId           INT IDENTITY,
    productName         VARCHAR(40),
    productPrice        DECIMAL(10,2),
    productImageURL     VARCHAR(100),
    productImage        VARBINARY(MAX),
    productDesc         VARCHAR(1000),
    categoryId          INT,
    PRIMARY KEY (productId),
    FOREIGN KEY (categoryId) REFERENCES category(categoryId)
);

CREATE TABLE orderproduct (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE incart (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE warehouse (
    warehouseId         INT IDENTITY,
    warehouseName       VARCHAR(30),    
    PRIMARY KEY (warehouseId)
);

CREATE TABLE shipment (
    shipmentId          INT IDENTITY,
    shipmentDate        DATETIME,   
    shipmentDesc        VARCHAR(100),   
    warehouseId         INT, 
    PRIMARY KEY (shipmentId),
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE productinventory ( 
    productId           INT,
    warehouseId         INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (productId, warehouseId),   
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE review (
    reviewId            INT IDENTITY,
    reviewRating        INT,
    reviewDate          DATETIME,   
    customerId          INT,
    productId           INT,
    reviewComment       VARCHAR(1000),          
    PRIMARY KEY (reviewId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO category(categoryName) VALUES ('SCOTCH WHISKY');
INSERT INTO category(categoryName) VALUES ('IRISH WHISKY');
INSERT INTO category(categoryName) VALUES ('RYE');
INSERT INTO category(categoryName) VALUES ('STRAIGHT BOURBON');
INSERT INTO category(categoryName) VALUES ('BLENDED BOURBON');
INSERT INTO category(categoryName) VALUES ('TENESSEE WHISKY');
INSERT INTO category(categoryName) VALUES ('BOURBON');
INSERT INTO category(categoryName) VALUES ('FLAVOURED WHISKY');

INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('LAGAVULIN', 1, 'Scotch Whisky',200.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('LAPHROAIG',1,'Scotch Whisky', 190.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('DEAD RABBIT IRISH WHISKY',2,'Irish Whisky',150.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('LEGACY',3,'Rye',49.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('LINDORES', 4, 'Straight Bourbon',119.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('ARBIKIE - HIGHLAND RYE',3,'Rye',350.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('ALBERTA PREMIUM',3,'Rye',51.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('ARDBEG - AN OA',1,'Scotch Whiskey',99.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('CROWN ROYAL - SALTED CARAMEL',8,'Flavoured Whiskey',27.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('SKREWBALL - PEANUT BUTTER WHISKEY',8,'Flavoured Whiskey',57.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('SHEEP DOG - PEANUT BUTTER WHISKEY',8,'Flavoured Whiskey',21.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('BAKERS - BOURBON',5,'Blended Bourbon',79.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('BASIL HAYDEN - TOAST',5,'Blended Bourbon',64.25);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('JEFFERSONS - KENTUCKY STRAIGHT BOURBON',4,'Straight Bourbon',55.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('HOWLER HEAD - WHISKEY',5,'Blended Whisky',51.45);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('BLACKENED - AMERICAN WHISKEY',7,'Bourbon',39.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('JACK DANIELS',6,'TENESSEE Whiskey',62.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('OLD FORESTER - SIGNATURE 86 PROOF',8,'Bourbon',31.49);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('PUNJABI CLUB',5,'Blended Whiskey',54.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('GLENALLACHIE', 1, 'Scotch Whisky',200.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('WHYTE AND MACKAY',1,'Scotch Whisky', 190.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('PROPER 12',2,'Irish Whisky',30.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('REY SOL - EXTRA ANEJO 6 YEAR',3,'Rye',409.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('LARCENY KENTUCKY STRAIGHT BOURBON', 4, 'Straight Bourbon',119.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('CANADIAN CLUB - RYE CHAIRMANS SELECT',3,'Rye',35.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('SAZERAC - STRAIGHT RYE WHISKEY',3,'Rye',51.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('SCAPA - GLANSA SCOTCH WHISKY - AN OA',1,'Scotch Whiskey',99.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('MAKERS MARK',8,'Flavoured Whiskey',27.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('ABERFELDY - 12 YEAR OLD',8,'Flavoured Whiskey',57.00);


INSERT INTO warehouse(warehouseName) VALUES ('Main warehouse');
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (1, 1, 5, 18);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (2, 1, 10, 19);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (3, 1, 3, 10);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (4, 1, 2, 22);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (5, 1, 6, 21.35);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (6, 1, 3, 25);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (7, 1, 1, 30);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (8, 1, 0, 40);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (9, 1, 2, 97);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (10, 1, 3, 31);

INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Arnold', 'Anderson', 'a.anderson@gmail.com', '204-111-2222', '103 AnyWhere Street', 'Winnipeg', 'MB', 'R3X 45T', 'Canada', 'arnold' , 'test');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Bobby', 'Brown', 'bobby.brown@hotmail.ca', '572-342-8911', '222 Bush Avenue', 'Boston', 'MA', '22222', 'United States', 'bobby' , 'bobby');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Candace', 'Cole', 'cole@charity.org', '333-444-5555', '333 Central Crescent', 'Chicago', 'IL', '33333', 'United States', 'candace' , 'password');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Darren', 'Doe', 'oe@doe.com', '250-807-2222', '444 Dover Lane', 'Kelowna', 'BC', 'V1V 2X9', 'Canada', 'darren' , 'pw');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Elizabeth', 'Elliott', 'engel@uiowa.edu', '555-666-7777', '555 Everwood Street', 'Iowa City', 'IA', '52241', 'United States', 'beth' , 'test');

-- Order 1 can be shipped as have enough inventory
DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (1, '2019-10-15 10:25:55', 91.70)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 1, 1, 18)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 2, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 10, 1, 31);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-16 18:00:00', 106.75)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 5, 21.35);

-- Order 3 cannot be shipped as do not have enough inventory for item 7
DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (3, '2019-10-15 3:30:22', 140)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 6, 2, 25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 7, 3, 30);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-17 05:45:11', 327.85)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 3, 4, 10)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 8, 3, 40)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 13, 3, 23.25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 28, 2, 21.05)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 29, 4, 14);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (5, '2019-10-15 10:25:55', 277.40)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 4, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 19, 2, 81)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 20, 3, 10);

-- New SQL DDL for lab 8
UPDATE Product SET productImageURL = 'img/1.jpg' WHERE ProductId = 1;
UPDATE Product SET productImageURL = 'img/2.jpg' WHERE ProductId = 2;
UPDATE Product SET productImageURL = 'img/3.jpg' WHERE ProductId = 3;
UPDATE Product SET productImageURL = 'img/4.jpg' WHERE ProductId = 4;
UPDATE Product SET productImageURL = 'img/5.jpg' WHERE ProductId = 5;

-- Loads image data for product 1
