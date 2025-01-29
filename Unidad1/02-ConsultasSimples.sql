-- Lenguaje SQL-LMD (insert, update, delete, select - crud)
-- Consultas Simples
use Northwind;


-- Mostrar todos los clientes de la empresa, con todas las columnas de datos de la empresa
--(clientes, proveedores, categorias, productos, ordenes, detalle de la orden, empleados)

select * from Customers;
select * from Employees;
select * from Orders;
select * from Suppliers;
select * from Products;
select * from Shippers;
select * from Categories;
select * from [Order Details]



-- Proyeccion (Visualizar ciertas tablas las que quieres)
select ProductID, ProductName, UnitPrice,UnitsInStock from Products;

-- Seleccionar o mostrar el numero de empleados, su primer nombre, su cargo , ciudad y pais

select EmployeeID, FirstName, TitleOfCourtesy, City, Country from Employees;

-- Alias de columna
-- En base ala consulta anterior visualizar el employeeid como numero empleado, 
-- firstname como primeronombre, title como cargo, city como ciudad, country como pais

select EmployeeID as 'Numero Empleado', FirstName as primernombre,
TitleOfCourtesy 'cargo', City as ciudad, Country as pais from Employees;

select EmployeeID as [Numero Empleado], FirstName as primernombre,
TitleOfCourtesy 'cargo', City as ciudad, Country as pais from Employees;


-- Campos calculados
-- Seleccionar el importe de cada uno de los productos vendidos en una orden, y colocarle nombre ala columna

select *,(UnitPrice * Quantity) as importe from [Order Details];

-- Selecionar las fechas de orden y año, mes y dia, el cliente
-- que las ordeno y el empleado que lo realizo

select * from Employees;


select OrderDate as 'Fecha', 
year (orderdate)as 'Año', 
MONTH(orderdate)as 'Mes', 
day(orderdate) as 'Dia de la orden',
CustomerID, EmployeeID from Orders;

-- Filas duplicadas(Distinct)

-- Mostrar los paises en donde se tienen clientes mostrando solo el pais

select distinct Country as Pais from Customers
order by Country;

--Clausula where
-- operadores relacionales o test de comparacion (<,>,=,<=,>=,!= o <>)
select * from Customers;

--Selecionar el cliente BOLID
select CustomerID, CompanyName as NombreCompañia, City as Ciudad, Country as Pais from Customers
where CustomerID = 'BOLID';

-- Selecionar los cliente, mostrando su idenfitificar, nombre de la empresa, contacto, ciudad y pais
-- de alemania

select CustomerID as Numero, 
CompanyName as Compañia, 
ContactName as NombreContacto,
City as Ciudad, 
Country as Pais
from Customers
where country = 'Germany';

--Selecionar todos los clientes que no sean de Alemania

select CustomerID as Numero, 
CompanyName as Compañia, 
ContactName as NombreContacto,
City as Ciudad, 
Country as Pais
from Customers
where country != 'Germany';

--Selecionar todos los productos mostrando su nombre del producto, categoria que pertenece,
--sus existencias, precio pero solamente donde su precio sea mayor a 100 y costo de inventario

select ProductName,
CategoryID, 
UnitsInStock,
UnitPrice,(UnitPrice * UnitsInStock)as 'Costo inventario' from Products
where UnitPrice >100;

select * from Products;

-- Selecionar todas las ordenes de compras, mostrando la fecha de orden, la fecha de eentrega, la fecha de envio,
--el cliente a quien se vendio, de 1996

select OrderDate as FechaPedido,
RequiredDate as FechaEntregada, 
ShippedDate as FechaEnvio, 
CustomerID as AquienEntrego from Orders
where year (OrderDate) = '1996';


-- Mostrar todas las ordenes de compras donde la cantidad de productos comprados
-- sea mayor a 5

select Quantity from [Order Details]
where Quantity >5;

-- Mostrar el nombre de completo del empleto, su numero de empleado, fecha de nacimiento
-- la ciudad y fecha de contratacion y esta debe de ser de aquellos que fueron contratados despues 
-- de 1993, los resultados en su encabezados debes ser mostrados en español


select FirstName as Nombre,
EmployeeID as NumeroEmpleado,
BirthDate as FechaNacimiento,
City as Ciudad,
HireDate as FechaContratacion from Employees
where year (HireDate) >1993;


-- Mostrar los empleados que no son dirigidores por el jefe 2

select EmployeeID,ReportsTo from Employees
where ReportsTo <> 2;

-- Selecionar los empleados que no tengan jefes

select * from Employees
where ReportsTo is null