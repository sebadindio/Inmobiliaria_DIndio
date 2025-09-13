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
6. [Vistas](#vistas)
7. [Funciones](#funciones)
8. [Stored Procedures](#stored-procedures)
9. [Trigger](#trigger)
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
Los ingresos principales provienen de los alquileres y el cobro de expensas, mientras que los egresos están relacionados con
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

    5. Tabla "inquilinos_generales":

Almacena datos personales de personas que alquilan departamentos por períodos cortos.
Contiene tipo_inquilino, nombre, apellido, email, teléfono, documento y fecha de nacimiento.
Uso principal: identificación y contacto de inquilinos en alquiler temporal.
Clave primaria: id_inquilino.
No tiene claves foráneas.

    6. Tabla "alquileres":

Registra la relación entre un departamento y un inquilino temporal para un período específico.
Incluye fechas de ingreso y salida, monto diario y monto total del alquiler, además de la referencia al propietario.
Uso principal: gestión de contratos de alquiler temporal y cálculo de ingresos.
Clave primaria: id_alquiler
Clave foránea: id_depto (relacionada con la tabla "departamentos").
Clave foránea: id_inquilino (relacionada con la tabla "inquilinos_generales").

      7. Tabla "gastos_detallados":

Desglosa los gastos específicos que conforman las expensas.
Incluye descripción, monto y fecha del gasto, además de la referencia a la expensa correspondiente.
Uso principal: dar transparencia y detalle sobre el origen de los costos incluidos en las expensas.
Clave primaria: id_gasto.
Clave foránea: id_expensa (relacionada con la tabla "expensas").

```
## Vistas
<br>

``` sh
Se definen seis vistas que cubren los principales aspectos y para uso de consultas rápidas
de la gestión inmobiliaria, como así tambien ejemplos de utilidad en la practica:
  - Deuda de expensas
  - Relación propietarios/departamentos
  - Control de alquileres activos
  - Desglose de gastos en expensas
  - Análisis financiero por edificio
  - Disponibilidad de departamentos.

      1. Vista "vista_expensas_pendientes"

Descripción: Muestra todas las expensas que aún no fueron pagadas por los propietarios.
Objetivo: Permitir un control rápido de la deuda y seguimiento de pagos atrasados, es decir, identificar las expensas
 no pagadas y los propietarios responsables.
Tablas involucradas: expensas, departamentos, propietarios.

      2. Vista "vista_propietarios_deptos"
      
Descripción: Lista todos los propietarios junto con los departamentos que poseen.
Objetivo: Tener una visión clara de qué departamentos corresponden a cada propietario y en que edificio están, incluso
si tienen más de uno.
Tablas involucradas: propietarios, departamentos, edificios.

      3. Vista "vista_alquileres_activos"

Descripción: Muestra los alquileres temporales que están vigentes (fecha actual entre inicio y fin).
Objetivo: Saber en tiempo real qué departamentos están ocupados y cuáles disponibles.
Tablas involucradas: alquileres, departamentos, inquilinos_generales.

      4. Vista "vista_gastos_expensas"

Descripción: Relaciona las expensas con el detalle de gastos individuales.
Objetivo: Permitir un desglose de los gastos de mantenimiento que componen las expensas de cada departamento.
Tablas involucradas: expensas, gastos_detallados.

      5. Vista "vista_ingresos_por_edificio"

Descripción: Resume el total recaudado por expensas y alquileres temporales agrupado por edificio.
Objetivo: Evaluar el rendimiento económico de cada edificio y detectar cuáles generan mayores ingresos.
Tablas involucradas: expensas, alquileres, departamentos, edificios.

      6. Vista "vista_deptos_disponibles"

Descripción: Lista todos los departamentos que no están alquilados actualmente en el sistema de alquiler temporal.
Objetivo: Ayudar a la inmobiliaria a saber qué unidades están libres para ofrecer.
Tablas involucradas: departamentos, alquileres, edificios.

```

## Funciones
<br>

``` sh
      1- Función "calcular_monto_expensa_total"

Descripción: Esta función toma un id_depto un mes y año, y devuelve el monto total de la expensa de ese departamento, 
sumando el monto base, los extras y los gastos detallados asociados a esa expensa.
Objetivo: 
	- Facilitar el cálculo del monto total a pagar por un departamento en un período específico.
	- Permitir generar reportes o facturas automáticamente.
Tablas manipuladas:
	- "expensas" para obtener el monto base, monto extra y deuda.
	- "gastos_detallados" para sumar los gastos asociados a la expensa.

      2. Función "calcular_dias_alquiler"

Descripción: Esta función toma un id_alquiler y devuelve la cantidad de días totales de ese alquiler temporal.
Objetivo:
	- Permitir calcular montos totales de alquileres multiplicando por el monto diario.
	- Ayudar a generar reportes de ocupación y facturación.
Tablas manipuladas:
	- "alquileres" para obtener fecha_inicio y fecha_fin.


```

## Stored Procedures
<br>

``` sh
      1- SP "sp_agregar_expensa"

Descripción: Este procedimiento permite agregar automáticamente una expensa para un departamento específico, 
incluyendo el monto base, monto extra, fecha de pago y deuda
Objetivo:
	- Facilita la carga de expensas mensual sin necesidad de insertar manualmente cada registro
	- Reduce errores de duplicación y agiliza la administración
Tablas involucradas:	
	- "expensas" se inserta el registro
	- "departamentos" se valida que el departamento exista

      2- SP "sp_registrar_alquiler"

Descripción: Permite registrar un nuevo alquiler temporal o permanente en la tabla alquileres, 
calculando automáticamente los días totales y validando que el departamento esté disponible en las fechas ingresadas
Objetivos:
	- Automatiza la creación de alquileres
	- Evita conflictos de fechas y sobreposición de alquileres
	- Centraliza la lógica de validación de disponibilidad
Tablas involucradas:
	- "alquileres" como registro principal
	- "departamentos" para verificar existencia y disponibilidad
	- "inquilinos_generales" para asociar el inquilino al alquiler

      3- SP "sp_generar_reporte_expensas"

Descripción: Genera un reporte completo de expensas de todos los departamentos para un mes y año específicos, 
incluyendo el total de gastos detallados
Objetivo:
	- Facilita la generación de reportes mensuales para administración y contabilidad
	- Automatiza el cálculo de totales y la unión de datos de varias tablas
Tablas involucradas:
	- "expensas" son datos base de expensas
	- "gastos_detallados" suma de gastos asociados a cada expensa
	- "departamentos y edificios" información adicional para identificar cada departamento y edificio

      4- SP "sp_actualizar_estado_pago"

Descripción: Actualiza el estado de una expensa y la fecha de pago
Objetivo:
	- Permite registrar pagos de expensas de manera rápida
	- Evita inconsistencias manuales en los registros
Tablas involucradas: "expensas" actualización de pagado y fecha_pago

```

## Trigger
<br>

``` sh
      1- Trigger "trg_actualizar_deuda_expensa"

Funcionalidad: Se ejecuta después de agregar o actualizar una expensa. Tambien calcula automáticamente la deuda 
si la expensa no fue pagada en su totalidad
Objetivo:
	- Mantener actualizado el monto de la deuda sin necesidad de hacerlo manualmente
	- Facilita reportes de deudores y seguimiento de pagos
Tablas involucrada: expensas 

      2- Trigger "trg_validar_fecha_alquiler"

Funcionalidad: se ejecuta antes de agregar o actualizar un alquiler. Valida que las fechas de inicio y fin no se 
superpongan con otros alquileres del mismo departamento
Objetivo:
	- Evitar conflictos de disponibilidad de departamentos
	- Mantener integridad de la información de alquileres
Tabla involucrada: alquileres

      3- Trigger "trg_actualizar_total_expensas"

Funcionalidad: se ejecuta después de agregar o actualizar un gasto detallado. Actualiza automáticamente el total de la
expensa asociada (monto + monto_extra + suma de gastos)
Objetivo: mantener el total de expensas actualizado para reportes o cálculos de deuda
Tablas involucradas: gastos_detallados y expensas

```

<br>

## Scripts de la Base de Datos
Click en los siguientes enlaces:
<br>

- <a href="./Tabla_create.sql"> Creacion de la Base de Datos </a><br>
- <a href="./Insertar_datos.sql">Script de Inserción de Datos de las tablas principales</a><br>
- <a href="./Insertar_datos_extras.sql">Script de Inserción de Datos de tablas adicionales</a><br>
- <a href="./Diagrama_ER.png">Diagrama Entidad-Relación</a><br>
- <a href="./Vistas.sql">Script de las Vistas</a><br>
- <a href="./Funciones.sql">Script de las Funciones</a><br>
- <a href="./Store_procedures.sql">Script de Stored Procedures</a><br>
- <a href="./Triggers.sql">Script de Trigger</a>
<br>

---
### Autor: Sebastián D'Indio

### Comisión #81830 - CoderHouse

---
