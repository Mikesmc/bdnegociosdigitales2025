-- Consultas de agregados 
-- Nota: Solo devuelven un solo registro
-- sum, avg, count, count(*), max y min

-- Cuantos clientes tengo (con count *)

use Northwind

select count(*) as 'Numero de clientes' 
from Customers

--Cuantas regiones hay
select count (*)
from Customers
where Region is null
-- Respuesta correcta
select count (distinct region)
from Customers
where Region is not null


select * from Orders
select count (*) from Orders
select count (ShipRegion) from Orders

-- Selecciona el precio mas bajo de los productos
select * from Products

select min(UnitPrice), max(UnitPrice),
avg(UnitsInStock)
from Products;

--Seleccionar cuantos pedidos existen
select count(*)as [Numero de pedidos] from Orders

--Calcula el total de dinero vendido
select sum(UnitPrice * Quantity) from [Order Details]

select sum(UnitPrice * Quantity -
(UnitPrice * Quantity * Discount) )as Total 
from [Order Details]


--Calcula el total de unidades en stock de todos los productos
select sum(UnitsInStock)as [Total Stock]  from Products

-- Seleccionar el total de pedidos que se realizados por cada empleado
-- por el ultimo trimestre de 1996
select EmployeeID, count(*) as 'Numero de pedidos' from Orders
group by EmployeeID

select EmployeeID ,count(*) from Orders
where OrderDate between '1996-01-10' and '1996-31-12'
group by EmployeeID

--Seleccionar la suma total de unidades vendidas por cada producto
select ProductID ,sum(Quantity) as 'Numero de productos vendidos' from [Order Details]
group by ProductID
order by 1 desc

select OrderID, ProductID ,sum(Quantity) as 'Numero de productos vendidos'
from [Order Details]
group by orderid, ProductID 
order by 2 desc


--Seleccionar el numero de productos por categoria
select CategoryID, count(*)as 'Numero de productos'
from Products
group by CategoryID


select p.CategoryID, count(*) as [Numero de producto]
from
Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
group by p.CategoryID


select Categories.CategoryName,
count(*) as [Numero de producto]
from
Categories
inner join Products as p
on Categories.CategoryID = p.CategoryID
group by Categories.CategoryName


--Calcular el precio promedio de los productos por cada categoria

select CategoryID, avg(UnitPrice) as [Precio Promedio]
from Products
group by CategoryID

--Seleccionar el numero de pedido realizados por cada empleado
select EmployeeID, count(EmployeeID) as [Ordenes]
from Orders
group by EmployeeID

--Seleccionar el numero de productos por categoria pero solo aquellos que tengan 
-- mas de 10 productos

select CategoryID, sum(UnitsInStock) as [Mas de 10 Productos]
from Products
where CategoryID in (2,4,8)
group by CategoryID
having count(*)>10
order by CategoryID 

--Listar las ordenes agrupadas por el empleados, pero que solo muestre aquellos
--que hayan gestionado mas de 10 pedidos
select EmployeeID, count(OrderID) as [Ordenes]
from Orders
group by EmployeeID
having count(OrderID)>10