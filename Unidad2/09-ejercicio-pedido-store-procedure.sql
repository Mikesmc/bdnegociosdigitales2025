--Realizar un pedido
--Validar que el pedido no exista
--Validar que el cliente, el empleado y el producto exista
--Validar que la cantidad a vender tenga suficiente stock
--Insertar el pedido y calcular el importe(Multiplicando el precio del
--producto por cantidad vendida)
--Actualizar el stock del producto (restando el stock menos la cantidad vendida)


create or alter procedure spu_realizar_pedido
@numPedio int,
@cliente int,
@repre int,
@fab char(3),
@producto char(5),
@cantidad int
as
begin
	if exists (select 1 from Pedidos where Num_Pedido = @numPedio)
	begin
		print ('El pedido ya existe')
		return 
	end

	if not exists (select 1 from Clientes where Num_Cli = @cliente) or
       not exists (select 1 from Representantes where Num_Empl = @repre) or
	   not exists (select 1 from Productos where Id_fab = @fab and Id_producto = @producto)
	begin
		print ('Los datos no son validos')
		return 
	end

	if @cantidad <=0
	begin
	print 'La cantidad no puede ser 0 o negativo'
	end
	
	declare @stockValido int
	select @stockValido= Stock from Productos where Id_fab = @fab and Id_producto = @producto 
	if @cantidad > @stockValido 
	begin
	print 'No hay suficiente stock'
	return;
	end

	declare @precio money
	declare @importe money

	select @precio= Precio from Productos where Id_fab = @fab and Id_producto = @producto
	set @importe = @cantidad * @precio

	begin try

	insert into Pedidos 
	values (@numPedio, GETDATE(), @cliente, @repre, @fab, @producto, @cantidad, @importe );


	update Productos
	set Stock = Stock - @cantidad
	where Id_fab = @fab and Id_producto = @producto;

	end try
	begin catch
	print 'Error al actualizar datos'
	return;
	end catch
	


end;

exec spu_realizar_pedido @numPedio = 113070, 
@cliente = 2117,
@repre = 101,
@fab = 'ACI',
@producto = '4100X',
@cantidad = 20


SELECT * from Productos

