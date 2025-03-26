# Consultas Transact funciones cadenas SQL


``` SQL
--Funciones de cadena, fecha, instrucciones de control, variables

--Las funciones de cadena permiten manipular tipos de datos 
--como varchar, nvarchar, char, nchar

--Funcion Len -> Devuelve la longitud de una cadena 

--Declaracion de una variale



Declare @Numero int;
set @Numero = 10;
print @numero


Declare @Texto varchar(50) = 'Hola, Mundo!';

--Obtener el tama�o de la cadena almacenada en la variable texto

select len(@Texto) as Longitud

select CompanyName, len(CompanyName) from Customers

--Funcion Lefts -> Extrae un numero especifico de caracteres
-- desde el inicio de la cadena

Declare @Texto varchar(50) = 'Hola, Mundo!';

select left (@texto,4 ) as Inicio


--Funcion Right -> Extrae un determinado numero de caracteres
--del final de la cadena

Declare @Texto varchar(50) = 'Hola, Mundo!';

select right (@texto,6 ) as Final

select CompanyName, len(CompanyName) as 'Numero de Caracteres',
left (CompanyName, 4) as Inicio,
Right (CompanyName, 6) as Final
from Customers


--SubString -> Extrae un parte de la cadena, donde el segundo parametro
-- es la posicion inicial y el tercer parametro el recorrido

Declare @Texto varchar(50) = 'Hola, Mundo!';

select substring(@texto,7,5) as Mundo

select CompanyName, len(CompanyName) as 'Numero de Caracteres',
left (CompanyName, 4) as Inicio,
Right (CompanyName, 6) as Final,
substring(@texto,7,5) as SubCadena
from Customers

--Replace -> Reemplaza una subcadena por otra

Declare @Texto varchar(50) = 'Hola, Mundo!';

select replace(@Texto, 'Mundo', 'Amigo')


-- CharIndex ->  Verifica en que posicion se encuentra el caracter
Declare @Texto varchar(50) = 'Hola, Mundo!';

select CHARINDEX('Mundo', @Texto)

--Upper -> Convierte una cadena en Mayusculas

--Convertir la palabra mundo en mayusculas unicamente
Declare @Texto varchar(50) = 'Hola, Mundo!';

select concat(
			left(@texto,6),'',
			upper( substring (@texto, 7, 5)),
			right(@texto,1)
			)as TextoNuevo


update Customers
set CompanyName=UPPER(CompanyName)
where country in ('Mexico', 'Germany')

select * from Customers

-- Trim quita espacios en blanco de una cadena 

SELECT TRIM( '     test    ') AS Result;


Declare @Texto varchar(50) = 'Hola, Mundo!';
select trim (@Texto)





```