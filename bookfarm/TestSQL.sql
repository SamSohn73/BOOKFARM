use bookfarm;

select * from admin;

insert into admin (user_name, user_pass) values ("admin", "12345");

select * from product order by idx desc, limit 1,10;


select * from category;

delete from category where idx=143;