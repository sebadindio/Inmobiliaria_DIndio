-- INMOBILIARIA DINDIO ----------------------------------------------------------------------------------------------------------
USE Inmobiliaria;

-- VISTAS 
/* Descripción breve del contenido
Se ven reflejadas estas 5 vistas 
	- Deuda de expensas
	- Relación propietarios/departamentos
	- Control de alquileres activos
	- Desglose de gastos en expensas
	- Análisis financiero por edificio
	- Disponibilidad de departamentos
*/

-- 1- vista_expensas_pendientes ------------------------------------------------------------------------------------------------
-- Objetivo: Identificar expensas no pagadas y los propietarios responsables
CREATE VIEW vista_expensas_pendientes AS
SELECT 
    e.id_expensa,
    d.id_depto,
    p.nombre AS propietario_nombre,
    p.apellido AS propietario_apellido,
    e.mes,
    e.anio,
    e.monto,
    e.monto_extra,
    e.deuda
FROM expensas e
INNER JOIN departamentos d ON e.id_depto = d.id_depto
INNER JOIN propietarios p ON d.id_propietario = p.id_propietario
WHERE e.pagado = FALSE;

-- Esta vista seria util si necesito listar todas las expensas pendientes de cada mes ordenadas por mayor deuda
-- Así poder identificar rápidamente los propietarios más atrasados con las expensas
SELECT 
    propietario_nombre,
    propietario_apellido,
    id_depto,
    mes,
    anio,
    deuda
FROM vista_expensas_pendientes
ORDER BY deuda DESC;


-- 2- vista_propietarios_deptos -------------------------------------------------------------------------------------------------
-- Objetivo: Ver qué departamentos posee cada propietario y en qué edificio están
CREATE VIEW vista_propietarios_deptos AS
SELECT 
    p.id_propietario,
    CONCAT(p.nombre, ' ', p.apellido) AS propietario,
    d.id_depto,
    d.piso,
    d.numero,
    e.nombre,
    e.ciudad
FROM propietarios p
INNER JOIN departamentos d ON p.id_propietario = d.id_propietario
INNER JOIN edificios e ON d.id_edificio = e.id_edificio;

-- Por ejemplo, mostrar todos los propietarios con más de un departamento
SELECT 
    propietario,
    COUNT(id_depto) AS cantidad_departamentos
FROM vista_propietarios_deptos
GROUP BY propietario
HAVING COUNT(id_depto) > 1;


-- 3- vista_alquileres_activos -----------------------------------------------------------------------------------------------------
-- Objetivo: Saber qué departamentos están alquilados en este momento
CREATE OR REPLACE VIEW vista_alquileres_activos AS
SELECT 
    a.id_alquiler,
    d.id_depto,
    i.nombre AS inquilino_nombre,
    i.apellido AS inquilino_apellido,
    a.fecha_inicio,
    a.fecha_fin,
    a.monto_diario,
    a.gastos_mantenimiento
FROM alquileres a
INNER JOIN departamentos d ON a.id_depto = d.id_depto
INNER JOIN inquilinos_generales i ON a.id_inquilino = i.id_inquilino
WHERE CURDATE() BETWEEN a.fecha_inicio AND a.fecha_fin;

/* Por ejemplo, ver qué departamentos están alquilados actualmente en el edificio "Tempo"
Antes consultas de reservas y ofrecer unidades libres, evitando solapar o inconvenientes 
También controlar la ocupación temporal de un edificio específico
*/
SELECT 
    id_alquiler,
    id_depto,
    inquilino_nombre,
    inquilino_apellido,
    fecha_inicio,
    fecha_fin,
    monto_diario
FROM vista_alquileres_activos
WHERE id_depto IN (
    SELECT d.id_depto 
    FROM departamentos d
    INNER JOIN edificios e ON d.id_edificio = e.id_edificio
    WHERE e.nombre = 'Tempo');
-- En este caso estan todos ocupados para Tempo por la creación de la BD, por eso no aparece ninguno


-- 4- vista_gastos_expensas -------------------------------------------------------------------------------------------------------
-- Objetivo: Ver qué gastos específicos forman parte de las expensas
CREATE OR REPLACE VIEW vista_gastos_expensas AS
SELECT 
    e.id_expensa,
    d.id_depto,
    g.descripcion,
    g.monto AS monto_gasto,
    g.fecha AS fecha_gasto,
    e.monto AS monto_base,
    e.monto_extra,
    e.deuda
FROM expensas e
INNER JOIN departamentos d ON e.id_depto = d.id_depto
LEFT JOIN gastos_detallados g ON e.id_expensa = g.id_expensa;

-- Ejemplo: Ver el desglose de gastos de las expensas de un departamento si el propietario lo requiere
SELECT 
    descripcion,
    monto_gasto,
    fecha_gasto,
    monto_base,
    monto_extra,
    deuda
FROM vista_gastos_expensas
WHERE id_depto = 4;


-- 5- vista_ingresos_por_edificio -------------------------------------------------------------------------------------------------
-- Objetivo: Obtener un balance de ingresos por expensas y alquileres en cada edificio, evaluar es el más rentables 
-- y priorizar su gestión
CREATE OR REPLACE VIEW vista_ingresos_por_edificio AS
SELECT 
    ed.nombre,
    ed.ciudad,
    SUM(e.monto + e.monto_extra - e.deuda) AS total_expensas,
    SUM(a.monto_diario * DATEDIFF(a.fecha_fin, a.fecha_inicio) + a.gastos_mantenimiento) AS total_alquileres,
    (SUM(e.monto + e.monto_extra - e.deuda) + 
     SUM(a.monto_diario * DATEDIFF(a.fecha_fin, a.fecha_inicio) + a.gastos_mantenimiento)) AS total_ingresos
FROM edificios ed
LEFT JOIN departamentos d ON ed.id_edificio = d.id_edificio
LEFT JOIN expensas e ON d.id_depto = e.id_depto
LEFT JOIN alquileres a ON d.id_depto = a.id_depto
GROUP BY ed.id_edificio, ed.nombre, ed.ciudad;

-- Obtener el top 3 de edificios con mayores ingresos totales
SELECT 
    nombre,
    ciudad,
    total_expensas,
    total_alquileres,
    total_ingresos
FROM vista_ingresos_por_edificio
ORDER BY total_ingresos DESC;
-- En este caso es solo edificio Tempo, ya que no hay alquileres permanentes en los otros edificios aún



-- 6- vista_deptos_disponibles --------------------------------------------------------------------------------------------------
-- Objetivo: Ayudar a la inmobiliaria a saber qué unidades están libres para ofrecer
CREATE OR REPLACE VIEW vista_deptos_disponibles AS
SELECT 
    d.id_depto,
    e.nombre,
    e.ciudad,
    d.piso,
    d.numero
FROM departamentos d
INNER JOIN edificios e ON d.id_edificio = e.id_edificio
WHERE d.id_depto NOT IN (
    SELECT a.id_depto
    FROM alquileres a
    INNER JOIN inquilinos_generales i ON a.id_inquilino = i.id_inquilino
    WHERE i.tipo_inquilino = 'TEMPORAL' AND CURDATE() BETWEEN a.fecha_inicio AND a.fecha_fin);
    
-- Por ejemplo ver cuales estan libres hasta el momento para ofrecer a nuevos inquilinos
SELECT 
    id_depto,
    piso,
    numero,
    ciudad
FROM vista_deptos_disponibles
WHERE nombre = 'Tempo'
ORDER BY piso, numero;
