--script to create Clearwater Traders database
--revised 8/17/02 JM
create table sales
(id numeric(3) primary key,
name char(20),
dept char(20),
total_sales numeric(10,2))
insert into sales values(1,'Bob','Toyota',30000)
insert into sales values(2,'Mary','Toyota',40000)
insert into sales values(3,'Bill','Lexus',80000)
insert into sales values(4,'Larry','Lexus',90000)

DROP TABLE order_line ;
DROP TABLE shipment_line ;
DROP TABLE shipment ;
DROP TABLE inventory ;
DROP TABLE color ;
DROP TABLE item ;
DROP TABLE category ;
DROP TABLE orders ;
DROP TABLE order_source ;
DROP TABLE customer ;

CREATE TABLE customer
(c_id numeric(5), 
c_last varchar(30),
c_first varchar(30),
c_mi CHAR(1),
c_birthdate datetime,
c_address varchar(30),
c_city varchar(30),
c_state CHAR(2),
c_zip varchar(10),
c_dphone varchar(10),
c_ephone varchar(10),
c_userid varchar(50),
c_password varchar(15),
c_married char(1),
c_house char(1),
c_num_children numeric(2),
CONSTRAINT customer_c_id_pk PRIMARY KEY (c_id));

CREATE TABLE order_source
(os_id numeric(3),
os_desc varchar(30),
CONSTRAINT order_source_os_id_pk PRIMARY KEY(os_id));

CREATE TABLE orders
(o_id numeric(8), 
o_date datetime,
o_methpmt varchar(10),
c_id numeric(5),
os_id numeric(3),
CONSTRAINT orders_o_id_pk PRIMARY KEY (o_id),
CONSTRAINT orders_c_id_fk FOREIGN KEY (c_id) REFERENCES customer(c_id),
CONSTRAINT orders_os_id_fk FOREIGN KEY (os_id) REFERENCES order_source(os_id));

CREATE TABLE category
(cat_id numeric(2),
cat_desc varchar(20),
CONSTRAINT category_cat_id_pk PRIMARY KEY (cat_id));

CREATE TABLE item
(item_id numeric(8),
item_desc varchar(30),
cat_id numeric(2),
item_image char(1),
CONSTRAINT item_item_id_pk PRIMARY KEY (item_id),
CONSTRAINT item_cat_id_fk FOREIGN KEY (cat_id) REFERENCES category(cat_id));

CREATE TABLE color
(color varchar(20),
CONSTRAINT color_color_pk PRIMARY KEY (color));

CREATE TABLE inventory
(inv_id numeric(10),
item_id numeric(8),
color varchar(20),
inv_size varchar(10),
inv_price numeric(6,2),
inv_qoh numeric(4),
CONSTRAINT inventory_inv_id_pk PRIMARY KEY (inv_id),
CONSTRAINT inventory_item_id_fk FOREIGN KEY (item_id) REFERENCES item(item_id),
CONSTRAINT inventory_color_fk FOREIGN KEY (color) REFERENCES color(color));

CREATE TABLE shipment
(ship_id numeric(10),
ship_date_expected datetime,
CONSTRAINT shipment_ship_id_pk PRIMARY KEY (ship_id));

CREATE TABLE shipment_line
(ship_id numeric(10), 
inv_id numeric(10),
sl_quantity numeric(4),
sl_date_received datetime, 
CONSTRAINT shipment_line_ship_id_fk FOREIGN KEY (ship_id) REFERENCES shipment(ship_id),
CONSTRAINT shipment_line_inv_id_fk FOREIGN KEY (inv_id) REFERENCES inventory(inv_id),
CONSTRAINT shipment_line_shipid_invid_pk PRIMARY KEY(ship_id, inv_id));

CREATE TABLE order_line 
(o_id numeric(8), 
inv_id numeric(10), 
ol_quantity numeric(4) NOT NULL,  
CONSTRAINT order_line_o_id_fk FOREIGN KEY (o_id) REFERENCES orders(o_id),
CONSTRAINT order_line_inv_id_fk FOREIGN KEY (inv_id) REFERENCES inventory(inv_id),
CONSTRAINT order_line_oid_invid_pk PRIMARY KEY (o_id, inv_id));


--- inserting records into CUSTOMER
INSERT INTO CUSTOMER VALUES
(1, 'Harris', 'Paula', 'E', convert(datetime,'04/09/1953', 101), '1156 Water Street, Apt. #3', 'Osseo', 'WI', 
'54705', '7155558943', '7155559035', 'harrispe', 'asdfjk','Y','N',1);

INSERT INTO CUSTOMER VALUES
(2, 'Garcia', 'Maria', 'H', convert(datetime,'07/14/1958', 101), '2211 Pine Drive', 'Radisson', 'WI', 
'54867', '7155558332', '7155558332', 'garciamm', '12345','N','N',0);

INSERT INTO CUSTOMER VALUES
(3, 'Miller', 'Lee', NULL, convert(datetime,'01/05/1936', 101), '699 Pluto St. NW', 'Silver Lake', 'WI', 
'53821', '7155554978', '7155559002', 'millerl', 'zxcvb','Y','Y',2);

INSERT INTO CUSTOMER VALUES
(4, 'Chang', 'Alissa', 'R', convert(datetime,'10/01/1976', 101), '987 Durham Rd.', 'Apple Valley', 'MN', 
'55712', '7155557651', '7155550087', 'changar', 'qwerui','Y','Y',2);

INSERT INTO CUSTOMER VALUES
(5, 'Edwards', 'Mitch', 'M', convert(datetime,'11/20/1986', 101), '4204 Garner Street', 'Washburn', 'WI', 
'54891', '7155558243', '7155556975', 'edwardsmm', 'qwerty','N','Y',0);

INSERT INTO CUSTOMER VALUES
(6, 'Nelson', 'Kyle', 'E', convert(datetime,'12/04/1984', 101), '232 Echo Rd.', 'Minnetonka', 'MN', 
'55438', '7151113333', '7155552222', 'nelsonke', 'clever','N','N',0);

--- inserting records into ORDER_SOURCE
INSERT INTO order_source VALUES (1, 'Winter 2005');
INSERT INTO order_source VALUES (2, 'Spring 2006');
INSERT INTO order_source VALUES (3, 'Summer 2006');
INSERT INTO order_source VALUES (4, 'Outdoor 2006');
INSERT INTO order_source VALUES (5, 'Children''s 2006');
INSERT INTO order_source VALUES (6, 'Web Site');

--- inserting records into orders
INSERT INTO orders VALUES
(1, convert(datetime,'05/29/2006', 101), 'CC', 1, 2);

INSERT INTO orders VALUES
(2, convert(datetime,'05/29/2006', 101), 'CC', 5, 6);

INSERT INTO orders VALUES
(3, convert(datetime,'05/31/2006', 101), 'CHECK', 2, 2);

INSERT INTO orders VALUES
(4, convert(datetime,'05/31/2006', 101), 'CC', 3, 3);

INSERT INTO orders VALUES
(5, convert(datetime,'06/01/2006', 101), 'CC', 4, 6);

INSERT INTO orders VALUES
(6, convert(datetime,'06/01/2006', 101), 'CC', 6, 3);

--- inserting records into CATEGORY
INSERT INTO category VALUES (1, 'Women''s Clothing');
INSERT INTO category VALUES (2, 'Children''s Clothing');
INSERT INTO category VALUES (3, 'Men''s Clothing');
INSERT INTO category VALUES (4, 'Outdoor Gear');

--- inserting records into ITEM
INSERT INTO item VALUES
(1, 'Men''s Expedition Parka', 3, null);

INSERT INTO item VALUES
(2, '3-Season Tent', 4, null);

INSERT INTO item VALUES
(3, 'Women''s Hiking Shorts', 1, null);

INSERT INTO item VALUES
(4, 'Women''s Fleece Pullover', 1, null);

INSERT INTO item VALUES
(5, 'Children''s Beachcomber Sandals', 2, null);

INSERT INTO item VALUES
(6, 'Boy''s Surf Shorts', 2, null);

INSERT INTO item VALUES
(7, 'Girl''s Soccer Tee', 2, null);

--- inserting records into COLOR
INSERT INTO color VALUES ('Sky Blue');
INSERT INTO color VALUES ('Light Grey');
INSERT INTO color VALUES ('Khaki');
INSERT INTO color VALUES ('Navy');
INSERT INTO color VALUES ('Royal');
INSERT INTO color VALUES ('Eggplant');
INSERT INTO color VALUES ('Blue');
INSERT INTO color VALUES ('Red');
INSERT INTO color VALUES ('Spruce');
INSERT INTO color VALUES ('Turquoise');
INSERT INTO color VALUES ('Bright Pink');
INSERT INTO color VALUES ('White');

--- inserting records into INVENTORY
INSERT INTO inventory VALUES
(1, 2, 'Sky Blue', NULL, 259.99, 16);

INSERT INTO inventory VALUES
(2, 2, 'Light Grey', NULL, 259.99, 12);

INSERT INTO inventory VALUES
(3, 3, 'Khaki', 'S', 29.95, 150);

INSERT INTO inventory VALUES
(4, 3, 'Khaki', 'M', 29.95, 147);

INSERT INTO inventory VALUES
(5, 3, 'Khaki', 'L', 29.95, 0);

INSERT INTO inventory VALUES
(6, 3, 'Navy', 'S', 29.95, 139);

INSERT INTO inventory VALUES
(7, 3, 'Navy', 'M', 29.95, 137);

INSERT INTO inventory VALUES
(8, 3, 'Navy', 'L', 29.95, 115);

INSERT INTO inventory VALUES
(9, 4, 'Eggplant', 'S', 59.95, 135);

INSERT INTO inventory VALUES
(10, 4, 'Eggplant', 'M', 59.95, 168);

INSERT INTO inventory VALUES
(11, 4, 'Eggplant', 'L', 59.95, 187);

INSERT INTO inventory VALUES
(12, 4, 'Royal', 'S', 59.95, 0);

INSERT INTO inventory VALUES
(13, 4, 'Royal', 'M', 59.95, 124);

INSERT INTO inventory VALUES
(14, 4, 'Royal', 'L', 59.95, 112);

INSERT INTO inventory VALUES
(15, 5, 'Turquoise', '10', 15.99, 121);

INSERT INTO inventory VALUES
(16, 5, 'Turquoise', '11', 15.99, 111);

INSERT INTO inventory VALUES
(17, 5, 'Turquoise', '12', 15.99, 113);

INSERT INTO inventory VALUES
(18, 5, 'Turquoise', '1', 15.99, 121);

INSERT INTO inventory VALUES
(19, 5, 'Bright Pink', '10', 15.99, 148);

INSERT INTO inventory VALUES
(20, 5, 'Bright Pink', '11', 15.99, 137);

INSERT INTO inventory VALUES
(21, 5, 'Bright Pink', '12', 15.99, 134);

INSERT INTO inventory VALUES
(22, 5, 'Bright Pink', '1', 15.99, 123);

INSERT INTO inventory VALUES
(23, 1, 'Spruce', 'S', 199.95, 114);

INSERT INTO inventory VALUES
(24, 1,  'Spruce', 'M',199.95, 17);

INSERT INTO inventory VALUES
(25, 1, 'Spruce', 'L', 209.95, 0);

INSERT INTO inventory VALUES
(26, 1, 'Spruce', 'XL', 209.95, 12);

INSERT INTO inventory VALUES
(27, 6, 'Blue', 'S', 15.95, 50);

INSERT INTO inventory VALUES
(28, 6, 'Blue', 'M', 15.95, 100);

INSERT INTO inventory VALUES
(29, 6, 'Blue', 'L', 15.95, 100);

INSERT INTO inventory VALUES
(30, 7, 'White', 'S', 19.99, 100);

INSERT INTO inventory VALUES
(31, 7, 'White', 'M', 19.99, 100);

INSERT INTO inventory VALUES
(32, 7, 'White', 'L', 19.99, 100);

--inserting records into SHIPMENT

INSERT INTO shipment VALUES
(1, convert(datetime,'09/15/2006', 101));

INSERT INTO shipment VALUES
(2, convert(datetime,'11/15/2006', 101));

INSERT INTO shipment VALUES
(3, convert(datetime,'06/25/2006', 101));

INSERT INTO shipment VALUES
(4, convert(datetime,'06/25/2006', 101));

INSERT INTO shipment VALUES
(5, convert(datetime,'08/15/2006', 101));

--inserting records into SHIPMENT_LINE
INSERT INTO shipment_line VALUES
(1, 1, 25, convert(datetime,'09/10/2006', 101));

INSERT INTO shipment_line VALUES
(1, 2, 25, convert(datetime,'09/10/2006', 101));

INSERT INTO shipment_line VALUES
(2, 2, 25, NULL);

INSERT INTO shipment_line VALUES
(3, 5, 200, NULL);

INSERT INTO shipment_line VALUES
(3, 6, 200, NULL);

INSERT INTO shipment_line VALUES
(3, 7, 200, NULL);

INSERT INTO shipment_line VALUES
(4, 12, 100, convert(datetime,'08/15/2006', 101));

INSERT INTO shipment_line VALUES
(4, 13, 100, convert(datetime,'08/25/2006', 101));

INSERT INTO shipment_line VALUES
(5, 23, 50, convert(datetime,'08/15/2006', 101));

INSERT INTO shipment_line VALUES
(5, 24, 100, convert(datetime,'08/15/2006', 101));

INSERT INTO shipment_line VALUES
(5, 25, 100, convert(datetime,'08/15/2006', 101));

--- inserting records into ORDER_LINE
INSERT INTO order_line VALUES (1, 1, 1);
INSERT INTO order_line VALUES (1, 14, 2);
INSERT INTO order_line VALUES (2, 19, 1);
INSERT INTO order_line VALUES (3, 24, 1);
INSERT INTO order_line VALUES (3, 26, 1);
INSERT INTO order_line VALUES (4, 12, 2);
INSERT INTO order_line VALUES (5, 8, 1);
INSERT INTO order_line VALUES (5, 13, 1);
INSERT INTO order_line VALUES (6, 2, 1);
INSERT INTO order_line VALUES (6, 7, 3);
insert into order_line values(3,1,1)
insert into order_line values(3,14,1)
insert into order_line values(6,8,1)
insert into order_line values(6,13,1)


COMMIT;
