# Consultas Creacion de base de datos SQL


``` SQL



--Creacion de base de datos en SQL-Server
-- EN construccion-- SQL-LDD 
-- Crear base de datos bdentornosvip

CREATE DATABASE bdentornosvip
go

-- Cambiar de base de datos
USE bdentornosvip
go

-- Crear la tabla categoria
CREATE TABLE tblcategoria(
	categoriaId int not null,
	descripcion varchar(100) not null,
	constraint pk_tblcategoria
	primary key(categoriaId),
	constraint unique_descripcion
	unique(descripcion)
)
go
-- Crear la tabla Productos
CREATE TABLE tblProducto(
  productoId int not null, 
  nombreP varchar(50) not null,
  precio decimal(10,2) not null, 
  existencia int not null,
  categoriaId int not null, 
  constraint pk_tblProducto
  primary key(productoId),
  constraint unique_nombreP
  unique(nombreP),
  constraint chk_precio
  check(precio>0.0 and precio<=10000), 
  constraint chk_existencia
  check(existencia>=0),
  constraint fk_tblProducto_tblcategoria
  foreign key(categoriaId)
  references tblcategoria(categoriaId)
)

```