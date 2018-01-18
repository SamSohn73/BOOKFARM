use bookfarm;

select * from admin;

select * from customer;

select * from product;
select * from product where product_name like "%짠%";
select * from product order by idx ;
select * from product order by idx desc limit 1,10;

select * from category;

select * from basket;


insert into admin (user_name, user_pass) values ("admin", "12345");


delete from category where idx=143;

delete from product where idx = 57;

select * from review where (products_idx=1 or products_idx=2) and (customers_idx=10 or customers_idx=0);
select * from review;
select * from orders;
