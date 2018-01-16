use bookfarm;

select * from admin;
select * from customer;

select * from product;
select * from product order by idx ;
select * from product order by idx desc limit 1,10;

select * from category;

select * from customer;

select * from basket;


insert into admin (user_name, user_pass) values ("admin", "12345");


delete from category where idx=143;

delete from product where idx = 57;

delete from basket where idx = 4;


update basket set customer_idx = 19 where idx = 2;
