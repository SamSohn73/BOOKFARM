--
-- DWIT Class 3 Second java project for Small Shopping mall
--
DROP DATABASE IF EXISTS bookfarm;
CREATE DATABASE bookfarm;

USE bookfarm;


DROP TABLE IF EXISTS customer;
CREATE TABLE customer (
	idx				int				NOT NULL auto_increment primary key,
	username		varchar(64)		NOT NULL,
	password		varchar(64)		NOT NULL,
	firstname		varchar(64)		NOT NULL,
	lastname		varchar(64)		NOT NULL,
	postcode		varchar(64)		NOT NULL,
	address1		varchar(64)		NOT NULL,
	address2		varchar(64)		NOT NULL,
	
	phone1			varchar(64)		NOT NULL,
	phone2			varchar(64),
	phone3			varchar(64),
	email1			varchar(64)		NOT NULL UNIQUE,
	email2			varchar(64)		UNIQUE,
	
	gender			char(1)			NOT NULL,
	newsletter		char(1)			NOT NULL,
	birthday		date			NOT NULL,
	grade			int DEFAULT '0'	NOT NULL,
	last_login		date,
	login_cnt		int(5),
	account_created	date,
	
	on_line			char(1)			NOT NULL
) CHARACTER SET utf8 COLLATE utf8_unicode_ci; -- You should use utf8_unicode_ci for using emoji


DROP TABLE IF EXISTS admin;
CREATE TABLE admin (
	idx				int				NOT NULL auto_increment primary key,
	user_name		varchar(64)		binary NOT NULL,
	user_pass		varchar(64)		NOT NULL
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;


DROP TABLE IF EXISTS category;
CREATE TABLE category (
	idx					int				NOT NULL auto_increment primary key,
	parent_idx			int DEFAULT '0'	NOT NULL,
--	categories_image	varchar(64),
	category_name		varchar(32)		NOT NULL
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;


DROP TABLE IF EXISTS basket;
CREATE TABLE basket (
	idx				int			NOT NULL auto_increment primary key,
	customer_idx	int			NOT NULL,
	product_idx		int			NOT NULL,
	quantity		int			NOT NULL,
	options			varchar(255),
	final_price		decimal(15,4),
	date_added		date
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;


DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
	idx						int				NOT NULL auto_increment primary key,
	customers_idx			int				NOT NULL,
	
	delivery_name			varchar(255)	NOT NULL,
	delivery_postcode		varchar(64)		NOT NULL,
	delivery_address1		varchar(64)		NOT NULL,
	delivery_address2		varchar(64)		NOT NULL,
	delivery_phone1			varchar(64)		NOT NULL,
	delivery_phone2			varchar(64),
	delivery_phone3			varchar(64),
	delivery_email1			varchar(64)		NOT NULL UNIQUE,
	delivery_email2			varchar(64)		UNIQUE,
	
	billing_name			varchar(255)	NOT NULL,
	billing_postcode		varchar(64)		NOT NULL,
	billing_address1		varchar(64)		NOT NULL,
	billing_address2		varchar(64)		NOT NULL,
	billing_phone1			varchar(64)		NOT NULL,
	billing_phone2			varchar(64),
	billing_phone3			varchar(64),
	billing_email1			varchar(64)		NOT NULL UNIQUE,
	billing_email2			varchar(64)		UNIQUE,  
	
	payment_method			varchar(255)	NOT NULL,
	final_price				decimal(15,4)	NOT NULL,
	
	last_modified			date,
	date_purchased			date,
	orders_status			int(5)			NOT NULL,
	orders_date_finished	date,
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;


DROP TABLE IF EXISTS orders_product;
CREATE TABLE orders_product (
	idx					int				NOT NULL auto_increment primary key,
	orders_idx			int				NOT NULL,
	products_idx		int				NOT NULL,
	products_quantity	int(2)			NOT NULL,
	final_price			decimal(15,4)	NOT NULL
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;


DROP TABLE IF EXISTS product;
CREATE TABLE product (
	idx					int				NOT NULL auto_increment primary key,
	category_idx		int				NOT NULL,
	product_quantity	int(4)			NOT NULL,
	product_name		varchar(12),
	product_image		varchar(64),
	product_price		decimal(15,4)	NOT NULL,
	product_desc		text
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;


DROP TABLE IF EXISTS review;
CREATE TABLE review (
	idx				int				NOT NULL auto_increment primary key,
	products_idx	int				NOT NULL,
	customers_idx	int,
	reviews_rating	int(1),
	review_title	varchar(255)	NOT NULL,
	review_text		text			NOT NULL,
	date_added		date,
	last_modified	date,
	reviews_read	int(5)			NOT NULL default '0'
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;


create table postcode (
	idx				int				auto_increment primary key,
	zip				int				not null unique,
	si_do			varchar(20)		not null,
	si_gu_gun		varchar(20)		not null,
	eup_myun		varchar(20)		not null,
	li				varchar(20)		not null,
	road			varchar(80)		not null,
	longaddr		varchar(1000)	not null
);


--
-- data
--
insert into admin (user_name, user_pass) values ("admin", "12345");



