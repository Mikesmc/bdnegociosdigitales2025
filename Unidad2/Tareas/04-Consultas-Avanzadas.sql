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

--Consultas basicas con inner join

--Obtener los nombres de los clientes y los paises a los que se enviaron sus pedidos 

select c.CompanyName as Cliente, p.ShipCountry as [Pais de envio]
from Customers as c
JOIN Orders as p 
on c.CustomerID = p.CustomerID
order by 2 desc


select c.CompanyName as Cliente, p.ShipCountry as [Pais de envio]
from Customers as c
JOIN Orders as p 
on c.CustomerID = p.CustomerID
order by p.ShipCountry desc

-- Obtener los productos y sus respectivos provedores

select p.ProductName as Producto, 
s.CompanyName as Proveedor from 
Products as p
inner join 
Suppliers as s
on p.SupplierID = s.SupplierID

-- Obtener los pedidos y los empleados que los gestionaron

select o.OrderID, concat(e.Title,' - ', e.FirstName, ' - ', e.FirstName, ' ', e.LastName) as Nombre from 
Orders as o
inner join Employees as e
on o.EmployeeID = e.EmployeeID

-- Listar los productos junto con sus precios y la categoria a la que pertenece

select p.ProductName as [Nombre del Producto], p.UnitPrice as Precio, p.CategoryID as Categorias 
from Products as p
inner join Categories as c
on c.CategoryID = p.CategoryID 


-- Obtener el nombre del cliente, el numero de orden y la fecha de orden

select c.CompanyName as Cliente, OrderID as Orden, OrderDate as Fecha
from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID


-- Listar las ordenes mostrando el numero de orden, el nombre del producto y la cantidad que se vendio

select od.OrderID as [Numero de Ordeb], p.ProductName as [Nombre del producto], od.Quantity as [Cantidad vendida]
from [Order Details] as od
inner join Products as p
on od.ProductID = p.ProductID
order by od.Quantity desc

--Con las top 5 
select top 5 od.OrderID as [Numero de Ordeb], p.ProductName as [Nombre del producto], od.Quantity as [Cantidad vendida]
from [Order Details] as od
inner join Products as p
on od.ProductID = p.ProductID
order by od.Quantity desc

--Solo ciertas ordenes
select od.OrderID as [Numero de Ordeb], p.ProductName as [Nombre del producto], od.Quantity as [Cantidad vendida]
from [Order Details] as od
inner join Products as p
on od.ProductID = p.ProductID
where od.OrderID = '11031'
order by od.Quantity desc


select od.OrderID as [Numero de Orden],
count(*) as 'Cantidad de Productos vendidos'
from [Order Details] as od
inner join Products as p
on od.ProductID = p.ProductID
group by od.OrderID
order by od.Quantity desc


select * from 
[Order Details] as od 
where od.OrderID = 11077


-- Obtener los empleados y sus respectivos jefes

select concat(e1.FirstName, '', e1.LastName) as [Empleado], 
concat(j1.FirstName, '', j1.LastName) as [Jefe] 
from Employees as e1
inner join Employees as j1
on e1.ReportsTo = j1.EmployeeID

-- Listar los pedidos y el nombre de la empresa de transporte utilizada

select o.OrderID [Pedidos], s.CompanyName as [Transporte]
from Orders as o
inner join Shippers as s
on s.ShipperID = o.ShipVia


--Consultas de inner join intermedias

--Obtener la cantidad total de productos vendidos por categoria

select sum(Quantity) 
from [Order Details]

select c.CategoryName [Nombre Categoria], sum(Quantity) as [Productos vendidos]
from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID

inner join [Order Details] as od
on od.ProductID = p.ProductID
group by c.CategoryName
order by c.CategoryName

--Obtener el total de ventas por empleados

select concat(e.FirstName,' ', e.LastName) as Nombre,
sum((od.Quantity * od.UnitPrice) - (od.Quantity * od.UnitPrice) * od.Discount)
as Total
from Orders as o
inner join Employees as e
on o.EmployeeID  = e.EmployeeID
inner join [Order Details] as od
on od.OrderID = o.OrderID
group by e.FirstName, e.LastName

