-- INMOBILIARIA DINDIO ----------------------------------------------------------------------------------------------------------

-- Creacion y permisos para los usuarios de la tabla "usuarios"
USE Inmobiliaria;

-- Crear usuarios ------------------------------------------------------------------------------------------------------------------
CREATE USER 'admin1'@'localhost' IDENTIFIED BY 'Admin123!';
CREATE USER 'operador1'@'localhost' IDENTIFIED BY 'Operador123!';
CREATE USER 'contador1'@'localhost' IDENTIFIED BY 'Contador123!';

-- Para dar permisos según rol ----------------------------------------------------------------------------------------------------
-- Administrador: tiene acceso completo a la BD
GRANT ALL PRIVILEGES ON inmobiliaria.* TO 'admin1'@'localhost';
-- Operador: puede consultar y modificar, pero no borrar ni alterar estructura
GRANT SELECT, INSERT, UPDATE ON inmobiliaria.* TO 'operador1'@'localhost';
-- Contador: solo necesita lectura (para informes y consultas)
GRANT SELECT ON inmobiliaria.* TO 'contador1'@'localhost';

-- --------------------------------------------------------------------------------------------------------------------------------
-- SIEMPRE! Aplico los cambios realizados después de asignar los permisos o removerlos
FLUSH PRIVILEGES;
-- --------------------------------------------------------------------------------------------------------------------------------

-- En caso de revocar permisos:
-- Especifico: remuevo los que quiero y dejo el que no puse antes ej operador:
REVOKE INSERT, UPDATE ON inmobiliaria.* FROM 'usuario'@'localhost';
-- Quitar todos los permisos sobre una base:
REVOKE ALL PRIVILEGES ON inmobiliaria.* FROM 'usuario'@'localhost';
-- Borrar el usuario completamente: en caso de desvinculación:
DROP USER 'usuario'@'localhost';

-- Ejemplos prácticos ------------------------------------------------------------------------------------------------------------
-- Administrador: puede hasta crear tablas nuevas:
/*
CREATE TABLE auditoria (
   id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
   descripcion TEXT,
   fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
*/

-- Operador: cargar las expensas
INSERT INTO expensas (id_depto, mes, anio, monto) 
VALUES (10, 3, 2025, 15000.00);

-- Contador: solo visualizar
SELECT * FROM vista_contratos_activos;


