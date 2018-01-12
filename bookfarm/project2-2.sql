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
	lastname		varchar(64),
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
	idx				int				NOT NULL auto_increment primary key,
	customer_idx	int DEFAULT '0'	NOT NULL,
	product_idx		int				NOT NULL,
	quantity		int				NOT NULL,
	options			varchar(255),
	final_price		decimal(15,4),
	date_added		date DEFAULT now()
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
	date_added		date DEFAULT now(),
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

insert into category (category_name) values ("국내도서");
insert into category (category_name) values ("해외도서");
insert into category (category_name) values ("eBook");
insert into category (category_name) values ("웹소설");
insert into category (category_name) values ("CD/LP");
insert into category (category_name) values ("DVD/Bluelay");
insert into category (category_name) values ("영화");
insert into category (category_name) values ("공연");
insert into category (category_name) values ("GIFT");
insert into category (category_name) values ("중고");
insert into category (parent_idx, category_name) values (1, "소설");
insert into category (parent_idx, category_name) values (1, "인문");
insert into category (parent_idx, category_name) values (1, "예술");
insert into category (parent_idx, category_name) values (1, "사회");
insert into category (parent_idx, category_name) values (1, "경제");
insert into category (parent_idx, category_name) values (1, "경영");
insert into category (parent_idx, category_name) values (1, "문학");
insert into category (parent_idx, category_name) values (1, "역사");
insert into category (parent_idx, category_name) values (1, "종교");
insert into category (parent_idx, category_name) values (1, "과학");
insert into category (parent_idx, category_name) values (1, "자기개발");
insert into category (parent_idx, category_name) values (1, "만화");
insert into category (parent_idx, category_name) values (1, "여행");
insert into category (parent_idx, category_name) values (1, "어린이");
insert into category (parent_idx, category_name) values (1, "청소년");
insert into category (parent_idx, category_name) values (1, "요리");
insert into category (parent_idx, category_name) values (1, "육아");
insert into category (parent_idx, category_name) values (1, "가정살림");
insert into category (parent_idx, category_name) values (1, "건강");
insert into category (parent_idx, category_name) values (1, "취미");
insert into category (parent_idx, category_name) values (1, "교재");
insert into category (parent_idx, category_name) values (1, "외국어");
insert into category (parent_idx, category_name) values (1, "IT");
insert into category (parent_idx, category_name) values (1, "수험서");
insert into category (parent_idx, category_name) values (1, "참고서");
insert into category (parent_idx, category_name) values (1, "요리");
insert into category (parent_idx, category_name) values (1, "소설");
insert into category (parent_idx, category_name) values (1, "인문");
insert into category (parent_idx, category_name) values (1, "예술");
insert into category (parent_idx, category_name) values (1, "사회");
insert into category (parent_idx, category_name) values (1, "경제");
insert into category (parent_idx, category_name) values (1, "경영");
insert into category (parent_idx, category_name) values (1, "문학");
insert into category (parent_idx, category_name) values (1, "역사");
insert into category (parent_idx, category_name) values (1, "종교");
insert into category (parent_idx, category_name) values (1, "과학");
insert into category (parent_idx, category_name) values (1, "자기개발");
insert into category (parent_idx, category_name) values (1, "만화");
insert into category (parent_idx, category_name) values (1, "여행");
insert into category (parent_idx, category_name) values (1, "어린이");
insert into category (parent_idx, category_name) values (1, "청소년");
insert into category (parent_idx, category_name) values (1, "요리");
insert into category (parent_idx, category_name) values (1, "육아");
insert into category (parent_idx, category_name) values (1, "가정살림");
insert into category (parent_idx, category_name) values (1, "건강");
insert into category (parent_idx, category_name) values (1, "취미");
insert into category (parent_idx, category_name) values (1, "교재");
insert into category (parent_idx, category_name) values (1, "외국어");
insert into category (parent_idx, category_name) values (1, "IT");
insert into category (parent_idx, category_name) values (1, "수험서");
insert into category (parent_idx, category_name) values (1, "참고서");
insert into category (parent_idx, category_name) values (1, "요리");

insert into category (parent_idx, category_name) values (2, "소설");
insert into category (parent_idx, category_name) values (2, "인문");
insert into category (parent_idx, category_name) values (2, "예술");
insert into category (parent_idx, category_name) values (2, "사회");
insert into category (parent_idx, category_name) values (2, "경제");
insert into category (parent_idx, category_name) values (2, "경영");
insert into category (parent_idx, category_name) values (2, "문학");
insert into category (parent_idx, category_name) values (2, "역사");
insert into category (parent_idx, category_name) values (2, "종교");
insert into category (parent_idx, category_name) values (2, "과학");
insert into category (parent_idx, category_name) values (2, "자기개발");
insert into category (parent_idx, category_name) values (2, "만화");
insert into category (parent_idx, category_name) values (2, "여행");
insert into category (parent_idx, category_name) values (2, "어린이");
insert into category (parent_idx, category_name) values (2, "청소년");
insert into category (parent_idx, category_name) values (2, "요리");
insert into category (parent_idx, category_name) values (2, "육아");
insert into category (parent_idx, category_name) values (2, "가정살림");
insert into category (parent_idx, category_name) values (2, "건강");
insert into category (parent_idx, category_name) values (2, "취미");
insert into category (parent_idx, category_name) values (2, "교재");
insert into category (parent_idx, category_name) values (2, "외국어");
insert into category (parent_idx, category_name) values (2, "IT");
insert into category (parent_idx, category_name) values (2, "수험서");
insert into category (parent_idx, category_name) values (2, "참고서");
insert into category (parent_idx, category_name) values (2, "요리");

insert into category (parent_idx, category_name) values (3, "소설");
insert into category (parent_idx, category_name) values (3, "인문");
insert into category (parent_idx, category_name) values (3, "예술");
insert into category (parent_idx, category_name) values (3, "사회");
insert into category (parent_idx, category_name) values (3, "경제");
insert into category (parent_idx, category_name) values (3, "경영");
insert into category (parent_idx, category_name) values (3, "문학");
insert into category (parent_idx, category_name) values (3, "역사");
insert into category (parent_idx, category_name) values (3, "종교");
insert into category (parent_idx, category_name) values (3, "과학");
insert into category (parent_idx, category_name) values (3, "자기개발");
insert into category (parent_idx, category_name) values (3, "만화");
insert into category (parent_idx, category_name) values (3, "여행");
insert into category (parent_idx, category_name) values (3, "어린이");
insert into category (parent_idx, category_name) values (3, "청소년");
insert into category (parent_idx, category_name) values (3, "요리");
insert into category (parent_idx, category_name) values (3, "육아");
insert into category (parent_idx, category_name) values (3, "가정살림");
insert into category (parent_idx, category_name) values (3, "건강");
insert into category (parent_idx, category_name) values (3, "취미");
insert into category (parent_idx, category_name) values (3, "교재");
insert into category (parent_idx, category_name) values (3, "외국어");
insert into category (parent_idx, category_name) values (3, "IT");
insert into category (parent_idx, category_name) values (3, "수험서");
insert into category (parent_idx, category_name) values (3, "참고서");
insert into category (parent_idx, category_name) values (3, "요리");

insert into category (parent_idx, category_name) values (4, "장르");
insert into category (parent_idx, category_name) values (4, "랭킹");
insert into category (parent_idx, category_name) values (4, "신작");
insert into category (parent_idx, category_name) values (4, "완결");

insert into category (parent_idx, category_name) values (5, "가요");
insert into category (parent_idx, category_name) values (5, "클래식");
insert into category (parent_idx, category_name) values (5, "POP");
insert into category (parent_idx, category_name) values (5, "ROCK");
insert into category (parent_idx, category_name) values (5, "JAZZ");
insert into category (parent_idx, category_name) values (5, "OST");
insert into category (parent_idx, category_name) values (5, "어린이");
insert into category (parent_idx, category_name) values (5, "뉴에이지");
insert into category (parent_idx, category_name) values (5, "종교");
insert into category (parent_idx, category_name) values (5, "명상");
insert into category (parent_idx, category_name) values (5, "국악");
insert into category (parent_idx, category_name) values (5, "일본");
insert into category (parent_idx, category_name) values (5, "세계");

insert into category (parent_idx, category_name) values (6, "액션");
insert into category (parent_idx, category_name) values (6, "SF");
insert into category (parent_idx, category_name) values (6, "드라마");
insert into category (parent_idx, category_name) values (6, "코미디");
insert into category (parent_idx, category_name) values (6, "고전");
insert into category (parent_idx, category_name) values (6, "다큐");
insert into category (parent_idx, category_name) values (6, "교육");
insert into category (parent_idx, category_name) values (6, "성인");
insert into category (parent_idx, category_name) values (6, "뮤직");
insert into category (parent_idx, category_name) values (6, "게임");

insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "불멸", "image/불멸.jpg", 15000, "blabla~");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "레모니스니켓", "image/레모니스니켓.jpg", 13000, "고양이 이야기~");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "아이디얼책", "image/아이디얼책.jpg", 17000, "책 분류 이야기");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "조용한그림책", "image/조용한그림책.jpg", 9000, "조용히 읽으렴");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "흰책", "image/흰책.jpg", 8000, "그냥 표지가 하애보였지만 내용은 정반대");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "brick bible", "image/brick bible.jpg", 9000, "종교 이야기");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "fairy tales", "image/fairy tales.jpg", 12000, "요정 이야기 판타지");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "how you lose her", "image/how you lose her.jpg", 7000, "그녀를 잃어버린 어느 남자의 이야기");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "pantone", "image/pantone.jpg", 21000, "판토네가 무엇인지 아는가? 모른다면 이책을 보거라");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "pictorial", "image/pictorial.jpg", 33000, "팩토리얼이 아니다! 픽토리얼 그것은 무엇을 의미하는가");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "pride", "image/pride.jpg", 14000, "너가 버려왔던 자존심 이야기");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "sartorialist", "image/sartorialist.jpg", 7000, "어느 한적한 오후에...");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "starwars", "image/starwars.jpg", 16000, "영화로도 개봉한 스타워즈의 리메이크판 그 세계관을 엿보고 싶다면...");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "theartbook", "image/theartbook.jpg", 22000, "예술의 세계로 당신을 인도해줍니다.");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "tollbooth", "image/tollbooth.jpg", 13000, "왠지 치과가 가고싶은 사람들을 위한 전혀 상관없는 이야기");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "vagina", "image/vagina.jpg", 37000, "교양있는 사람들을 위한 무언가");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "why we broke up", "image/why we broke up.jpg", 17000, "왜 우리는 살아가야 하는가?");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "witch", "image/witch.jpg", 9000, "실존했던 마녀이야기를 우리의 시각으로 풀어낸...");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "7년의 봄", "image/7년의 봄.jpg", 8000, "7년전 어느날 우리는 약속했었지");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "가장 바쁜사람이 가장 많은 시간을 갖는다", "image/가장 바쁜사람이 가장 많은 시간을 갖는다.jpg", 6000, "우리가 잊고 살았던 인생의 규칙 몇가지");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "고대 도시로 떠나는 여행", "image/고대 도시로 떠나는 여행.jpg", 18000, "눈이 닿지 않아도 즐거운 여행이야기");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "다양한 책표지", "image/다양한 책표지.jpg", 22000, "일러스트라면 갖고 싶은 실용적인 책표지 꾸미기");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "단편 소설 쓰기의 모든 것", "image/단편 소설 쓰기의 모든 것.jpg", 19000, "작가가 되고 싶은 사람들을 위한 국문학과 교수 책만써의 추천작");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "달의 조각", "image/달의 조각.jpg", 13000, "달 표면의 어느것, 그리고 생소했던 이야기");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "동물원이 된 미술관", "image/동물원이 된 미술관.jpg", 8000, "생동감 있는 미술관의 현장 살아 움직이는 동물들?");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "말의 품격", "image/말의 품격.jpg", 11000, "언어에서 느껴지는 기품, 의미 전달을 넘어 내면을 비추는 언어에 대하여");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "밤의 여행자들", "image/밤의 여행자들.jpg", 12000, "은밀하게 고요하게 이룩했던 역사");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "스튜디오지브리레이아웃", "image/스튜디오지브리레이아웃.jpg", 6000, "스튜디오지브리레이아웃이래 잘 모르겠다");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "아이슬란드", "image/아이슬란드.jpg", 41000, "우리에게 허용되지 않은 극한의 추위, 그 서늘함을 머금은 경험을 책속에 녹여 내었다");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "야시", "image/야시.jpg", 8000, "야시시한건 아닌것 같다");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "언제 들어도 좋은 밤", "image/언제 들어도 좋은 밤.jpg", 13000, "언제들어도 좋은 밤이라면, 한가지가 떠오르지만 언급하지 않도록 하겠다.");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "예술을 선물하세요", "image/예술을 선물하세요.jpg", 12000, "삶에 속삭입니다. 예술은 아름다운 것");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "오후를", "image/오후를.jpg", 17000, "황혼의 인생 이야기");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "우리가 집을 짓는 10가지 이유", "image/우리가 집을 짓는 10가지 이유.jpg", 13000, "집의 소중함과 뜻 깊음을 알게 해줍니다.");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "우리는 이렇게 살겠지", "image/우리는 이렇게 살겠지.jpg", 19000, "하지만, 이것은 작가의 이야기다 이제 당신의 이야기를 들려주도록");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "운동장 편지", "image/운동장 편지.jpg", 12000, "흙내음 물씬 풍기는 어느 초등학교 어린이들의...");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "이 도시에 살고 싶다", "image/이 도시에 살고 싶다.jpg", 8000, "여기는 서울인데? 집값은 준비 됐니?");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "인간 실격", "image/인간 실격.jpg", 15000, "자극적인 제목에 어우러진 우리의 민낯");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "짠 하고 싶은 날에", "image/짠 하고 싶은 날에.jpg", 11000, "술한잔 사주실래요");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "책 따위 안 읽어도 좋지만", "image/책 따위 안 읽어도 좋지만책 따위 안 읽어도 좋지만.jpg", 4000, "책 따위 안 읽어도 좋지만 이책은 읽으세요");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "천문학에 관하여", "image/천문학에 관하여.jpg", 10000, "달과 지구 태양의 공전 관계");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "첫숨", "image/첫숨.jpg", 11000, "첫숨의 의미 거룩한 탄생");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "틈새보이스", "image/틈새보이스.jpg", 6000, "틈새의 틈새에 틈새를 위한");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "학교현장 중심의 교육정책 통합성 제고방안", "image/학교현장 중심의 교육정책 통합성 제고방안.jpg", 12000, "재고방안 같지만 넘어가도록 합시다. 딱딱한 이야기");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "현대 프랑스 철학사", "image/현대 프랑스 철학사.jpg", 9000, "프랑스 혁명 그 이후의 이야기");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "휴식", "image/휴식.jpg", 7000, "열심히 일한 당신 쉬어라");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "HELLO OXO", "image/HELLO OXO.jpg", 15000, "친근한 OXO 이야기");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "just i fied", "image/just i fied.jpg", 8000, "다른 의미를 찾아보도록");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "soma night & day", "image/soma night & day.jpg", 12000, "~~흥흥~~~ 흥흥흥.. 즐거운 펍이 생각난다");
insert into product (category_idx, product_quantity, product_name, product_image, product_price, product_desc) values (1, 100, "Vacation", "image/Vacation.jpg", 11000, "방학이다!!!!!!!!!!!!!!!!!!!!!!!!!!!");



--select * from category;
--delete from category where idx > 0;