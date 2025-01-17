# Creacion de la base de datos tienda1

# Crear base de datos 


create database tienda1;

# Utilizar una base de datos

use tienda1;

# Crear la tabla categoria
# SQL-LDD

create table categoria(
categoriaid int not null,
nombre varchar(20) not null,
constraint pk_categoria
primary key (categoriaid),
constraint unico_nombre
unique(nombre)
);

# SQL-LMD

# Agregar registros ala tabla categoria4

insert into categoria 
values (1, 'Carnes Frias');

insert into categoria(categoriaid, nombre)
values (2, 'Linea Blanca');


insert into categoria(nombre, categoriaid)
values ('Vinos y Licores', 3);

insert into categoria
values (4, 'Ropa'),
		(5, 'Dulce'),
        (6, 'Lacteos');

insert into categoria(nombre, categoriaid)
values ('Panaderia', 7),
		('Zapateria', 8),
		('Jugueteria', 9);
		
insert into categoria
values (7, 'Panaderia');

select * from categoria;
