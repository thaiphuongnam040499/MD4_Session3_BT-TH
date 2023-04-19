create database QuanLyBanHang;
use QuanLyBanHang;
create table Customer(
cId int auto_increment primary key,
cName varchar(255),
cAge int check (cAge>=18)
);
create table `Order`(
oId int auto_increment primary key,
cId int,
foreign key (cId) references Customer(cId),
oDate datetime default now(),
oTotalPrice float
);

create table Product(
pId int auto_increment primary key,
pName varchar(255),
pPrice float
);

create table OrderDetail(
oId int,
foreign key (oId) references `Order`(oId),
pId int,
foreign key (pId) references Product(pId),
odQTY int
);

-- thêm bản ghi
insert into Customer(cName,cAge) values
("Minh Quan",19),
("Ngoc Oanh",20),
("Hong Ha",50);

insert into `Order`(oId,cId,oDate,oTotalPrice) values
(1,1,"2016-03-21",null),
(2,2,"2016-03-23",null),
(3,1,"2016-03-16",null);

insert into Product(pId,pName,pPrice) values
(1,"May Giat",3),
(2,"Tu Lanh",5),
(3,"Dieu Hoa",7),
(4,"Quat",1),
(5,"Bep Dien",2);

insert into OrderDetail(oId,pId,odQTY) values 
(1,1,3),
(1,3,7),
(1,4,2),
(2,1,1),
(3,1,8),
(2,5,4),
(2,3,3);

-- truy vấn CSDL
-- •	Hiển thị các thông tin  gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order 
select oId , oDate , oTotalPrice from `Order`;
-- •	Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách
select c.cName , p.pName from (`Order` o join Customer c on o.cId = c.cId) join OrderDetail od on o.oId = od.oId join Product p on od.pId = p.pId group by p.pName , c.cName;
--  •	Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
select c.cName from Customer c where c.cId not in (select o.cId from `Order` o);
-- •	Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn (giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn. 
-- Giá bán của từng loại được tính = odQTY*pPrice) 
select o.oId, o.oDate, od.odQTY*p.pPrice as oTotalPrice from `Order` o join OrderDetail od on o.oId = od.oId join Product p on od.pId = p.pId ;
