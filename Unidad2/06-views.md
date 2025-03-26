# Consultas Views SQL


``` SQL
--Views 

--Sintaxis 

/*create view nombreVista
as
select columnas
from tabla
where condicion
*/

use Northwind

go

create view VistaCategoriastodas
as 
select CategoryID, CategoryName, [Description], Picture
from Categories
go

drop view VistaCategoriastodas

select * from VistaCategoriastodas
where CategoryName = 'Beverages'


--Crear una vista que permita visualizar solamente clientes de mexico y brazil
go
create view ClientesLatinos
as
select ContactName, Country
from  Customers
where Country in ('Mexico','Brazil')
go

select * from ClientesLatinos

-- Crear una view que contenga los datos de todas las ordenes, productos,
--empleados, y clientes, categorias de productos
--en la orden calcular el importe


go

create or alter view [dbo].[vistasordenescompra]
as
select o.OrderID as [Numero Orden],
o.OrderDate as [Fecha de Orden], 
o.RequiredDate as [Fecha de Requisicion],
CONCAT(e.FirstName, ' ', e.LastName) as [Nombre Empleado],
cu.CompanyName as [Nombre Clientes],
p.ProductName as [Nombre Producto],
c.CategoryName as [Nombre Categoria],
od.UnitPrice as [Precio de Venta],
od.Quantity as [Cantidad Vendida],
(od.Quantity * od.UnitPrice ) as [Importe]
from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
inner join [Order Details] as od
on od.ProductID = p.ProductID
inner join Orders as o
on od.OrderID = o.OrderID
inner join Customers as cu
on cu.CustomerID = o.CustomerID
inner join Employees as e
on e.EmployeeID = o.EmployeeID

select count(distinct[numero orden]) as [Numeor de Ordenes]
from vistasordenescompra

select sum([Cantidad Vendida] * [Precio de Venta]) as [Importe Total]
from vistasordenescompra

select sum(Importe) as [Importe Total]
from vistasordenescompra
where year([Fecha de Orden]) between '1995' and '1996'


create or alter view vista_ordenes_1995_1996
as
select [Nombre del Cliente] as 'Nombre Cliente',
sum(importe) as [importe Total]
from vistasordenescompra
where year([Fecha de Orden])
between '1995' and '1996'  
group by [Nombre del Cliente]
having count(*)>2


--Creacion esquemas

create schema rh

create table rh.tablarh (
id int primary key,
nombre nvarchar(50)
)

-- Vista Horizontal

create or alter view rh.viewcategoriasproductos
as 
select c.CategoryID, CategoryName, p.ProductID, p.ProductName
from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
go


select * from rh.viewcategoriasproductos



```