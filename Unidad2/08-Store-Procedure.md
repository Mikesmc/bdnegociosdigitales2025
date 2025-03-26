# Consultas Simples SQL


``` SQL


--Store procedure


-- Crear un store procedure para seleccionar todos los clientes
go
create or alter procedure spu_mostrar_clientes 
as 
begin
	select * from Customers;
end
go


--Ejecutar un store transact
exec spu_mostrar_clientes



--Crear un store procedure que muestre los clientes por pais
--Parametros de entrada 

create or alter proc spu_customersporpais
--Parametros

@pais nvarchar(15), 
@pais2 nvarchar(15)--Parametro de entrada
as
begin
	select * from Customers
	where Country in (@pais, @pais2);
end;


-- Ejecuta un sotre 

Declare @p1 nvarchar(15) = 'spain';
Declare @p2 nvarchar(15) = 'germany';

exec spu_customersporpais @p1, @p2;
go


--Generar un reporte que permita visualizar los datos de compra de un 
--determinado cliente, en un rango de fechas, mostrando el monto total de compra por 
-- productos


create or alter proc spu_informe_ventas_clientes
--Parametros
@nombre nvarchar(40) = 'Berglunds snabbk�p',  --Parametros de entrada con valor por default
@fechaInicial datetime,
@fechaFinal datetime
as 
begin
select [Nombre Producto],[Nombre Clientes] ,SUM(Importe) as [Monto Total]
from vistasordenescompra
where [Nombre Clientes] = @nombre and 
[Fecha de Orden] between @fechaInicial and @fechaFinal
group by [Nombre Producto], [Nombre Clientes]
end;
go


--Ejecucion de un store con parametros de entrada
select * from Customers
select getdate()
exec spu_informe_ventas_clientes 'Berglunds snabbk�p', 
									'1996-07-04', '1997-01-01'

--Ejecucion de un store con parametros en diferentes posicion
exec spu_informe_ventas_clientes 
@fechaFinal ='1997-01-01',
@nombre = 'Berglunds snabbk�p',
@fechaInicial = '1996-07-04';

--Ejecucion de un sotre procedure con parametros de entrada con un campo que tiene un valor por default
exec spu_informe_ventas_clientes 
@fechaInicial = '1996-07-04',
@fechaFinal ='1997-01-01'


--Store procedure con parametros de salida

go

create or alter proc spu_obtener_numero_clientes
@customerid nchar(5), --Parametro de entrada
@totalCustomers int output --Parametro de salida
as
begin
	select @totalCustomers = count(*) from Customers
	where CustomerID = @customerid;
end;
go

declare @numero int;
exec spu_obtener_numero_clientes 'ANATR',
								 @totalCustomers = @numero output;
print @numero;
go



--Crear un store procedure que permita saber si un alumno aprobo o reprobo

create or alter procedure spu_comparar_calificacion
@calif decimal(10,2)  --Parametro de entrada
as 
begin
	if @calif >= 0 and @calif <=10
	begin
		if @calif >= 8 
		print 'La calificacion es aprobatoria'
		else
		print 'La calificacion es reprobatoria'
	end 
	else
	print 'Calificacion no valida'
end;
go

exec spu_comparar_calificacion @calif=8


--Crear un sp que permita verificar si un cliente existe antes de devolver su informacion
go
create or alter proc spu_obtener_cliente_siexiste
@numeroCliente char(5)
as 
begin
	if exists (select 1 from Customers where CustomerID = @numeroCliente )
	select * from Customers where CustomerID = @numeroCliente;
	else
	print 'El cliente no exite'
end;
go


exec spu_obtener_cliente_siexiste @numeroCliente = 'AROUT'

select * from Customers
select 1 from Customers where CustomerID = 'AROUT'


--Crear un sp que permita insertar un cliente, pero se debe verificar primero que no existe
go
create or alter procedure spu_agregar_cliente
@id nchar(5),
@nombre nvarchar(40),
@city nvarchar(15) = 'San Miguel'
as
begin
	if exists (select 1 from Customers where CustomerID = @id)
	begin
	print ('El cliente ya existe')
	return 1
	end

	insert into Customers(CustomerID, CompanyName)
	values(@id,@nombre);
	print 'Cliente insertado exitosamente';
	return 0;
end;

exec spu_agregar_cliente 'ALFKI', 'PATITO DE HULE'

go
create or alter procedure spu_agregar_cliente_try_catch
@id nchar(5),
@nombre nvarchar(40),
@city nvarchar(15) = 'San Miguel'
as
begin
	begin try
		insert into Customers(CustomerID, CompanyName)
		values(@id,@nombre);
		print 'Cliente insertado exitosamente';
	end try

	begin catch
	print 'Cliente insertado exitosamente';
	end catch

end;
go

exec spu_agregar_cliente_try_catch 'ALFKI', 'Mu�eca Vieja'

--Manejo de ciclos en store procedures
--Imprimir el numero de veces que indique el usuario

go
create or alter procedure spu_imprimir
@numero int
as 
begin
	if @numero <= 0
	begin
	print ('El numero no puede ser 0 o Negativo')
	return
	end


	declare @i int
	set @i = 1
	while (@i <= @numero)
	begin
	print concat('Numero', @i)
	set @i = @i +1
	end
end;

exec spu_imprimir 10



```