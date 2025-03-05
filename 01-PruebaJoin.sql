

select c.categoriaid, c.nombre, p.categoriaid, p.productoid, p.nombre 
from Categorias as c
inner join Producto as p
on p.categoriaid = c.categoriaid

select c.categoriaid, c.nombre, p.categoriaid, p.productoid, p.nombre 
from Categorias as c
left join Producto as p
on p.categoriaid = c.categoriaid


select c.categoriaid, c.nombre, p.categoriaid, p.productoid, p.nombre 
from Producto as p
left join Categorias as c
on p.categoriaid = c.categoriaid