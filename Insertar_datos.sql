-- INMOBILIARIA DINDIO ----------------------------------------------------------------------------------------------------------
-- Registro de los datos base por tabla
  /* Descripcion breve del contenido para mayor organizacion luego

Edificio Pilar 
	Cuenta con 10 pisos con 2 deptos por piso = 20 deptos
	Algunos dueños con más de un depto en el mismo edificio
	Total de propietarios: 15 propietarios distintos en total (5 de ellos con 2 deptos cada uno)
	Ciudad: Paraná

Edificio Deco 
	Tiene 12 pisos con 3 deptos cada piso = 36 deptos
	Todos dueños distintos
	Ciudad: Rosario
	Total propietarios: 36

Edificio Tempo 
	Posee 16 pisos con 4 deptos cada uno = 64 deptos
	32 propietarios repetidos de Pilar y de Deco
	32 nuevos propietarios
	Ciudad: Buenos Aires
	Total de propietarios nuevos: 32
    
## Total = 83 registros unicos de propietarios
*/
USE Inmobiliaria;

-- Datos para la tabla propietarios
INSERT INTO propietarios(nombre, apellido, email, telefono, dni, ciudad)
VALUES
-- 15 propietarios de Pilar (Paraná)
('Juan', 'Pérez', 'juan.perez@example.com', '343-555-1001', '30123456', 'Parana'),
('María', 'Gómez', 'maria.gomez@example.com', '343-555-1002', '30123457', 'Parana'),
('Carlos', 'Fernández', 'carlos.fernandez@example.com', '343-555-1003', '30123458', 'Parana'),
('Laura', 'Martínez', 'laura.martinez@example.com', '343-555-1004', '30123459', 'Parana'),
('Luis', 'Rodríguez', 'luis.rodriguez@example.com', '343-555-1005', '30123460', 'Parana'),
('Ana', 'López', 'ana.lopez@example.com', '343-555-1006', '30123461', 'Parana'),
('Diego', 'Silva', 'diego.silva@example.com', '343-555-1007', '30123462', 'Parana'),
('Sofía', 'Ruiz', 'sofia.ruiz@example.com', '343-555-1008', '30123463', 'Parana'),
('Pablo', 'Torres', 'pablo.torres@example.com', '343-555-1009', '30123464', 'Parana'),
('Valeria', 'Sánchez', 'valeria.sanchez@example.com', '343-555-1010', '30123465', 'Parana'),
('Hernán', 'Domínguez', 'hernan.dominguez@example.com', '343-555-1011', '30123466', 'Parana'),
('Gabriela', 'Castro', 'gabriela.castro@example.com', '343-555-1012', '30123467', 'Parana'),
('Andrés', 'Molina', 'andres.molina@example.com', '343-555-1013', '30123468', 'Parana'),
('Natalia', 'Ortega', 'natalia.ortega@example.com', '343-555-1014', '30123469', 'Parana'),
('Ricardo', 'Herrera', 'ricardo.herrera@example.com', '343-555-1015', '30123470', 'Parana'),
-- 36 propietarios de Deco (Rosario)
('Martín', 'Cabrera', 'martin.cabrera@example.com', '341-555-2001', '31123456', 'Rosario'),
('Florencia', 'Ramos', 'florencia.ramos@example.com', '341-555-2002', '31123457', 'Rosario'),
('Federico', 'Romero', 'federico.romero@example.com', '341-555-2003', '31123458', 'Rosario'),
('Lucía', 'Acosta', 'lucia.acosta@example.com', '341-555-2004', '31123459', 'Rosario'),
('Emiliano', 'Méndez', 'emiliano.mendez@example.com', '341-555-2005', '31123460', 'Rosario'),
('Paula', 'Aguilar', 'paula.aguilar@example.com', '341-555-2006', '31123461', 'Rosario'),
('Julián', 'Blanco', 'julian.blanco@example.com', '341-555-2007', '31123462', 'Rosario'),
('Camila', 'García', 'camila.garcia@example.com', '341-555-2008', '31123463', 'Rosario'),
('Esteban', 'Moreno', 'esteban.moreno@example.com', '341-555-2009', '31123464', 'Rosario'),
('Micaela', 'Ponce', 'micaela.ponce@example.com', '341-555-2010', '31123465', 'Rosario'),
('Gonzalo', 'Vega', 'gonzalo.vega@example.com', '341-555-2011', '31123466', 'Rosario'),
('Julieta', 'Ibarra', 'julieta.ibarra@example.com', '341-555-2012', '31123467', 'Rosario'),
('Agustín', 'Figueroa', 'agustin.figueroa@example.com', '341-555-2013', '31123468', 'Rosario'),
('Cecilia', 'Navarro', 'cecilia.navarro@example.com', '341-555-2014', '31123469', 'Rosario'),
('Mariano', 'Peralta', 'mariano.peralta@example.com', '341-555-2015', '31123470', 'Rosario'),
('Romina', 'Villalba', 'romina.villalba@example.com', '341-555-2016', '31123471', 'Rosario'),
('Matías', 'Soria', 'matias.soria@example.com', '341-555-2017', '31123472', 'Rosario'),
('Antonella', 'Campos', 'antonella.campos@example.com', '341-555-2018', '31123473', 'Rosario'),
('Ezequiel', 'Arias', 'ezequiel.arias@example.com', '341-555-2019', '31123474', 'Rosario'),
('Pilar', 'Godoy', 'pilar.godoy@example.com', '341-555-2020', '31123475', 'Rosario'),
('Leonardo', 'Benítez', 'leonardo.benitez@example.com', '341-555-2021', '31123476', 'Rosario'),
('Milagros', 'Luna', 'milagros.luna@example.com', '341-555-2022', '31123477', 'Rosario'),
('Franco', 'Cáceres', 'franco.caceres@example.com', '341-555-2023', '31123478', 'Rosario'),
('Daiana', 'Correa', 'daiana.correa@example.com', '341-555-2024', '31123479', 'Rosario'),
('Iván', 'Cruz', 'ivan.cruz@example.com', '341-555-2025', '31123480', 'Rosario'),
('Noelia', 'Paz', 'noelia.paz@example.com', '341-555-2026', '31123481', 'Rosario'),
('Santiago', 'Salas', 'santiago.salas@example.com', '341-555-2027', '31123482', 'Rosario'),
('Lourdes', 'Delgado', 'lourdes.delgado@example.com', '341-555-2028', '31123483', 'Rosario'),
('Patricio', 'Maldonado', 'patricio.maldonado@example.com', '341-555-2029', '31123484', 'Rosario'),
('Vanesa', 'Ojeda', 'vanesa.ojeda@example.com', '341-555-2030', '31123485', 'Rosario'),
('Tomás', 'Guzmán', 'tomas.guzman@example.com', '341-555-2031', '31123486', 'Rosario'),
('Carolina', 'Ferreyra', 'carolina.ferreyra@example.com', '341-555-2032', '31123487', 'Rosario'),
('Rodrigo', 'Varela', 'rodrigo.varela@example.com', '341-555-2033', '31123488', 'Rosario'),
('Bárbara', 'Palacios', 'barbara.palacios@example.com', '341-555-2034', '31123489', 'Rosario'),
('Marcos', 'Paredes', 'marcos.paredes@example.com', '341-555-2035', '31123490', 'Rosario'),
-- 32 propietarios nuevos de Tempo (Buenos Aires)
('Luciano', 'Montes', 'luciano.montes@example.com', '11-555-3001', '32123456', 'Buenos Aires'),
('Carla', 'Pereyra', 'carla.pereyra@example.com', '11-555-3002', '32123457', 'Buenos Aires'),
('Bruno', 'Leiva', 'bruno.leiva@example.com', '11-555-3003', '32123458', 'Buenos Aires'),
('Melina', 'Vargas', 'melina.vargas@example.com', '11-555-3004', '32123459', 'Buenos Aires'),
('Nahuel', 'Morales', 'nahuel.morales@example.com', '11-555-3005', '32123460', 'Buenos Aires'),
('Ailén', 'Roldán', 'ailen.roldan@example.com', '11-555-3006', '32123461', 'Buenos Aires'),
('Rodrigo', 'Espinoza', 'rodrigo.espinoza@example.com', '11-555-3007', '32123462', 'Buenos Aires'),
('Gisela', 'Moya', 'gisela.moya@example.com', '11-555-3008', '32123463', 'Buenos Aires'),
('Kevin', 'Alonso', 'kevin.alonso@example.com', '11-555-3009', '32123464', 'Buenos Aires'),
('Priscila', 'Ortiz', 'priscila.ortiz@example.com', '11-555-3010', '32123465', 'Buenos Aires'),
('Matheo', 'Paredes', 'matheo.paredes@example.com', '11-555-3011', '32123466', 'Buenos Aires'),
('Magalí', 'Soto', 'magali.soto@example.com', '11-555-3012', '32123467', 'Buenos Aires'),
('Gustavo', 'Villalobos', 'gustavo.villalobos@example.com', '11-555-3013', '32123468', 'Buenos Aires'),
('Selena', 'Bustamante', 'selena.bustamante@example.com', '11-555-3014', '32123469', 'Buenos Aires'),
('Alejandro', 'Saavedra', 'alejandro.saavedra@example.com', '11-555-3015', '32123470', 'Buenos Aires'),
('Rocío', 'Del Valle', 'rocio.delvalle@example.com', '11-555-3016', '32123471', 'Buenos Aires'),
('Maximiliano', 'Funes', 'maximiliano.funes@example.com', '11-555-3017', '32123472', 'Buenos Aires'),
('Celeste', 'Bravo', 'celeste.bravo@example.com', '11-555-3018', '32123473', 'Buenos Aires'),
('Joaquín', 'Olivera', 'joaquin.olivera@example.com', '11-555-3019', '32123474', 'Buenos Aires'),
('Candela', 'Moreno', 'candela.moreno@example.com', '11-555-3020', '32123475', 'Buenos Aires'),
('Elías', 'Pizarro', 'elias.pizarro@example.com', '11-555-3021', '32123476', 'Buenos Aires'),
('Marina', 'Rosales', 'marina.rosales@example.com', '11-555-3022', '32123477', 'Buenos Aires'),
('Francesco', 'Quiroga', 'francesco.quiroga@example.com', '11-555-3023', '32123478', 'Buenos Aires'),
('Tamara', 'Godoy', 'tamara.godoy@example.com', '11-555-3024', '32123479', 'Buenos Aires'),
('Cristian', 'Maidana', 'cristian.maidana@example.com', '11-555-3025', '32123480', 'Buenos Aires'),
('Malena', 'Vega', 'malena.vega@example.com', '11-555-3026', '32123481', 'Buenos Aires'),
('Lucas', 'Ocampo', 'lucas.ocampo@example.com', '11-555-3027', '32123482', 'Buenos Aires'),
('Ariana', 'Cabrera', 'ariana.cabrera@example.com', '11-555-3028', '32123483', 'Buenos Aires'),
('Nicolás', 'Medina', 'nicolas.medina@example.com', '11-555-3029', '32123484', 'Buenos Aires'),
('Daiana', 'Páez', 'daiana.paez@example.com', '11-555-3030', '32123485', 'Buenos Aires'),
('Emanuel', 'Coronel', 'emanuel.coronel@example.com', '11-555-3031', '32123486', 'Buenos Aires'),
('Carina', 'Ávila', 'carina.avila@example.com', '11-555-3032', '32123487', 'Buenos Aires');
    
-- Datos para la tabla edificios
INSERT INTO edificios(nombre, direccion, ciudad, fecha_construccion)
VALUES
('Pilar', 'Av. Mitre 123', 'Paraná', '2005-05-10'),
('Deco', 'Bv. Oroño 456', 'Rosario', '2010-09-15'),
('Tempo', 'Av. Libertador 789', 'Buenos Aires', '2018-03-22');


-- Datos para la tabla departamentos
-- Son 120 deptos en total
INSERT INTO departamentos(id_propietario, id_edificio, piso, numero, dimension_m)
VALUES
/* Edificio Pilar (id 1 al 20)
Pisos 1 a 5: dimensiones 70 y 70 m2
Pisos 6 a 10: dimensiones 60 m2
*/
-- Pisos 1 a 5 
(1, 1, 1, '1A', 70),
(1, 1, 1, '1B', 62),
(2, 1, 2, '2A', 70),
(2, 1, 2, '2B', 62),
(3, 1, 3, '3A', 70),
(3, 1, 3, '3B', 62),
(4, 1, 4, '4A', 70),
(4, 1, 4, '4B', 62),
(5, 1, 5, '5A', 70),
(5, 1, 5, '5B', 62),
-- Pisos 6 a 10 
(6, 1, 6, '6A', 60),
(6, 1, 6, '6B', 60),
(7, 1, 7, '7A', 60),
(7, 1, 7, '7B', 60),
(8, 1, 8, '8A', 60),
(8, 1, 8, '8B', 60),
(9, 1, 9, '9A', 60),
(9, 1, 9, '9B', 60),
(10, 1, 10, '10A', 60),
(10, 1, 10, '10B', 60);
/* Edificio Deco (id 21 al 56)
Pisos 1 a 5: dimensiones 75, 70, 70 m2
Pisos 6 a 9: dimensiones 65, 65, 60 m2
Pisos 10 a 12: dimensiones 55, 55, 55 m2
*/
INSERT INTO departamentos(id_propietario, id_edificio, piso, numero, dimension_m)
VALUES
-- Pisos 1 a 5  
(16, 2, 1, '1A', 75),
(17, 2, 1, '1B', 70),
(18, 2, 1, '1C', 70),
(19, 2, 2, '2A', 75),
(20, 2, 2, '2B', 70),
(21, 2, 2, '2C', 70),
(22, 2, 3, '3A', 75),
(23, 2, 3, '3B', 70),
(24, 2, 3, '3C', 70),
(25, 2, 4, '4A', 75),
(26, 2, 4, '4B', 70),
(27, 2, 4, '4C', 70),
(28, 2, 5, '5A', 75),
(29, 2, 5, '5B', 70),
(30, 2, 5, '5C', 70),
-- Pisos 6 a 9  
(31, 2, 6, '6A', 65),
(32, 2, 6, '6B', 65),
(33, 2, 6, '6C', 60),
(34, 2, 7, '7A', 65),
(35, 2, 7, '7B', 65),
(36, 2, 7, '7C', 60),
(37, 2, 8, '8A', 65),
(38, 2, 8, '8B', 65),
(39, 2, 8, '8C', 60),
(40, 2, 9, '9A', 65),
(41, 2, 9, '9B', 65),
(42, 2, 9, '9C', 60),
-- Pisos 10 a 12  
(43, 2, 10, '10A', 55),
(44, 2, 10, '10B', 55),
(45, 2, 10, '10C', 55),
(46, 2, 11, '11A', 55),
(47, 2, 11, '11B', 55),
(48, 2, 11, '11C', 55),
(49, 2, 12, '12A', 55),
(50, 2, 12, '12B', 55),
(51, 2, 12, '12C', 55);
/* Edificio Tempo (id 57 al 120)
Pisos 1 a 5: dimensiones 80, 78, 75, 75 m2
Pisos 6 a 10: dimensiones 70, 70, 65, 65 m2
Pisos 11 a 16: dimensiones 60, 60, 55, 55 m2
*/
INSERT INTO departamentos(id_propietario, id_edificio, piso, numero, dimension_m)
VALUES
-- Pisos 1 a 5  
(1, 3, 1, '1A', 80),
(2, 3, 1, '1B', 78),
(3, 3, 1, '1C', 75),
(4, 3, 1, '1D', 75),
(5, 3, 2, '2A', 80),
(6, 3, 2, '2B', 78),
(7, 3, 2, '2C', 75),
(8, 3, 2, '2D', 75),
(9, 3, 3, '3A', 80),
(10, 3, 3, '3B', 78),
(11, 3, 3, '3C', 75),
(12, 3, 3, '3D', 75),
(13, 3, 4, '4A', 80),
(14, 3, 4, '4B', 78),
(15, 3, 4, '4C', 75),
(16, 3, 4, '4D', 75),
(17, 3, 5, '5A', 80),
(18, 3, 5, '5B', 78),
(19, 3, 5, '5C', 75),
(20, 3, 5, '5D', 75),
-- Pisos 6 a 10  
(21, 3, 6, '6A', 70),
(22, 3, 6, '6B', 70),
(23, 3, 6, '6C', 65),
(24, 3, 6, '6D', 65),
(25, 3, 7, '7A', 70),
(26, 3, 7, '7B', 70),
(27, 3, 7, '7C', 65),
(28, 3, 7, '7D', 65),
(29, 3, 8, '8A', 70),
(30, 3, 8, '8B', 70),
(31, 3, 8, '8C', 65),
(32, 3, 8, '8D', 65),
(33, 3, 9, '9A', 70),
(34, 3, 9, '9B', 70),
(35, 3, 9, '9C', 65),
(36, 3, 9, '9D', 65),
(37, 3, 10, '10A', 70),
(38, 3, 10, '10B', 70),
(39, 3, 10, '10C', 65),
(40, 3, 10, '10D', 65),
-- Pisos 11 a 16  
(41, 3, 11, '11A', 60),
(42, 3, 11, '11B', 60),
(43, 3, 11, '11C', 55),
(44, 3, 11, '11D', 55),
(45, 3, 12, '12A', 60),
(46, 3, 12, '12B', 60),
(47, 3, 12, '12C', 55),
(48, 3, 12, '12D', 55),
(49, 3, 13, '13A', 60),
(50, 3, 13, '13B', 60),
(51, 3, 13, '13C', 55),
(52, 3, 13, '13D', 55),
(53, 3, 14, '14A', 60),
(54, 3, 14, '14B', 60),
(55, 3, 14, '14C', 55),
(56, 3, 14, '14D', 55),
(57, 3, 15, '15A', 60),
(58, 3, 15, '15B', 60),
(59, 3, 15, '15C', 55),
(60, 3, 15, '15D', 55),
(61, 3, 16, '16A', 60),
(62, 3, 16, '16B', 60),
(63, 3, 16, '16C', 55),
(64, 3, 16, '16D', 55);

