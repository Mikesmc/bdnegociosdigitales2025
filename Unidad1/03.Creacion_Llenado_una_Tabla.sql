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


#Crear Tabla nueva

create table producto1(
productoid int not null,
nombreProducto varchar (20) not null,
descripcion varchar (80),
precio decimal(10,2) not null,
existencia int not null,
categoriaid int null,
constraint pk_producto1
primary key (productoid),
constraint unico_descripcion
unique(nombreProducto),
constraint chk_precio
check (precio>0.0 and precio<=1000),
constraint chk_existencia
check (existencia>0 and existencia<=200),
constraint fk_categoria_producto1
foreign key (categoriaid)
references categoria(categoriaid)

);

insert into producto1
values (1, 'Miguelitos', 'Dulces sano para la lombriz',34.5, 45, 5);

insert into producto1
values (2, 'Tupsi Pop', 'Dulces sano para el diente',34.5, 45, 5);

insert into producto1
values (3, 'Plancha', 'plancha para suit',256.3,134, 2);

select * from producto1
where categoriaid=5

