show databases;

CREATE DATABASE week1;

use week1;

desc person;

create table person (driver_id varchar(10),
name varchar(20),
address varchar(30),
primary key(driver_id));

create table car(reg_num varchar(10),
model varchar(10),
year int, 
primary key(reg_num));

desc car;

 create table accident(report_num int, 
 accident_date date, 
 location varchar(20),
 primary key(report_num));

create table owns(driver_id varchar(10),reg_num varchar(10),
primary key(driver_id, reg_num),
foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num));

desc owns;

create table participated(driver_id varchar(10), reg_num varchar(10),
report_num int, damage_amount int, 
primary key(driver_id, reg_num, report_num), 
foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num),
foreign key(report_num) references accident(report_num));

desc participated;

insert into person values('A01','Richard','Srinivas Nagar');
insert into person values('A02','Pradeep','Rajajinagar');
insert into person values('A03','Smith','Ashoknagar');
insert into person values('A04','Venu','NR colony');
insert into person values('A05','John','Hanumanthanagar');

select * from person;

insert into car values('KA052250','Indica', 1990);
insert into car values('KA031181','Lancer', 1957);
insert into car values('KA095477','Toyota',1998);
insert into car values('KA053408','Honda',2008);
insert into car values('KA041702','Audi' ,2005);

select * from car;


insert into accident values(11,'2003-01-01','Mysore Road');
insert into accident values(12,'2004-02-02','SouthendCirlce');
insert into accident values(13,'2008-02-17','Bulltemple Road');
insert into accident values(14,'2008-02-17','MysoreRoad');
insert into accident values(15,'2005-04-05','KanakpuraRoad');

select * from accident;

insert into owns values('A01','KA052250');
insert into owns values('A02','KA053408');
insert into owns values('A03','KA095477');
insert into owns values('A04','KA031181');
insert into owns values('A05','KA041702');

select * from owns;

insert into participated values('A01','KA052250',11,10000);
insert into participated values('A02','KA053408',12,50000);
insert into participated values('A03','KA095477',13,25000);
insert into participated values('A04','KA031181',14,3000);
insert into participated values('A05','KA041702',15,5000);

select * from participated;

update participated set damage_amount=25000 where reg_num='KA053408' and report_num=12;

insert into accident values(16,'2008-03-15','Domlur');

select accident_date, location from ACCIDENT;

select driver_id from PARTICIPATED where damage_amount >=25000;

SELECT 
    p.driver_id,
    p.name,
    p.address,
    c.reg_num,
    c.model,
    c.year,
    a.report_num,
    a.accident_date,
    a.location,
    pt.damage_amount
FROM person p
JOIN owns o ON p.driver_id = o.driver_id
JOIN car c ON o.reg_num = c.reg_num
JOIN participated pt ON p.driver_id = pt.driver_id AND c.reg_num = pt.reg_num
JOIN accident a ON pt.report_num = a.report_num;









 








