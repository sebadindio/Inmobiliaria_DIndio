# <h1 align="center">🏛️ Inmobiliaria_DIndio 🏛️</h1> 
Primera entrega de Proyecto de SQL
---
---

## **Índice**  

1. [Introducción](#introducción)  
2. [Objetivos](#objetivos)  
3. [Situación Problematica](#situación-problematica)  
4. [Modelo de negocio](#modelo-de-negocio)  
5. [Descripcion de la Base de Datos](#descripcion-de-la-base-de-datos)
6. [Vistas]
7. [Funciones]
8. [Stored Procedures]
9. [Trigger]
10. [Scripts de la Base de Datos](#scripts-de-la-base-de-datos)  

---

## Introducción
<br>

``` sh
La gestión de propiedades inmobiliarias implica manejar gran cantidad de datos relacionados con propietarios, edificios,
departamentos, inquilinos y gastos asociados. Un sistema de base de datos bien estructurado permite organizar, optimizar y
controlar la información de manera eficiente, reduciendo errores y agilizando la generación de reportes, como el cálculo de
expensas.
En este proyecto, se desarrolló una base de datos relacional para una inmobiliaria que administra varios edificios, con el
fin de centralizar la información y facilitar el acceso a datos relevantes para la toma de decisiones.

```


## Objetivos
<br>

```sh
Objetivo general:
Diseñar y desarrollar una base de datos que permita gestionar la información de los propietarios, departamentos, inquilinos y
expensas de una inmobiliaria, garantizando integridad, consistencia y rapidez en las consultas.

Objetivos específicos:
  - Organizar y unificar la información dispersa en un sistema centralizado.
  - Facilitar el registro y actualización de datos de forma rápida y segura.
  - Automatizar el cálculo de expensas y gastos asociados a cada departamento.
  - Generar reportes detallados para la administración y control financiero.
  - Permitir la gestión diferenciada de alquileres temporales y permanentes.
```

## Situación Problematica
<br>

```sh
Actualmente, la inmobiliaria maneja los registros de propietarios, inquilinos y gastos de manera descentralizada, utilizando
planillas y documentos aislados. Esto provoca duplicación de datos, pérdida de información, errores en los cálculos y demoras
en la emisión de las expensas. La falta de integración entre los datos de edificios, departamentos, propietarios y gastos
dificulta la trazabilidad de la información y complica la toma de decisiones.
```


## Modelo de negocio
<br>

```sh
La inmobiliaria administra tres edificios con distintos tipos de alquileres: permanentes y temporales. Cada edificio tiene
múltiples departamentos con propietarios individuales o empresas.
Los ingresos principales provienen de los alquileres y elcobro de expensas, mientras que los egresos están relacionados con
mantenimiento, servicios y mejoras edilicias. El modelo de datos diseñado contempla:
  - Registro y vinculación de propietarios con sus departamentos.
  - Gestión de inquilinos permanentes y temporales.
  - Registro de expensas y gastos detallados.
  - Asociación de gastos específicos a cada expensa para un control más preciso.
  - Automatización de cálculos para determinar montos totales a pagar por mes o período.

```

## Descripcion de la Base de Datos
<br>

```sh
A continuación, se describe cada una de las tablas que conforman esta base de datos y las relaciones que permiten establecer
vínculos entre los registros de las diferentes tablas, facilitar el acceso y la manipulación de los mismos a través de las
claves foráneas referidas a las primerias de otras tablas, las cuales de detallan a continuación:

    1. Tabla "propietarios":

Registra la información de los dueños de los departamentos administrados por la inmobiliaria.
Incluye datos personales como nombre, apellido, email y teléfono, permitiendo identificar y contactar a cada propietario.
Uso principal: vincular departamentos con sus respectivos dueños.
Clave primaria: id_propietario. Identificador único para cada dueño.
No tiene claves foráneas.

    2. Tabla "edificio":

Almacena la información básica de cada edificio que administra la inmobiliaria.
Contiene el nombre del edificio, dirección y fecha de construcción.
Uso principal: identificar a qué edificio pertenece cada departamento y gestionar información general del inmueble.
Clave primaria: id_edificio. Identificador único de cada edificio.
No tiene claves foráneas.

    3. Tabla "departamentos":

Guarda los datos de cada unidad habitacional.
Incluye piso, número, dimensiones y las referencias a su propietario y edificio.
Uso principal: centralizar la información de cada departamento y servir de enlace para expensas, alquileres y ocupantes.
Clave primaria: id_depto. Identificador único de cada departamento.
Clave foránea: id_propietario (relacionada con la tabla "propietarios").
Clave foránea: id_edificio (relacionada con la tabla "edificio").
Estás claves foráneas se utilizan para relacionar la información de cada departamento con el propietario.

    4. Tabla "expensas":

Registra los pagos mensuales y otros cargos asociados al mantenimiento del edificio y sus servicios comunes.
Incluye el monto, monto extra, deuda y fecha de pago, asociados a un departamento específico.
Uso principal: llevar control financiero de las expensas de cada unidad.
Clave primaria: id_expensa.
Clave foránea: id_depto (relacionada con la tabla "departamentos").

    5. Tabla "inquilinos_temporales":

Almacena datos personales de personas que alquilan departamentos por períodos cortos.
Contiene nombre, apellido, email, teléfono, documento y fecha de nacimiento.
Uso principal: identificación y contacto de inquilinos en alquiler temporal.
Clave primaria: id_inquilino.
No tiene claves foráneas.

    6. Tabla "alquiler_temporal":

Registra la relación entre un departamento y un inquilino temporal para un período específico.
Incluye fechas de ingreso y salida, monto diario y monto total del alquiler, además de la referencia al propietario.
Uso principal: gestión de contratos de alquiler temporal y cálculo de ingresos.
Clave primaria: id_alquiler
Clave foránea: id_depto (relacionada con la tabla "departamentos").
Clave foránea: id_inquilino (relacionada con la tabla "inquilinos_temporales").

      7. Tabla "gastos_detallados":

Desglosa los gastos específicos que conforman las expensas.
Incluye descripción, monto y fecha del gasto, además de la referencia a la expensa correspondiente.
Uso principal: dar transparencia y detalle sobre el origen de los costos incluidos en las expensas.
Clave primaria: id_gasto.
Clave foránea: id_expensa (relacionada con la tabla "expensas").

```
## Vistas (5)
más una descripción detallada, su objetivo, y qué tablas las componen.

## Funciones (2)
que incluyan una descripción detallada, el objetivo para la cual fueron creadas y qué datos o tablas manipulan y/o son implementadas.

## Stored Procedures (2)
con una descripción detallada, qué objetivo o beneficio aportan al proyecto, y las tablas que lo componen y/o tablas con las que interactúa.

## Trigger (2)



Un archivo .sql que contenga:

Script de inserción de datos en las bases.

Si se insertan datos mediante importación, agregar el paso a paso de éste en el DOC PDF más los archivos con el contenido a importar, en el formato que corresponda.

Script de creación de Vistas, Funciones, Stored Procedures y Triggers. <---------------> Formato


Documento PDF con el nombre “Entrega2 + Apellido”.





<br>

## Scripts de la Base de Datos
Click en los siguientes enlaces:
<br>

- <a href="./Tabla_create.sql"> Creacion de la Base de Datos </a><br>
- <a href="./Insertar_datos.sql">Script de Inserción de Datos de las tablas principales</a><br>
- <a href="./Insertar_datos_extras.sql">Script de Inserción de Datos de tablas adicionales</a><br>
- <a href="./Diagrama_ER.png">Diagrama Entidad-Relación</a>

<br>

---
### Autor: Sebastián D'Indio

### Comisión #81830 - CoderHouse

---
