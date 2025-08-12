-- INMOBILIARIA DINDIO ----------------------------------------------------------------------------------------------------------

-- Creacion de la base de datos para usar 
CREATE DATABASE Inmobiliaria;
USE Inmobiliaria;

-- Tabla propietarios
CREATE TABLE IF NOT EXISTS propietarios(
	id_propietario INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR (50) NOT NULL,
    apellido VARCHAR (50) NOT NULL,
    email VARCHAR (150) UNIQUE NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    dni INT UNIQUE NOT NULL,
    ciudad VARCHAR(30) NOT NULL);    
    
-- Tabla edificios
CREATE TABLE IF NOT EXISTS edificios(
	id_edificio INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR (100) NOT NULL,
    direccion VARCHAR (150) NOT NULL,
    ciudad VARCHAR (100) NOT NULL,
    fecha_construccion DATE);

-- Tabla departamentos
CREATE TABLE IF NOT EXISTS departamentos(
	id_depto INT PRIMARY KEY AUTO_INCREMENT,
    id_propietario INT NOT NULL,
	id_edificio INT NOT NULL,
    piso INT NOT NULL,
    numero VARCHAR(10) NOT NULL,
    dimension_m DECIMAL(5,2) NOT NULL,
    FOREIGN KEY (id_propietario) REFERENCES propietarios(id_propietario),
    FOREIGN KEY (id_edificio) REFERENCES edificios(id_edificio));

-- Tabla expensas
CREATE TABLE IF NOT EXISTS expensas(
	id_expensa INT PRIMARY KEY AUTO_INCREMENT,
    id_depto INT NOT NULL,
    mes INT NOT NULL,
    anio INT NOT NULL,
    monto DECIMAL(10, 2) NOT NULL,
    monto_extra DECIMAL(10, 2) DEFAULT 0.00,
    deuda DECIMAL(10, 2) DEFAULT 0.00,
	fecha_pago DATE,
    pagado BOOLEAN DEFAULT FALSE,
	FOREIGN KEY (id_depto) REFERENCES departamentos(id_depto));

-- Tabla Inquilinos temporales
CREATE TABLE IF NOT EXISTS inquilinos_temporales(
	id_inquilino INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR (50) NOT NULL,
    apellido VARCHAR (50) NOT NULL,
    email VARCHAR (150) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    documento VARCHAR(10) UNIQUE NOT NULL,
    fecha_nacimiento DATE NOT NULL);    

-- Tabla alquiler temporal
CREATE TABLE IF NOT EXISTS alquileres_temporales (
    id_alquiler INT PRIMARY KEY AUTO_INCREMENT,
    id_depto INT NOT NULL,
    id_inquilino INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    monto_diario DECIMAL(10, 2) NOT NULL,
    gastos_mantenimiento DECIMAL(10, 2) DEFAULT 0.00,
    FOREIGN KEY (id_depto) REFERENCES departamentos(id_depto),
    FOREIGN KEY (id_inquilino) REFERENCES inquilinos_temporales(id_inquilino));

-- Tabla gastos detallados
CREATE TABLE IF NOT EXISTS gastos_detallados(
    id_gasto INT PRIMARY KEY AUTO_INCREMENT,
    id_expensa INT NOT NULL,
    descripcion VARCHAR(250) NOT NULL,
    monto DECIMAL(10, 2) NOT NULL,
    fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_expensa) REFERENCES expensas(id_expensa));













