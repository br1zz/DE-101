drop schema if exists model CASCADE;

CREATE SCHEMA IF NOT exists model;

-- ************************************** model.addresses

CREATE TABLE model.addresses
(
 address_id  serial NOT NULL,
 country     varchar(100) NOT NULL,
 city        varchar(100) NULL,
 "state"       varchar(100) NULL,
 postal_code int NULL,
 region      varchar(100) NULL,
 CONSTRAINT PK_325 PRIMARY KEY ( address_id )
);

-- ************************************** model.calendar

CREATE TABLE model.calendar
(
 order_date date NOT NULL,
 ship_date  date NOT NULL,
 year       int NULL,
 quarter    varchar(10) NULL,
 month      int NULL,
 week       int NULL,
 week_day   int NULL,
 CONSTRAINT PK_356 PRIMARY KEY ( order_date, ship_date )
);

-- ************************************** model.products

CREATE TABLE model.products
(
 product_id     serial NOT NULL,
 product_name   varchar(250) NOT NULL,
 category       varchar(250) NULL,
 sub_category   varchar(250) NULL,
 product_id_ext varchar(25) NULL,
 CONSTRAINT PK_323 PRIMARY KEY ( product_id )
);


-- ************************************** model.customers

CREATE TABLE model.customers
(
 customer_id   serial NOT NULL,
 customer_name varchar(200) NOT NULL,
 code          varchar(50) NOT NULL,
 segment       varchar(50) NULL,
 CONSTRAINT PK_324 PRIMARY KEY ( customer_id )
);

-- ************************************** model.shipments

CREATE TABLE model.shipments
(
 shipment_id   serial NOT NULL,
 shipment_mode varchar(50) NOT NULL,
 CONSTRAINT PK_65 PRIMARY KEY ( shipment_id )
);


-- ************************************** model.sales

CREATE TABLE model.sales
(
 "id"          serial NOT NULL,
 reterned    varchar(5) NULL,
 sales       int NOT NULL,
 quantity    int NOT NULL,
 discount    int NULL,
 profit      int NOT NULL,
 order_id    varchar(50) NOT NULL,
 order_date  date NOT NULL,
 ship_date   date NOT NULL,
 customer_id serial NOT NULL,
 shipment_id serial NOT NULL,
 address_id  serial NOT NULL,
 product_id  serial NOT NULL,
 CONSTRAINT PK_385 PRIMARY KEY ( "id", order_date, ship_date, customer_id, shipment_id, address_id, product_id ),
 CONSTRAINT FK_358 FOREIGN KEY ( order_date, ship_date ) REFERENCES model.calendar ( order_date, ship_date ),
 CONSTRAINT FK_362 FOREIGN KEY ( customer_id ) REFERENCES model.customers ( customer_id ),
 CONSTRAINT FK_365 FOREIGN KEY ( shipment_id ) REFERENCES model.shipments ( shipment_id ),
 CONSTRAINT FK_368 FOREIGN KEY ( address_id ) REFERENCES model.addresses ( address_id ),
 CONSTRAINT FK_371 FOREIGN KEY ( product_id ) REFERENCES model.products ( product_id )
);

CREATE INDEX fkIdx_361 ON model.sales
(
 order_date,
 ship_date
);

CREATE INDEX fkIdx_364 ON model.sales
(
 customer_id
);

CREATE INDEX fkIdx_367 ON model.sales
(
 shipment_id
);

CREATE INDEX fkIdx_370 ON model.sales
(
 address_id
);

CREATE INDEX fkIdx_376 ON model.sales
(
 product_id
);
