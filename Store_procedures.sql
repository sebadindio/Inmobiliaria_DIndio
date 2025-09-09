-- INMOBILIARIA DINDIO ----------------------------------------------------------------------------------------------------------
USE Inmobiliaria;

-- STORE PROCEDURES

-- 1- sp_agregar_expensa -------------------------------------------------------------------------------------------------------
/*
Descripción: Este procedimiento permite agregar automáticamente una expensa para un departamento específico, 
incluyendo el monto base, monto extra, fecha de pago y deuda
Objetivo:
	- Facilita la carga de expensas mensual sin necesidad de insertar manualmente cada registro
	- Reduce errores de duplicación y agiliza la administración
Tablas involucradas:	
	- "expensas" se inserta el registro
	- "departamentos" se valida que el departamento exista
*/

DELIMITER $$
CREATE PROCEDURE sp_agregar_expensa(
    IN p_id_depto INT,
    IN p_mes INT,
    IN p_anio INT,
    IN p_monto DECIMAL(10,2),
    IN p_monto_extra DECIMAL(10,2),
    IN p_fecha_pago DATE)
BEGIN
    INSERT INTO expensas(id_depto, mes, anio, monto, monto_extra, deuda, fecha_pago, pagado)
    VALUES (p_id_depto, p_mes, p_anio, p_monto, p_monto_extra, 0.00, p_fecha_pago, FALSE);
END $$
DELIMITER ;

-- Para generar un nuevo registro en la expensa de un departamento
CALL sp_agregar_expensa(101, 3, 2025, 1500.00, 200.00, '2025-03-10');


-- 2- sp_registrar_alquiler -------------------------------------------------------------------------------------------------------
/* 
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
*/

DELIMITER $$
CREATE PROCEDURE sp_registrar_alquiler(
    IN p_id_depto INT,
    IN p_id_inquilino INT,
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE,
    IN p_monto_diario DECIMAL(10,2))
BEGIN
    DECLARE total INT;

    -- Verifico si está disponible
    SELECT COUNT(*) INTO total
    FROM alquileres
    WHERE id_depto = p_id_depto
      AND ((p_fecha_inicio BETWEEN fecha_inicio AND fecha_fin) OR (p_fecha_fin BETWEEN fecha_inicio AND fecha_fin));

    IF total = 0 THEN
        INSERT INTO alquileres(id_depto, id_inquilino, fecha_inicio, fecha_fin, monto_diario, gastos_mantenimiento)
        VALUES (p_id_depto, p_id_inquilino, p_fecha_inicio, p_fecha_fin, p_monto_diario, 0.00);
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Departamento no disponible en esas fechas';
    END IF;
END $$
DELIMITER ;

-- Registrar un nuevo alquiler temporal para el departamento 15 solo si el departamento esta disponible
CALL sp_registrar_alquiler(15, 5, '2025-03-01', '2025-05-01', 1500.00);



-- 3- sp_generar_reporte_expensas ------------------------------------------------------------------------------------------------
/*
Descripción: Genera un reporte completo de expensas de todos los departamentos para un mes y año específicos, 
incluyendo el total de gastos detallados
Objetivo:
	- Facilita la generación de reportes mensuales para administración y contabilidad
	- Automatiza el cálculo de totales y la unión de datos de varias tablas
Tablas involucradas:
	- "expensas" son datos base de expensas
	- "gastos_detallados" suma de gastos asociados a cada expensa
	- "departamentos y edificios" información adicional para identificar cada departamento y edificio
*/

DELIMITER $$
CREATE PROCEDURE sp_generar_reporte_expensas(
    IN p_mes INT,
    IN p_anio INT)
BEGIN
    SELECT 
        d.id_depto,
        e.nombre,
        d.piso,
        d.numero,
        e.ciudad,
        ex.monto + IFNULL(ex.monto_extra, 0) + IFNULL(SUM(g.monto), 0) AS total_expensa
    FROM expensas ex
    INNER JOIN departamentos d ON ex.id_depto = d.id_depto
    INNER JOIN edificios e ON d.id_edificio = e.id_edificio
    LEFT JOIN gastos_detallados g ON ex.id_expensa = g.id_expensa
    WHERE ex.mes = p_mes AND ex.anio = p_anio
    GROUP BY ex.id_expensa;
END $$
DELIMITER ;

-- Obtener un reporte de todas las expensas de marzo 2025, incluyendo gastos detallados
-- Me devuelve una tabla con id_depto, edificio, piso, número, ciudad y total de expensas detallada
CALL sp_generar_reporte_expensas(3, 2025);


-- 4- sp_actualizar_estado_pago -------------------------------------------------------------------------------------------------
/*
Descripción: Actualiza el estado de una expensa y la fecha de pago
Objetivo:
	- Permite registrar pagos de expensas de manera rápida
	- Evita inconsistencias manuales en los registros
Tablas involucradas:
	- "expensas" actualización de pagado y fecha_pago
*/

DELIMITER $$
CREATE PROCEDURE sp_actualizar_estado_pago(
    IN p_id_depto INT,
    IN p_mes INT,
    IN p_anio INT,
    IN p_pagado BOOLEAN,
    IN p_fecha_pago DATE
)
BEGIN
    UPDATE expensas
    SET pagado = p_pagado,
        fecha_pago = p_fecha_pago
    WHERE id_depto = p_id_depto
      AND mes = p_mes
      AND anio = p_anio;
END $$
DELIMITER ;

-- Registrar que el departamento 1 pagó su expensa de marzo 2025 y actualizar la BD
CALL sp_actualizar_estado_pago(1, 3, 2025, TRUE, '2025-03-12');

