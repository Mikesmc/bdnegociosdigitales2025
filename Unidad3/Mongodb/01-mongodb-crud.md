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


## Insercion de un documento mas complejo con array

``` json

db.Empleado.insertOne({
nombre: 'Ivan',
apellido: 'Baltazar',
apellido2: 'Rodriguez',
aficiones: ['Cerveza', 'Canabis', 'Crico', 'Mentir']
})
```

**Eliminar una coleccion**
``` json
db.coleccion.drop()
```
__Ejemplo__
``` json
db.empleado.drop()
```

## Insercion de documentos mas complejos anidados y arrays

``` json
db.alumnos.insertOne(
{
    nombre: 'Jose luis',
    apellido1: 'Herrera',
    apellido2: 'Gallardor',
    edad: 41,
    estudios:[
        'Ingenieria en sistemas compitacionales', 
        'Maestria en administracion de Tecnologias de informacion'
    ],
    experiencia: {
        lenguaje: 'SQL',
        sgb: 'SqlServer',
        anios_experiencia: 20
    }
}
)
```

``` json

    db.alumnos.insertOne(
    {
        _id:3,
        nombre: 'Sergio',
        apellido: 'Ramos',
        equipo: 'Monterrey',
        aficiones: ['Dinero', 'Hombre', 'Fiesta'],
        talentos:{
            futbol: true,
            bañarse: false
        }
    })

```

## Insertar Multiples Documentos

``` json

db.alumnos.insertMany(
[
    {
        _id:12,
        nombre: 'Oswaldo',
        apellido: 'Venado',
        edad: 20,
        descripcion: 'Es un quejumbroso'

    },
    {
        nombre: 'MAritza',
        apellido: 'Rechicken',
        edad: 20,
        habilidades:[
            'Ser vibora', 'Ilusionar', 'Caguamear'
        ],
        direccion: {
            calle: 'Del infierno',
            numero: 666
        },
        esposos:[
            {
                nombre: 'Joshua',
                edad: 20,
                pension: -34,
                hijos: ['Ivan', 'Jose']
            },
            {
                nombre: 'Leo',
                edad: 15,
                pension: 70,
                complaciente:true
            }
        ]
    }
]
)

```

# Busquedas, Condiciones simples de igualdad metodo find()

1.- Seleccionar todos los documentos de la coleccion libros 

``` json
db.libros.find({})
```


2.- Seleccionar todos los documentos que sean de la editorial biblio 

``` json
db.libros.find({editorial: 'Biblio'})
```

3.- Mostrar todos los documentos que el precio sea 25 

``` json
db.libros.find({precio: 25})
```

4.- Mostrar todos los documentos que el titulo sea 'json para todos'

``` json
db.libros.find({titulo: 'JSON para todos'})
```

## Operadores de Comparación

[Operadores de Comparación](https://www.mongodb.com/docs/manual/reference/operator/query/)

![Operadores de Comparación](../img/operadores-Relacionales.png)

1. Mostrar todos los documentos donde el precio sea mayor a 25

db.libros.find({precio: {$gt:25}})

2. Mostrar todos los documentos donde el precio sea 25

db.libros.find({precio: {$eq:25}})

3. Mostrar todos los documentos cuya cantidad sea menor a 5

db.libros.find ({ cantidad: { $lt: 5 } })

4. Mostrar los documentos que pertenecen a la editorial biblio
o planeta

db.libros.find( { editorial: { $in: ['Biblio', 'Planeta'] } })

5. Mostrar todos los documentos de libros que cuestan de 20 a 25

db.libros.find(
{
    precio:{
        $in:[20,25]
    }
}
)
6. Recuperar todos los documentos que no cuesten 20 a 25

db.libros.find( { precio: { $nin: [20, 25] } })

## Instruccion finOne

7. Recuperar solo una fila (Devuelve el primer elemento que cumpla la condicion)

db.libros.findOne(
{
    precio:{
        $in:[20,25]
    }
}
)

## Operadores de logicos 

[Operadores logicos](https://www.mongodb.com/docs/manual/reference/operator/query-logical/)

- Dos posibles opciones
    1. La simple mediante condiciones separadas por comas
        - db.libros.find({condicion1, condicion2, .....}) -> Con esto asume que es una and

    1. Usando el operador $and
    { $and: [ { <expression1> }, { <expression2> } , ... , { <expressionN> } ] }
    - db.libros.find({ $and [{condicion1}, {condicion2}]})

1. Mostrar todos aquellos libros que cuesten mas de 25 y cuya cantidad sea inferior a 15

db.libros.find({precio: {$gt:25},cantidad:{$lt:15}})

db.libros.find(
    {
        $and:[
            {precio:{$gt:25}},
            {cantidad:{$lt:15}}
        ]
    }
)


### Operador Or ($or)

- Moatrar todos aquellos libros que cuesten mas de 25
o cuya cantidad sea inferior a 15

``` json

db.libros.find(
{
    $or :[
        {precio:{$gt:25}
        },
        {
            cantidad:{$lt:15}
        }
    ]
}
)


```



### Ejemplo con AND y OR combinados

- Mostrar los libros de la editorial Biblio con precio
mayor a 40 y libros de la editorial Planeta con precio mayor a 30

``` json
db.libros.find({
    $and: [
        { $or: [{ editorial: 'Biblio' }, { precio: { $gt: 30 } }] },
        { $or: [{ editorial: 'Planeta' }, { precio: { $gt: 20 } }] }
    ]
}
)

```

### Proyección  (ver ciertasmcolumnas)

***Sintaxis**

db.collections.find(filtro, columnas)

1. Seleccionar todos los libros, solo mostrando el titulo

db.libros.find({},{titulo: 1})

db.libros.find({},{titulo: 1, _id:0})

db.getCollection('libros').find(
  { editorial: 'Planeta' },
  { _id: 0, titulo: 1, editorial: 1, precio: 1 }
)

### Operador exists (Permite saber si un campo se encuntra o no en campo)

{ field: { $exists: <boolean> } }

db.libros.find({editorial:{exists:true}})

db.libros.insertOne(
    {
        _id:10,
        titulo: 'Mongo en Negocios Digitales',
        editorial:'Terra',
        precio: 125
    }
)

- Buscar todos los documentos que no tengan cantidad
db.libros.find({
    cantidad:{exists:false}
})

## Operador Type (permite solicitar a mongo sin un campo corresponde a un tipo)

[Operador Type](https://www.mongodb.com/docs/manual/reference/operator/query/type/)


-- Mostrar todos los documentos donde el precio sea de 
tipo double o entero o cualquier otro tipo de dato

db.libros.find(
    {
        precio:{$type:1}
    }
)

db.libros.find(
    {
        precio:{$type:16}
    }
)


db.libros.find(
    {
        precio:{$type:"int"}
    }
)

db.libros.insertMany(
    [
    {
        _id:12,
        titulo: 'IA',
        editorial: 'Terra',
        precio: 125,
        cantidad:20
    },
    {
        _id:13,
        titulo:'Python para todos',
        editorial: 2001,
        precio:200,
        cantidad: 30
    }
    ]
)

-- Seleccionar todos los documentos de libros donde los valores de la editorial sea string

db.libros.find(
    {
    editorial: { $type: "string" }
})

db.libros.find(
    {
    editorial: { $type: 16 }
})


# Modificando Documentos
## Comandos importantes 

1. UpdateOne -> Modifica un solo docuento
2. UpdateMany -> Modifica multiples documentos
3. ReplaceOne -> Sustituir el contenido completo de un documento

``` json

db.collection.updateOne(
{filtro},
{operador}
)

```

[Operadores Update](https://www.mongodb.com/docs/manual/reference/operator/update/)

***Operador $set**

1. Modificar un documento 

``` json
    db.libros.updateOne({titulo: 'Python para todos'},{$set:{titulo:'Java para todos'}})
```


--  Modificar el documento con el id 10, estableciendo el precio de 100 y la cantidad en 50


db.libros.updateOne(
    { _id: 10 },
    { $set: { precio: 100, cantidad: 50 } }
)

-- Utilizando el updateMany modificar todos los libros donde el precio sea mayor a 100 y cambiarlo a 150


db.libros.updateMany(
    { precio: { $gt: 100 } },
    { $set: { precio: 150 } }
)

## Operadores $inc y $nul

-- Incrementar todos los precios de los libros en 5

``` json

db.libros.updateMany(
{editorial: 'Terra'},
{
    $inc:{precio:5}
}
)


```

Multiplicar todos los libros donde la cantidad sea mayor a 20 multiplicar su cantidad por 2 ($mul)

db.libros.updateMany(
    { cantidad: { $gt: 20 } },
    { $mul: { cantidad: 2 } }
)


-- Actualizar todos los libros multiplicando por 2 la cantidad y el precio de todos aquellos libros donde el precio sea mayor a 20 

db.libros.updateMany(
    { precio: { $gt: 20 } },
    { $mul: { cantidad: 2, precio: 2 } }
)

## Remplazar documentos(replaceOne)

-- Actualizar todo el documento del id 2 por el titulo De la tierra ala luna, el autor Julio Verne, edtorial Terra, precio 100

db.libros.replaceOne(
    {_id:2},
    { 
    titulo: 'De la tierra ala luna',
    autor: 'Julio Verne',
    editorial: 'Terra',
    precio: 100
    }
)

## Borrar documentos

1. deleteOne -> elimina un solo documento 
2. deleteMany -> elimina multiples documentos

-- Eliminar el documento con el id 2
``` json
db.libros.deleteOne(
    {
        _id:2
    }
)
```

-- Eliminar todos los libros donde la cantidad sea mayor a 150


db.libros.deleteMany(
    {
        cantidad:{$gt:150}
    }
)


## Expresiones regulares


-- Seleccionar todos los libros que contengan en el titulo una t minuscula

db.libros.find({titulo:/t/})


-- Seleccionar todos los libros que en el titulo contengan la palabra json

db.libros.find({titulo:/JSON/})


-- Seleccionar todos los libros que en el titulo termine con tos

db.libros.find({titulo://tos$})

-- Seleccionar todos los libros que en el titulos comiencen con J


db.libros.find({ titulo: /^J/ })

## Operador $regex

[Operador REGEX](https://www.mongodb.com/docs/manual/reference/operator/query/regex/)

--Seleccionar los libros que no contengan la palabra para

db.libros.find(
    {
        titulo:{
            $regex:'para'
        }
    }
)


--Selecionar todos los titulos que contengan la palabra JSON

db.libros.find(
    { 
        titulo: /JSON/ 
    }
)


db.libros.find(
    {
        titulo:{
            $regex:/json/,$options:'i'
        }
    }
)


-- Seleccionar todos los libros donde el titulo comience con j y no distinga entre mayusculas y minuscula 

db.libros.find(
    {
        titulo:{
            $regex:/json/,$options:'i'
        }
    }
)

-- Seleccionar todos los libros donde el titulo termine con "es"  y no distinga entre mayusculas y minuscula 

db.libros.find({
    titulo: { $regex: /es$/, $options: 'i' }
})



## Metodo sort (Ordenar Documentos)

-- Ordernar los libros de manera ascendente por el precio

db.libros.find({},
    {
        _id:0,
        titulo:1,
        precio:1
}).sort({precio:1})

-- Ordenar los libros de manera descendente por el precio
``` json
db.libros.find({},
    {
        _id:0,
        titulo:1,
        precio:1
}).sort({precio:-1})
```

-- Ordenar los libros de manera ascendente por la editorial y de manera descendente por el precio mostrando el titulo, precio y editorial
``` json
db.libros.find(
    {},
    {editorial: 1,precio: 1 }
).sort({ editorial: 1, precio: -1 })
```

## Otros metodos skip, limit, size

-- Mostrar cuantos libros se encuentran en la inicial de j(size)
``` json
db.libros.find(
    {
        titulo:{
            $regex:/j/,$options:'i'
        }
    }
).size()
```

-- Buscar todos los libros pero mostrando los dos primeros

``` json
db.libros.find({}).limit(2)

```
--Utilizando skip
``` json
db.libros.find({}).skip(2)

```
## Borrar colecciones y base de datos

--Borrar base
``` json
db.libros.drop()
```

--Borrar base completa
``` json
db.dropDatabase()
```