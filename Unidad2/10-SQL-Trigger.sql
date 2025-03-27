

use BDEJEMPLO2

--Realizar un trigger que se dispare cuando se inserte un pedido
--y modifique el stock del producto vendido, verificar si hay suficiente stock sino se cancela 
--el pedido

Select * from Pedidos

select * from Pedidos


create or alter trigger tg_pedidos_insertar 
on pedidos 
after insert
as begin 
		declare @existencia int 
		declare @fab char(3)
		declare @prod char(5)
		declare @cantidad int

	select @fab = fab,@prod = Producto, @cantidad = cantidad  from inserted
	select @existencia = stock from Productos
	where Id_fab = @fab and Id_producto = @prod

	IF @existencia > (select cantidad from inserted)
	begin 
		UPDATE Productos
		set Stock = Stock - @cantidad
		where Id_fab = @fab and 
		Id_producto = @prod

	end
	else 
	begin
	raiserror('No hay suficiente stock para el pedido',16,1)
	rollback;
end
end;



select * from Pedidos
select max (Num_Pedido) from Pedidos
select * from Productos

declare @importe money
select @importe = (p.Cantidad * pr.Precio)
from Pedidos as p
inner join Productos as pr
on p.Fab = pr.Id_fab
and p.Producto = pr.Id_producto

insert into Pedidos (Num_Pedido, Fecha_Pedido,Cliente,
Rep, Fab, Producto, Cantidad, Importe)
values(113071, getdate(), 2103, 106, 'ACI','41001',77,@importe )


select * from Productos 
where Id_fab = 'ACI' 
and Id_producto = '41001'

select * from Pedidos
where Num_Pedido = 113071



--Crear un trigger que cada ves que se elimine un pedido se debe de actualizar
--el stock de los productos con la cantidad eliminada



CREATE OR ALTER TRIGGER tg_pedidos_eliminar 
ON Pedidos 
AFTER DELETE
AS 
BEGIN 
    BEGIN TRY
        DECLARE @existencia INT 
        DECLARE @fab CHAR(3)
        DECLARE @prod CHAR(5)
        DECLARE @cantidad INT

        -- Obtener los valores eliminados
        SELECT @fab = Fab, @prod = Producto, @cantidad = Cantidad FROM deleted

        -- Obtener el stock actual
        SELECT @existencia = Stock FROM Productos
        WHERE Id_fab = @fab AND Id_producto = @prod

        -- Actualizar el stock sumando la cantidad eliminada
        UPDATE Productos
        SET Stock = Stock + @cantidad
        WHERE Id_fab = @fab AND Id_producto = @prod
    END TRY
    BEGIN CATCH
        PRINT 'Error al actualizar el stock tras la eliminación del pedido';
        PRINT ERROR_MESSAGE();
    END CATCH
END


