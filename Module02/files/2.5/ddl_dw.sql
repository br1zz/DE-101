drop schema if exists dw CASCADE;

CREATE SCHEMA IF NOT exists dw;

-- ************************************** dw.addresses

CREATE TABLE dw.addresses
(
 address_id  serial NOT NULL,
 country     varchar(20) NOT NULL,
 city        varchar(20) NULL,
 "state"       varchar(20) NULL,
 postal_code varchar(20) NULL,
 region      varchar(10) NULL,
 CONSTRAINT PK_325 PRIMARY KEY ( address_id )
);

-- ************************************** dw.calendar

CREATE TABLE dw.calendar
(
 date_id serial NOT NULL,
 year       int NOT NULL,
 quarter    varchar(10) NOT NULL,
 month      int NOT NULL,
 week       int NOT NULL,
 date		date NOT NULL,
 week_day   varchar(20),
 leap varchar(20) NOT NULL,
 CONSTRAINT PK_356 PRIMARY KEY ( date_id )
);

-- ************************************** dw.products

CREATE TABLE dw.products
(
 product_id     serial NOT NULL,
 product_name   varchar(150) NOT NULL,
 category       varchar(20) NULL,
 sub_category   varchar(20) NULL,
 product_id_ext varchar(20) NULL,
 CONSTRAINT PK_323 PRIMARY KEY ( product_id )
);


-- ************************************** dw.customers

CREATE TABLE dw.customers
(
 customer_id   serial NOT NULL,
 customer_name varchar(25) NOT NULL,
 code          varchar(10) NOT NULL,
 segment       varchar(15) NULL,
 CONSTRAINT PK_324 PRIMARY KEY ( customer_id )
);

-- ************************************** dw.shipments

CREATE TABLE dw.shipments
(
 shipment_id   serial NOT NULL,
 shipment_mode varchar(15) NOT NULL,
 CONSTRAINT PK_65 PRIMARY KEY ( shipment_id )
);


-- ************************************** dw.sales

CREATE TABLE dw.sales
(
 sales_id    serial NOT NULL,
 reterned    varchar(5) NULL,
 sales       numeric(12,4) NOT NULL,
 quantity    int NOT NULL,
 discount    numeric(4,2) NULL,
 profit      numeric(21,16) NOT NULL,
 order_id    varchar(50) NOT NULL,
 order_date_id  int NOT NULL,
 ship_date_id   int NOT NULL,
 customer_id serial NOT NULL,
 shipment_id serial NOT NULL,
 address_id  serial NOT NULL,
 product_id  serial NOT NULL,
 CONSTRAINT PK_385 PRIMARY KEY (sales_id)
);
