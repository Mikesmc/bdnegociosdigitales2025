

select * from Categories


select c.CategoryName, c.CategoryID, p.CategoryID, p.ProductName 
from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID


--Productos que no tienen categorias

select c.CategoryName, c.CategoryID, p.CategoryID, p.ProductName 
from Products as p
left join Categories as c
on c.CategoryID = p.CategoryID


select * from Products

insert into Products (ProductName, SupplierID, CategoryID, QuantityPerUnit,
UnitPrice, UnitsInStock,UnitsOnOrder, ReorderLevel, Discontinued)

values('Hamburguesa Sabrosa',1,9,'xyz',68.7,45,12,2,0) 


insert into Products (ProductName, SupplierID, CategoryID, QuantityPerUnit,
UnitPrice, UnitsInStock,UnitsOnOrder, ReorderLevel, Discontinued)

values('Guaracha Sabrosona',1,null,'xyz',68.7,45,12,2,0) 

delete Products
where CategoryID = 9

--Listar los empleados y los pedidos que han gestionado
--incluyendo los empleados que no han hecho pedido

-- Todos los productos que no tengan categorias
select c.CategoryName from Products as p
inner join Categories as c
on p.CategoryID = c.CategoryID


