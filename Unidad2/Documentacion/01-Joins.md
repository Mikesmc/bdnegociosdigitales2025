![Inner Join](../Img/img_inner_join.png)

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

--11 Listar los clientes y la cantidad de pedidos que han realizado

select c.CustomerID as Cliente, 
c.ContactName as Nombre, 
count(o.OrderID) as Total_Pedidos
from Customers as c
join Orders as o 
on c.CustomerID = o.CustomerID
group by c.CustomerID, c.ContactName
order by Total_Pedidos desc;


--12 Obtener los empleados que han gestionado pedidos enviados a alemania

select distinct concat (e.FirstName, ' ', e.LastName) as [Nombre Empleado]
from Employees as e
join Orders as o 
on e.EmployeeID = o.EmployeeID
where o.ShipCountry = 'Germany';


--13 Listar los productos junto con el nombre del proveedor y el pais de origen

select p.ProductName as Producto, 
s.CompanyName as Proveedor, 
s.Country as [Pais Origen]
from Products as p
join Suppliers as s 
on p.SupplierID = s.SupplierID;

--14 Obtener los pedidos agrupados por pais de envio

select  ShipCountry as [Pais de envio],
count (o.OrderID) as [Total de envio]
from Orders as o
group by ShipCountry


--15 Obtener los empleados y la cantidad  de territorios en los que trabajan

select e.FirstName as Nombre,
count(et.TerritoryID) as [Total Territorio]
from Employees as e
join EmployeeTerritories as et
on e.EmployeeID = et.EmployeeID
group by e.FirstName

select e.FirstName as Nombre,
t.TerritoryDescription
,count(et.TerritoryID) as [Total Territorio]
from Employees as e
join EmployeeTerritories as et
on e.EmployeeID = et.EmployeeID
join Territories as t
on et.TerritoryID = t.TerritoryID
group by e.FirstName, t.TerritoryDescription
order by Nombre, t.TerritoryDescription

--16 Listar las categorias y la cantidad de productos que contienen

select c.CategoryName,
count(p.ProductID) 
from Categories as c
join Products as p
on p.CategoryID = c.CategoryID
group by c.CategoryName

--17 Obtener la cantidad total de productos vendidos por proveedor

select s.CompanyName as Proveedor,
sum(od.Quantity) as [Total vendido] 
from Suppliers as s
join Products as p
on s.SupplierID = p.SupplierID
join [Order Details] as od
on od.ProductID = p.ProductID
group by s.CompanyName

--18 Obtener la cantidad de pedidos enviados por cada empresa de transporte

select s.CompanyName as Transportista ,count(*) as [Total de pedidos]
from Orders as o
inner join Shippers as s
on o.ShipVia =s.ShipperID
group by s.CompanyName







-- Consultas avanzadas

--19 Obtener los clientes que han realizados pedidos de productos distintos

select c.CompanyName, count(distinct ProductID) as [Numeros prodcutos] from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
inner join [Order Details] as od
on od.OrderID = o.OrderID
group by c.CompanyName
order by 2 desc

--Con distinct
select distinct ProductID as [Numeros prodcutos] from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
inner join [Order Details] as od
on od.OrderID = o.OrderID
order by 1 desc

--Sin distinct
select ProductID as [Numeros prodcutos] from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
inner join [Order Details] as od
on od.OrderID = o.OrderID
order by 1 desc


-- 20 Listar los empleados con la catidad total de pedidos que han gestionado y a que clientes les han vendido
--agrupandolos por nombre completo y dentro de este nombre por cliente, 
--ordenados por la cantidad de mayor pedidos


select  concat(e.FirstName, ' ', e.LastName) as [Name],
count(orderId) as [Numero de ordenes]
from Orders as o
inner join Employees as e
on e.EmployeeID = o.EmployeeID
group by e.FirstName, e.LastName
order by [Name] asc

select  concat(e.FirstName, ' ', e.LastName) as [Name] ,c.CompanyName as Cliente,
count(orderId) as [Numero de ordenes]
from Orders as o
inner join Employees as e
on e.EmployeeID = o.EmployeeID
inner join Customers as c
on c.CustomerID = o.CustomerID
group by e.FirstName, e.LastName, c.CompanyName
order by [Name] asc, Cliente 


-- 21 Listar las categorias con el total de ingresos generados por sus productos 

select c.CategoryID ,sum(od.Quantity *od.UnitPrice) as Ingresos
from Products as p
inner join Categories as c
on p.CategoryID = c.CategoryID
inner join [Order Details] as od
on od.ProductID = c.CategoryID
group by c.CategoryID
order by c.CategoryID asc

--22 Listar los clientes con el total ($) gastados pedidos

select c.CustomerID, sum(od.Quantity * od.UnitPrice) as [Total Gastado]
from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
inner join [Order Details] as od
on od.OrderID = o.OrderID
group by c.CustomerID

-- 23 Listar los pedidos pedidos realizados entre el 1 de enero de 1997  y el 30 de junio de 1997
-- y mostrar el total en dinero

select o.OrderID, o.OrderDate, sum(od.Quantity * od.UnitPrice) as [Dinero Total]
from Orders as o
inner join [Order Details] as od
on o.OrderID = od.OrderID
where o.OrderDate between '1997-01-01' and '1997-30-06'
group  by o.OrderID, o.OrderDate


--24 Listar los productos con las categorias Beverages, Seafood, Confections

select p.ProductName, c.CategoryID, c.CategoryName
from Products as p
inner join Categories as c
on p.CategoryID = c.CategoryID
where (c.CategoryName= 'Beverages' or c.CategoryName='Seafood' or c.CategoryName='Confections')
group by p.ProductName, c.CategoryID, c.CategoryName

--25 Listar los clientes ubicados en alemania y que hayan realizado
--pedidos antes del 1 de enero de 1997

select c.CompanyName, c.Country, o.OrderDate
from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
where c.Country = 'Germany' and o.OrderDate<'1997-01-01'
group by c.CompanyName, c.Country, o.OrderDate


-- 26 Listar los clientes que han realizado pedidos con un total entre 500 y 2000

select c.CompanyName, sum(od.Quantity * od.UnitPrice)  as Total
from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
inner join [Order Details] as od
on od.OrderID = o.OrderID
group by c.CompanyName
having sum(od.Quantity * od.UnitPrice) between 500 and 2000

--Left join, Right join, Full join y Cross join