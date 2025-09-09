-- INMOBILIARIA DINDIO ----------------------------------------------------------------------------------------------------------
USE Inmobiliaria;

-- TRIGGERS

-- 1- trg_actualizar_deuda_expensa ----------------------------------------------------------------------------------------------
/*
Funcionalidad: Se ejecuta después de agregar o actualizar una expensa. Tambien calcula automáticamente la deuda 
si la expensa no fue pagada en su totalidad
Objetivo:
	- Mantener actualizado el monto de la deuda sin necesidad de hacerlo manualmente
	- Facilita reportes de deudores y seguimiento de pagos
Tablas involucrada: expensas 
*/

DELIMITER $$
CREATE TRIGGER trg_actualizar_deuda_expensa
BEFORE INSERT ON expensas
FOR EACH ROW
BEGIN
    IF NEW.pagado = FALSE THEN
        SET NEW.deuda = NEW.monto + COALESCE(NEW.monto_extra,0);
    ELSE
        SET NEW.deuda = 0;
    END IF;
END $$
DELIMITER ;

-- Ejemplo
INSERT INTO expensas (id_depto, mes, anio, monto, monto_extra, pagado)
VALUES (101, 3, 2025, 1500.00, 200.00, FALSE);


-- 2- trg_validar_fecha_alquiler ------------------------------------------------------------------------------------------------------
/*
Funcionalidad: se ejecuta antes de agregar o actualizar un alquiler. Valida que las fechas de inicio y fin no se 
superpongan con otros alquileres del mismo departamento
Objetivo:
	- Evitar conflictos de disponibilidad de departamentos
	- Mantener integridad de la información de alquileres
Tabla involucrada: alquileres
*/

DELIMITER $$
CREATE TRIGGER trg_validar_fecha_alquiler
BEFORE INSERT ON alquileres
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM alquileres
        WHERE id_depto = NEW.id_depto
          AND (NEW.fecha_inicio BETWEEN fecha_inicio AND fecha_fin
               OR NEW.fecha_fin BETWEEN fecha_inicio AND fecha_fin)
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El departamento ya tiene un alquiler en ese rango de fechas';
    END IF;
END $$
DELIMITER ;

-- Ejemplo:
INSERT INTO alquileres (id_depto, id_inquilino, fecha_inicio, fecha_fin, monto_diario)
VALUES (105, 6, '2025-04-01', '2025-06-01', 1400.00);


-- 3- trg_actualizar_total_expensas -----------------------------------------------------------------------------------------------
/*
Funcionalidad: se ejecuta después de agregar o actualizar un gasto detallado. Actualiza automáticamente el total de la
expensa asociada (monto + monto_extra + suma de gastos)
Objetivo: mantener el total de expensas actualizado para reportes o cálculos de deuda
Tablas involucradas: gastos_detallados y expensas
*/

DELIMITER $$
CREATE TRIGGER trg_actualizar_total_expensas
AFTER INSERT ON gastos_detallados
FOR EACH ROW
BEGIN
    UPDATE expensas e
    SET e.monto_extra = COALESCE(e.monto_extra,0) + NEW.monto,
        e.deuda = e.monto + COALESCE(e.monto_extra,0)
    WHERE e.id_expensa = NEW.id_expensa;
END $$
DELIMITER ;

-- Ejemplo
INSERT INTO gastos_detallados (id_expensa, descripcion, monto)
VALUES (1, 'Reparacion ascensor', 500.00);