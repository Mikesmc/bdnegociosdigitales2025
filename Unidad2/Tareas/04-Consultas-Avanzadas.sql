-- Seleccionar todas las categorias y productos


select * from
Categories 
inner join 
Products
on Categories.CategoryID =Products.CategoryID;


select categories.CategoryID, CategoryName, ProductName, 
UnitsInStock,UnitPrice from
Categories 
inner join 
Products
on Categories.CategoryID =Products.CategoryID;


select c.CategoryID as [Numero de Categoria], CategoryName 'Nombre Categoria',
ProductName as 'Nombre Producto', 
UnitsInStock [Existencia],UnitPrice as Precio from
Categories as c
inner join 
Products as p
on c.CategoryID =p.CategoryID;


-- Seleccionar los productos de la categoria beverages y condiments donde 
-- la existencia este entre los 18 y 30


select *
from Products as p
inner join
Categories as ca
on p.CategoryID = ca.CategoryID
where (ca.CategoryName= 'beverages' or ca.CategoryName='condiments')
and p.UnitsInStock >=18 and p.UnitsInStock<=30

select *
from Products as p
inner join
Categories as ca
on p.CategoryID = ca.CategoryID
where (ca.CategoryName= 'beverages' or ca.CategoryName='condiments')
and p.UnitsInStock between 18 and 30;


--Seleccionar los productos y sus importes realizados de marzo a junio
--de 1996, mostrando la fecha de la orden, el id del producto y el importe

select o.OrderID, o.OrderDate, od.ProductID,
(od.UnitPrice * od.Quantity) as importe
from Orders as o
inner join [Order Details] as od
on od.OrderID = o.OrderID
where o.OrderDate between '1996-01-07' and '1996-31-10'


--Mostrar el importe total de ventas  de la consulta anterior

select concat('$', '',  sum(od.Quantity * od.UnitPrice)) as importe
from Orders as o
inner join [Order Details] as od
on od.OrderID = o.OrderID
where o.OrderDate between '1996-01-07' and '1996-31-10'