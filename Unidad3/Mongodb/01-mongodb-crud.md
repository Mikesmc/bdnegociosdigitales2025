 # MongoDB Crud

 ## Crear una base de datos 
**Solo se crea si contiene una coleccion**

```json 
use base de datos
```
## Crear una Coleccion 

`use bd1
db.createCollection('Empleado')`

## Mostrar collecciones

`show collections`

## Insercion de un documento
db.Empleado.insertOne(
    {
    nombre:'Soyla',
    apellido: 'Vaca',
    edad:32,
    ciudad: 'San Miguel de las Piedras'
    }
)