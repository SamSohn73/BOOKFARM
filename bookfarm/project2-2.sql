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
	country_idx		int				NOT NULL DEFAULT '113',
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


DROP TABLE IF EXISTS country;
CREATE TABLE country (
	idx				int			NOT NULL auto_increment primary key,
--	name			varchar(64) NOT NULL,
	name_eng		varchar(64)	NOT NULL,
	iso_code_2		char(2)		NOT NULL,
	iso_code_3		char(3)		NOT NULL
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;


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


DROP TABLE IF EXISTS currency;
CREATE TABLE currency (
	idx					int				NOT NULL auto_increment primary key,
	title				varchar(32)	NOT NULL,
	code				char(3)		NOT NULL,
	symbol_left			varchar(12),
	symbol_right		varchar(12),
	decimal_point		char(1),
	thousands_point		char(1),
	decimal_places		char(1),
	worth				float(13,8),
	last_updated		date NULL
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


DROP TABLE IF EXISTS newsletter;
CREATE TABLE newsletter (
	idx			int auto_increment primary key,
	title		varchar(255)	NOT NULL,
	content		text			NOT NULL,
	date_added	date			NOT NULL,
	date_sent	date,
	status		int(1),
	locked		int(1) DEFAULT '0'
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;



DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
	idx						int				NOT NULL auto_increment primary key,
	customers_idx			int				NOT NULL,
	
	delivery_name			varchar(255)	NOT NULL,
	delivery_country_idx	int				NOT NULL DEFAULT '113',
	delivery_postcode		varchar(64)		NOT NULL,
	delivery_address1		varchar(64)		NOT NULL,
	delivery_address2		varchar(64)		NOT NULL,
	delivery_phone1			varchar(64)		NOT NULL,
	delivery_phone2			varchar(64),
	delivery_phone3			varchar(64),
	delivery_email1			varchar(64)		NOT NULL UNIQUE,
	delivery_email2			varchar(64)		UNIQUE,
	
	billing_name			varchar(255)	NOT NULL,
	billing_country_idx		int				NOT NULL DEFAULT '113',
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
	currency				char(3),
	currency_value			decimal(14,6)
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


DROP TABLE IF EXISTS product_image;
CREATE TABLE product_image (
	idx				int NOT NULL auto_increment primary key,
	products_idx	int NOT NULL,
	image_path		varchar(64)
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
INSERT INTO currency VALUES (1,'Korea Won','KRW','W','','',',','','1100', now());
INSERT INTO currency VALUES (2,'U.S. Dollar','USD','$','','.',',','2','1.0000', now());
INSERT INTO currency VALUES (3,'Euro','EUR','','€','.',',','2','0.8400', now());



INSERT INTO country VALUES (1,'Afghanistan','AF','AFG','1');
INSERT INTO country VALUES (2,'Albania','AL','ALB','1');
INSERT INTO country VALUES (3,'Algeria','DZ','DZA','1');
INSERT INTO country VALUES (4,'American Samoa','AS','ASM','1');
INSERT INTO country VALUES (5,'Andorra','AD','AND','1');
INSERT INTO country VALUES (6,'Angola','AO','AGO','1');
INSERT INTO country VALUES (7,'Anguilla','AI','AIA','1');
INSERT INTO country VALUES (8,'Antarctica','AQ','ATA','1');
INSERT INTO country VALUES (9,'Antigua and Barbuda','AG','ATG','1');
INSERT INTO country VALUES (10,'Argentina','AR','ARG','1');
INSERT INTO country VALUES (11,'Armenia','AM','ARM','1');
INSERT INTO country VALUES (12,'Aruba','AW','ABW','1');
INSERT INTO country VALUES (13,'Australia','AU','AUS','1');
INSERT INTO country VALUES (14,'Austria','AT','AUT','5');
INSERT INTO country VALUES (15,'Azerbaijan','AZ','AZE','1');
INSERT INTO country VALUES (16,'Bahamas','BS','BHS','1');
INSERT INTO country VALUES (17,'Bahrain','BH','BHR','1');
INSERT INTO country VALUES (18,'Bangladesh','BD','BGD','1');
INSERT INTO country VALUES (19,'Barbados','BB','BRB','1');
INSERT INTO country VALUES (20,'Belarus','BY','BLR','1');
INSERT INTO country VALUES (21,'Belgium','BE','BEL','1');
INSERT INTO country VALUES (22,'Belize','BZ','BLZ','1');
INSERT INTO country VALUES (23,'Benin','BJ','BEN','1');
INSERT INTO country VALUES (24,'Bermuda','BM','BMU','1');
INSERT INTO country VALUES (25,'Bhutan','BT','BTN','1');
INSERT INTO country VALUES (26,'Bolivia','BO','BOL','1');
INSERT INTO country VALUES (27,'Bosnia and Herzegowina','BA','BIH','1');
INSERT INTO country VALUES (28,'Botswana','BW','BWA','1');
INSERT INTO country VALUES (29,'Bouvet Island','BV','BVT','1');
INSERT INTO country VALUES (30,'Brazil','BR','BRA','1');
INSERT INTO country VALUES (31,'British Indian Ocean Territory','IO','IOT','1');
INSERT INTO country VALUES (32,'Brunei Darussalam','BN','BRN','1');
INSERT INTO country VALUES (33,'Bulgaria','BG','BGR','1');
INSERT INTO country VALUES (34,'Burkina Faso','BF','BFA','1');
INSERT INTO country VALUES (35,'Burundi','BI','BDI','1');
INSERT INTO country VALUES (36,'Cambodia','KH','KHM','1');
INSERT INTO country VALUES (37,'Cameroon','CM','CMR','1');
INSERT INTO country VALUES (38,'Canada','CA','CAN','1');
INSERT INTO country VALUES (39,'Cape Verde','CV','CPV','1');
INSERT INTO country VALUES (40,'Cayman Islands','KY','CYM','1');
INSERT INTO country VALUES (41,'Central African Republic','CF','CAF','1');
INSERT INTO country VALUES (42,'Chad','TD','TCD','1');
INSERT INTO country VALUES (43,'Chile','CL','CHL','1');
INSERT INTO country VALUES (44,'China','CN','CHN','1');
INSERT INTO country VALUES (45,'Christmas Island','CX','CXR','1');
INSERT INTO country VALUES (46,'Cocos (Keeling) Islands','CC','CCK','1');
INSERT INTO country VALUES (47,'Colombia','CO','COL','1');
INSERT INTO country VALUES (48,'Comoros','KM','COM','1');
INSERT INTO country VALUES (49,'Congo','CG','COG','1');
INSERT INTO country VALUES (50,'Cook Islands','CK','COK','1');
INSERT INTO country VALUES (51,'Costa Rica','CR','CRI','1');
INSERT INTO country VALUES (52,'Cote D\'Ivoire','CI','CIV','1');
INSERT INTO country VALUES (53,'Croatia','HR','HRV','1');
INSERT INTO country VALUES (54,'Cuba','CU','CUB','1');
INSERT INTO country VALUES (55,'Cyprus','CY','CYP','1');
INSERT INTO country VALUES (56,'Czech Republic','CZ','CZE','1');
INSERT INTO country VALUES (57,'Denmark','DK','DNK','1');
INSERT INTO country VALUES (58,'Djibouti','DJ','DJI','1');
INSERT INTO country VALUES (59,'Dominica','DM','DMA','1');
INSERT INTO country VALUES (60,'Dominican Republic','DO','DOM','1');
INSERT INTO country VALUES (61,'East Timor','TP','TMP','1');
INSERT INTO country VALUES (62,'Ecuador','EC','ECU','1');
INSERT INTO country VALUES (63,'Egypt','EG','EGY','1');
INSERT INTO country VALUES (64,'El Salvador','SV','SLV','1');
INSERT INTO country VALUES (65,'Equatorial Guinea','GQ','GNQ','1');
INSERT INTO country VALUES (66,'Eritrea','ER','ERI','1');
INSERT INTO country VALUES (67,'Estonia','EE','EST','1');
INSERT INTO country VALUES (68,'Ethiopia','ET','ETH','1');
INSERT INTO country VALUES (69,'Falkland Islands (Malvinas)','FK','FLK','1');
INSERT INTO country VALUES (70,'Faroe Islands','FO','FRO','1');
INSERT INTO country VALUES (71,'Fiji','FJ','FJI','1');
INSERT INTO country VALUES (72,'Finland','FI','FIN','1');
INSERT INTO country VALUES (73,'France','FR','FRA','1');
INSERT INTO country VALUES (74,'France, Metropolitan','FX','FXX','1');
INSERT INTO country VALUES (75,'French Guiana','GF','GUF','1');
INSERT INTO country VALUES (76,'French Polynesia','PF','PYF','1');
INSERT INTO country VALUES (77,'French Southern Territories','TF','ATF','1');
INSERT INTO country VALUES (78,'Gabon','GA','GAB','1');
INSERT INTO country VALUES (79,'Gambia','GM','GMB','1');
INSERT INTO country VALUES (80,'Georgia','GE','GEO','1');
INSERT INTO country VALUES (81,'Germany','DE','DEU','5');
INSERT INTO country VALUES (82,'Ghana','GH','GHA','1');
INSERT INTO country VALUES (83,'Gibraltar','GI','GIB','1');
INSERT INTO country VALUES (84,'Greece','GR','GRC','1');
INSERT INTO country VALUES (85,'Greenland','GL','GRL','1');
INSERT INTO country VALUES (86,'Grenada','GD','GRD','1');
INSERT INTO country VALUES (87,'Guadeloupe','GP','GLP','1');
INSERT INTO country VALUES (88,'Guam','GU','GUM','1');
INSERT INTO country VALUES (89,'Guatemala','GT','GTM','1');
INSERT INTO country VALUES (90,'Guinea','GN','GIN','1');
INSERT INTO country VALUES (91,'Guinea-bissau','GW','GNB','1');
INSERT INTO country VALUES (92,'Guyana','GY','GUY','1');
INSERT INTO country VALUES (93,'Haiti','HT','HTI','1');
INSERT INTO country VALUES (94,'Heard and Mc Donald Islands','HM','HMD','1');
INSERT INTO country VALUES (95,'Honduras','HN','HND','1');
INSERT INTO country VALUES (96,'Hong Kong','HK','HKG','1');
INSERT INTO country VALUES (97,'Hungary','HU','HUN','1');
INSERT INTO country VALUES (98,'Iceland','IS','ISL','1');
INSERT INTO country VALUES (99,'India','IN','IND','1');
INSERT INTO country VALUES (100,'Indonesia','ID','IDN','1');
INSERT INTO country VALUES (101,'Iran (Islamic Republic of)','IR','IRN','1');
INSERT INTO country VALUES (102,'Iraq','IQ','IRQ','1');
INSERT INTO country VALUES (103,'Ireland','IE','IRL','1');
INSERT INTO country VALUES (104,'Israel','IL','ISR','1');
INSERT INTO country VALUES (105,'Italy','IT','ITA','1');
INSERT INTO country VALUES (106,'Jamaica','JM','JAM','1');
INSERT INTO country VALUES (107,'Japan','JP','JPN','1');
INSERT INTO country VALUES (108,'Jordan','JO','JOR','1');
INSERT INTO country VALUES (109,'Kazakhstan','KZ','KAZ','1');
INSERT INTO country VALUES (110,'Kenya','KE','KEN','1');
INSERT INTO country VALUES (111,'Kiribati','KI','KIR','1');
INSERT INTO country VALUES (112,'Korea, Democratic People\'s Republic of','KP','PRK','1');
INSERT INTO country VALUES (113,'Korea, Republic of','KR','KOR','1');
INSERT INTO country VALUES (114,'Kuwait','KW','KWT','1');
INSERT INTO country VALUES (115,'Kyrgyzstan','KG','KGZ','1');
INSERT INTO country VALUES (116,'Lao People\'s Democratic Republic','LA','LAO','1');
INSERT INTO country VALUES (117,'Latvia','LV','LVA','1');
INSERT INTO country VALUES (118,'Lebanon','LB','LBN','1');
INSERT INTO country VALUES (119,'Lesotho','LS','LSO','1');
INSERT INTO country VALUES (120,'Liberia','LR','LBR','1');
INSERT INTO country VALUES (121,'Libyan Arab Jamahiriya','LY','LBY','1');
INSERT INTO country VALUES (122,'Liechtenstein','LI','LIE','1');
INSERT INTO country VALUES (123,'Lithuania','LT','LTU','1');
INSERT INTO country VALUES (124,'Luxembourg','LU','LUX','1');
INSERT INTO country VALUES (125,'Macau','MO','MAC','1');
INSERT INTO country VALUES (126,'Macedonia, The Former Yugoslav Republic of','MK','MKD','1');
INSERT INTO country VALUES (127,'Madagascar','MG','MDG','1');
INSERT INTO country VALUES (128,'Malawi','MW','MWI','1');
INSERT INTO country VALUES (129,'Malaysia','MY','MYS','1');
INSERT INTO country VALUES (130,'Maldives','MV','MDV','1');
INSERT INTO country VALUES (131,'Mali','ML','MLI','1');
INSERT INTO country VALUES (132,'Malta','MT','MLT','1');
INSERT INTO country VALUES (133,'Marshall Islands','MH','MHL','1');
INSERT INTO country VALUES (134,'Martinique','MQ','MTQ','1');
INSERT INTO country VALUES (135,'Mauritania','MR','MRT','1');
INSERT INTO country VALUES (136,'Mauritius','MU','MUS','1');
INSERT INTO country VALUES (137,'Mayotte','YT','MYT','1');
INSERT INTO country VALUES (138,'Mexico','MX','MEX','1');
INSERT INTO country VALUES (139,'Micronesia, Federated States of','FM','FSM','1');
INSERT INTO country VALUES (140,'Moldova, Republic of','MD','MDA','1');
INSERT INTO country VALUES (141,'Monaco','MC','MCO','1');
INSERT INTO country VALUES (142,'Mongolia','MN','MNG','1');
INSERT INTO country VALUES (143,'Montserrat','MS','MSR','1');
INSERT INTO country VALUES (144,'Morocco','MA','MAR','1');
INSERT INTO country VALUES (145,'Mozambique','MZ','MOZ','1');
INSERT INTO country VALUES (146,'Myanmar','MM','MMR','1');
INSERT INTO country VALUES (147,'Namibia','NA','NAM','1');
INSERT INTO country VALUES (148,'Nauru','NR','NRU','1');
INSERT INTO country VALUES (149,'Nepal','NP','NPL','1');
INSERT INTO country VALUES (150,'Netherlands','NL','NLD','1');
INSERT INTO country VALUES (151,'Netherlands Antilles','AN','ANT','1');
INSERT INTO country VALUES (152,'New Caledonia','NC','NCL','1');
INSERT INTO country VALUES (153,'New Zealand','NZ','NZL','1');
INSERT INTO country VALUES (154,'Nicaragua','NI','NIC','1');
INSERT INTO country VALUES (155,'Niger','NE','NER','1');
INSERT INTO country VALUES (156,'Nigeria','NG','NGA','1');
INSERT INTO country VALUES (157,'Niue','NU','NIU','1');
INSERT INTO country VALUES (158,'Norfolk Island','NF','NFK','1');
INSERT INTO country VALUES (159,'Northern Mariana Islands','MP','MNP','1');
INSERT INTO country VALUES (160,'Norway','NO','NOR','1');
INSERT INTO country VALUES (161,'Oman','OM','OMN','1');
INSERT INTO country VALUES (162,'Pakistan','PK','PAK','1');
INSERT INTO country VALUES (163,'Palau','PW','PLW','1');
INSERT INTO country VALUES (164,'Panama','PA','PAN','1');
INSERT INTO country VALUES (165,'Papua New Guinea','PG','PNG','1');
INSERT INTO country VALUES (166,'Paraguay','PY','PRY','1');
INSERT INTO country VALUES (167,'Peru','PE','PER','1');
INSERT INTO country VALUES (168,'Philippines','PH','PHL','1');
INSERT INTO country VALUES (169,'Pitcairn','PN','PCN','1');
INSERT INTO country VALUES (170,'Poland','PL','POL','1');
INSERT INTO country VALUES (171,'Portugal','PT','PRT','1');
INSERT INTO country VALUES (172,'Puerto Rico','PR','PRI','1');
INSERT INTO country VALUES (173,'Qatar','QA','QAT','1');
INSERT INTO country VALUES (174,'Reunion','RE','REU','1');
INSERT INTO country VALUES (175,'Romania','RO','ROM','1');
INSERT INTO country VALUES (176,'Russian Federation','RU','RUS','1');
INSERT INTO country VALUES (177,'Rwanda','RW','RWA','1');
INSERT INTO country VALUES (178,'Saint Kitts and Nevis','KN','KNA','1');
INSERT INTO country VALUES (179,'Saint Lucia','LC','LCA','1');
INSERT INTO country VALUES (180,'Saint Vincent and the Grenadines','VC','VCT','1');
INSERT INTO country VALUES (181,'Samoa','WS','WSM','1');
INSERT INTO country VALUES (182,'San Marino','SM','SMR','1');
INSERT INTO country VALUES (183,'Sao Tome and Principe','ST','STP','1');
INSERT INTO country VALUES (184,'Saudi Arabia','SA','SAU','1');
INSERT INTO country VALUES (185,'Senegal','SN','SEN','1');
INSERT INTO country VALUES (186,'Seychelles','SC','SYC','1');
INSERT INTO country VALUES (187,'Sierra Leone','SL','SLE','1');
INSERT INTO country VALUES (188,'Singapore','SG','SGP', '4');
INSERT INTO country VALUES (189,'Slovakia (Slovak Republic)','SK','SVK','1');
INSERT INTO country VALUES (190,'Slovenia','SI','SVN','1');
INSERT INTO country VALUES (191,'Solomon Islands','SB','SLB','1');
INSERT INTO country VALUES (192,'Somalia','SO','SOM','1');
INSERT INTO country VALUES (193,'South Africa','ZA','ZAF','1');
INSERT INTO country VALUES (194,'South Georgia and the South Sandwich Islands','GS','SGS','1');
INSERT INTO country VALUES (195,'Spain','ES','ESP','3');
INSERT INTO country VALUES (196,'Sri Lanka','LK','LKA','1');
INSERT INTO country VALUES (197,'St. Helena','SH','SHN','1');
INSERT INTO country VALUES (198,'St. Pierre and Miquelon','PM','SPM','1');
INSERT INTO country VALUES (199,'Sudan','SD','SDN','1');
INSERT INTO country VALUES (200,'Suriname','SR','SUR','1');
INSERT INTO country VALUES (201,'Svalbard and Jan Mayen Islands','SJ','SJM','1');
INSERT INTO country VALUES (202,'Swaziland','SZ','SWZ','1');
INSERT INTO country VALUES (203,'Sweden','SE','SWE','1');
INSERT INTO country VALUES (204,'Switzerland','CH','CHE','1');
INSERT INTO country VALUES (205,'Syrian Arab Republic','SY','SYR','1');
INSERT INTO country VALUES (206,'Taiwan','TW','TWN','1');
INSERT INTO country VALUES (207,'Tajikistan','TJ','TJK','1');
INSERT INTO country VALUES (208,'Tanzania, United Republic of','TZ','TZA','1');
INSERT INTO country VALUES (209,'Thailand','TH','THA','1');
INSERT INTO country VALUES (210,'Togo','TG','TGO','1');
INSERT INTO country VALUES (211,'Tokelau','TK','TKL','1');
INSERT INTO country VALUES (212,'Tonga','TO','TON','1');
INSERT INTO country VALUES (213,'Trinidad and Tobago','TT','TTO','1');
INSERT INTO country VALUES (214,'Tunisia','TN','TUN','1');
INSERT INTO country VALUES (215,'Turkey','TR','TUR','1');
INSERT INTO country VALUES (216,'Turkmenistan','TM','TKM','1');
INSERT INTO country VALUES (217,'Turks and Caicos Islands','TC','TCA','1');
INSERT INTO country VALUES (218,'Tuvalu','TV','TUV','1');
INSERT INTO country VALUES (219,'Uganda','UG','UGA','1');
INSERT INTO country VALUES (220,'Ukraine','UA','UKR','1');
INSERT INTO country VALUES (221,'United Arab Emirates','AE','ARE','1');
INSERT INTO country VALUES (222,'United Kingdom','GB','GBR','1');
INSERT INTO country VALUES (223,'United States','US','USA', '2');
INSERT INTO country VALUES (224,'United States Minor Outlying Islands','UM','UMI','1');
INSERT INTO country VALUES (225,'Uruguay','UY','URY','1');
INSERT INTO country VALUES (226,'Uzbekistan','UZ','UZB','1');
INSERT INTO country VALUES (227,'Vanuatu','VU','VUT','1');
INSERT INTO country VALUES (228,'Vatican City State (Holy See)','VA','VAT','1');
INSERT INTO country VALUES (229,'Venezuela','VE','VEN','1');
INSERT INTO country VALUES (230,'Viet Nam','VN','VNM','1');
INSERT INTO country VALUES (231,'Virgin Islands (British)','VG','VGB','1');
INSERT INTO country VALUES (232,'Virgin Islands (U.S.)','VI','VIR','1');
INSERT INTO country VALUES (233,'Wallis and Futuna Islands','WF','WLF','1');
INSERT INTO country VALUES (234,'Western Sahara','EH','ESH','1');
INSERT INTO country VALUES (235,'Yemen','YE','YEM','1');
INSERT INTO country VALUES (236,'Yugoslavia','YU','YUG','1');
INSERT INTO country VALUES (237,'Zaire','ZR','ZAR','1');
INSERT INTO country VALUES (238,'Zambia','ZM','ZMB','1');
INSERT INTO country VALUES (239,'Zimbabwe','ZW','ZWE','1');
