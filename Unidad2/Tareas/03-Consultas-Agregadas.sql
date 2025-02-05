-- Consultas de agregados 
-- Nota: Solo devuelven un solo registro
-- sum, avg, count, count(*), max y min

-- Cuantos clientes tengo (con count *)

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