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


-- Operadores logicos (or, and y not)
-- Seleccionar los productos que tengan un precio de entre 10 y 50

select ProductName as Nombre, UnitsInStock as Existencia, UnitPrice as Precio from Products
where UnitPrice >=10 and UnitPrice<=50;

-- Mostrar todos los pedidos realizados por clientes que no son de alemania

select * from Orders
where NOT ShipCountry = 'Germany'

-- Seleccionar clientes de Mexico o USA

select City as Ciudad from Customers
where  (Country='Mexico' or Country='USA')

-- Seleccionar empleados que nacieron entre 1955 y 1958 y que vivan en londres

select * from Employees
where year(BirthDate) >= 1955 and year(BirthDate) <=1958 and City = 'London'

-- Seleccionar los pedidos co flete(Freight) mayor a 100
-- y enviados a francia o españa

select Freight as Peso, ShipCountry as Envio from Orders
where Freight>100 and (ShipCountry = 'France' or ShipCountry = 'Spain')

-- Seleccionar las primeras 5 ordenes de compras

select top 5 * from Orders

-- Seleccionar los productos con precio entre 10 y 50 
-- que no esten descontinuados y tengan mas de 20 unidades en stock

select ProductName as Producto, UnitPrice as Precio,
UnitsInStock as Existencia, Discontinued as Descontinuado from Products
where (UnitPrice >=10 and UnitPrice <=50) and (Discontinued <>1) and UnitsInStock >20

-- Pedidos enviados a Francia o Alemania, pero con flete menor a 50

select ShipCountry as PaisEnviado, Freight as Peso from Orders
where (ShipCountry = 'France' or ShipCountry = 'Germany') and Freight <50

-- Clientes que no sean de Mexico o USA y que tengan fax registrado


select CompanyName, Country, City, Fax  from Customers
where not(Country='Mexico' or Country='USA') and Fax is not null

-- Seleccionar pedidos con un flete mayor a 100, enviados a Brasil o Argentina, 
--pero no enviados por transportista 1

-- Selecciona empleados que no viven en Londres o Sattle y que 
-- fueron contratados despues de 1995

select concat(FirstName, '', LastName)as [Nombre Completo],
HireDate, City, Country
from Employees
where City<>'London' and City <> 'Sattle'
and year(HireDate) >=1992


-- Clausila In (or)

--Seleccionar los Productos con categoría 1, 3 o 5

select ProductName, CategoryID, UnitPrice from Products
where CategoryID = 1 or CategoryID = 3 or CategoryID = 5
--Manera 2
select ProductName, CategoryID, UnitPrice from Products
where CategoryID in (1,3,5);

--Seleccionar todas las ordenes de la region RJ, Tachira y que no tengan region asignada
select OrderID, OrderDate, ShipRegion from Orders
where ShipRegion in ('RJ', 'Táchira', 'null')
or ShipRegion is null

-- Seleccionar las ordenes que tengan cantidades de 12, 9 o 40, y descuento de 0.15 o 0.05
select OrderID, Quantity, Discount
from [Order Details]
where Quantity in (12,9,40)
and Discount in (0.15, 0.05)


-- Clausila Between (Siempre va en el where )

--between valorinicial and valorfinal

-- Mostrar los productos con precio entre 10 y 50

select * from Products
where UnitPrice>=10 and UnitPrice<=50

select UnitPrice as Precio  from Products
where UnitPrice between 10 and 50

-- Seleccionar todos los pedidos realizados entre el primero de enero y el 30 de junio de 1997

select OrderDate as FechaOrden from Orders
where OrderDate >= '1997-01-01' and OrderDate <='1997-30-06'

select OrderDate as FechaOrden from Orders
where OrderDate between '1997-01-01' and '1997-30-06'


-- Seleccionar todos los empleados contratados entre 1990 y 1995 que trabajan en londres

select * from Employees
where year(HireDate)>=1992 and year(HireDate)<=1994 and City ='London'


Select * from Employees
where year(HireDate) between 1992 and 1994 and City = 'London'

-- Pedidos con flete entre 50 y 200 enviados a alemania y a francia

select OrderID [Numero de Orden],
OrderDate as [Fecha de Orden],
RequiredDate as [Fecha de Entrega],
Freight as [Peso],
ShipCountry as [Pais de Entrega] from Orders
where Freight >= 50 and Freight<= 200
and (ShipCountry= 'Germany' or ShipCountry='France')


select OrderID [Numero de Orden],
OrderDate as [Fecha de Orden],
RequiredDate as [Fecha de Entrega],
Freight as [Peso],
ShipCountry as [Pais de Entrega] from Orders
where Freight between 50 and 200
and ShipCountry in ('Germany','France')


-- Selecionar todos los productos que tengan un precio entre 5 y 20 dolares o que sean de la categoria 1,2 o 3

select UnitPrice as Precio,
CategoryID as Categoria
from Products
where UnitPrice between 5 and 20
and CategoryID in (1,2,3)

-- Empleados con numero de trabajador entre 3 y 7 que no trabajan en londres ni seattle

select EmployeeID as [Numero Empleado],
CONCAT(FirstName, '', LastName) as [Nombre completo],
city as [Ciudad]
from Employees  
where EmployeeID>=3 and EmployeeID<=7
and (city<>'London' and city<>'Seattle')


select EmployeeID as [Numero Empleado],
CONCAT(FirstName, '', LastName) as [Nombre completo],
city as [Ciudad]
from Employees  
where EmployeeID>=3 and EmployeeID<=7
and not city in ('London','Seattle')

select EmployeeID as [Numero Empleado],
CONCAT(FirstName, '', LastName) as [Nombre completo],
city as [Ciudad]
from Employees  
where EmployeeID between 3 and 7
and not city in ('London','Seattle')


--Clausula Like para buscar 
-- Patrones :
		-- 1) % (porcentaje) -> Representa cero o mas caracteres en el patron de busqueda
		-- 2) _ (Guion bajo) Representa exactamente un caracter en el patron de busqueda
		-- 3) [] corchetes -> Se utiliza para definir un conjunto de caracteres buscando cualquiera de ellos en
		-- la pocision especifica 
		-- 4) [^] -> Acento circunfrenjo o el Gorrito Se utiliza para buscar caracteres que no estan dentro del 
		-- conjunto especifico 

--Buscar los productos que comienzan con C y que su precio sea igual a 18

select * from Products
where ProductName like 'Cha%' and UnitPrice =18

-- Buscar todos los productos que terminen con E

select * from Products
where ProductName like '%e'

-- Seleccionar todos los clientes cuyos nombres emplesas contienen la palabra CO en cualquier parte

select * from Customers
where CompanyName like '%co%'

-- Seleccionar los empleados cuyos nombres comiencen con A y que tengan 5 caracteres

select FirstName, LastName from Employees
where FirstName like 'A_____'