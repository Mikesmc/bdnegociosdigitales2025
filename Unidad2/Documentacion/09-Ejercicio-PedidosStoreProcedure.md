# Ejercicio de Pedidos con Store procedure

- Realizar un pedido
- Validar que el pedido no exista
- Validar que el cliente, el empleado y el producto exista
- Validar que la cantidad a vender tenga suficiente stock
- Insertar el pedido y calcular el importe(Multiplicando el precio del producto por cantidad vendida)
- Actualizar el stock del producto (restando el stock menos la cantidad vendida)

```SQL
--Existente
execute spu_pedido_submit @numpedido = 112961, @cliente = 2117, @rep =106, 
@fab ='REI', @producto ='2A44L', @cantidad =20
-- Cliente
execute spu_pedido_submit @numpedido = 112960, @cliente = 2190, @rep =106, 
@fab ='REI', @producto ='2A44L', @cantidad =20
-- Representante
execute spu_pedido_submit @numpedido = 112961, @cliente = 2117, @rep =106, 
@fab ='REI', @producto ='2A44L', @cantidad =20
-- Fabricante
execute spu_pedido_submit @numpedido = 112961, @cliente = 2117, @rep =106, 
@fab ='REI', @producto ='2A44L', @cantidad =20
-- Producto
execute spu_pedido_submit @numpedido = 112961, @cliente = 2117, @rep =106, 
@fab ='REI', @producto ='2A44L', @cantidad =20
-- Cantidad
execute spu_pedido_submit @numpedido = 112961, @cliente = 2117, @rep =106, 
@fab ='REI', @producto ='2A44L', @cantidad =20
 ```