-- INMOBILIARIA DINDIO ----------------------------------------------------------------------------------------------------------
USE Inmobiliaria;

-- FUNCIONES

-- 1- calcular_monto_expensa_total -----------------------------------------------------------------------------------------
/*Descripción:
Esta función toma un id_depto un mes y año, y devuelve el monto total de la expensa de ese departamento, 
sumando el monto base, los extras y los gastos detallados asociados a esa expensa

Objetivo: 
	- Facilitar el cálculo del monto total a pagar por un departamento en un período específico
	- Permitir generar reportes o facturas automáticamente

Tablas manipuladas:
	- "expensas" para obtener el monto base, monto extra y deuda
	- "gastos_detallados" para sumar los gastos asociados a la expensa
*/

DELIMITER $$
CREATE FUNCTION calcular_monto_expensa_total(
    p_id_depto INT, 
    p_mes INT, 
    p_anio INT) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);

    SELECT 
        e.monto + IFNULL(e.monto_extra, 0) + IFNULL(SUM(g.monto), 0)
    INTO total
    FROM expensas e
    LEFT JOIN gastos_detallados g ON e.id_expensa = g.id_expensa
    WHERE e.id_depto = p_id_depto
      AND e.mes = p_mes
      AND e.anio = p_anio
    GROUP BY e.id_expensa;

    RETURN total;
END $$
DELIMITER ;

-- Ver el monto total de expensas del departamento 101 en marzo de 2025
SELECT calcular_monto_expensa_total(101, 3, 2025) AS Monto_Expensa_Total;

-- 2. calcular_dias_alquiler --------------------------------------------------------------------------------------------------
/*
Descripción:
Esta función toma un id_alquiler y devuelve la cantidad de días totales de ese alquiler temporal

Objetivo:
	- Permitir calcular montos totales de alquileres multiplicando por el monto diario
	- Ayudar a generar reportes de ocupación y facturación

Tablas manipuladas:
	- "alquileres" para obtener fecha_inicio y fecha_fin
*/

DELIMITER $$
CREATE FUNCTION calcular_dias_alquiler(
    p_id_alquiler INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE dias INT;

    SELECT DATEDIFF(a.fecha_fin, a.fecha_inicio) + 1
    INTO dias
    FROM alquileres a
    INNER JOIN inquilinos_generales i ON a.id_inquilino = i.id_inquilino
    WHERE a.id_alquiler = p_id_alquiler
      AND i.tipo_inquilino = 'TEMPORAL';  -- Solo quiero los temporales

    RETURN dias;
END $$
DELIMITER ;

-- Ver cuanto días se alquiló con id 15
SELECT calcular_dias_alquiler(15) AS Dias_alquilado;

-- Verifico el uso de las dos funciones detallando el total a pagar con datos del inquilino y departamento
SELECT 
    a.id_alquiler,
    a.id_depto,
    i.nombre,
    i.apellido,
    calcular_dias_alquiler(a.id_alquiler) AS dias_alquiler, -- cantidad de días alquilado
    a.monto_diario,
    a.monto_diario * calcular_dias_alquiler(a.id_alquiler) AS total_alquiler, -- calculo total del alquileres
    calcular_monto_expensa_total(a.id_depto, 3, 2025) AS total_expensas, -- expensas del mes de marzo 2025
    (a.monto_diario * calcular_dias_alquiler(a.id_alquiler) + 
     calcular_monto_expensa_total(a.id_depto, 3, 2025)) AS total_a_pagar -- calculo del total a pagar
FROM alquileres a
INNER JOIN inquilinos_generales i ON a.id_inquilino = i.id_inquilino
WHERE a.id_alquiler = 15;


