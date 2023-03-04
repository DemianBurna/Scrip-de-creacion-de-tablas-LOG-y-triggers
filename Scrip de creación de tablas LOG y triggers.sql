CREATE TABLE `base_de_ciberseguridad`.`movimiento_presupuestos_log` (
  `Fecha` DATE NOT NULL,
  `Hora` TIME NOT NULL,
  `Usuario` VARCHAR(45) NOT NULL,
  `Id_presupuesto` VARCHAR(45) NOT NULL,
  `Accion` VARCHAR(45) NOT NULL);
  
  CREATE TABLE `base_de_ciberseguridad`.`gestion_empleados_log` (
  `fecha` DATE NOT NULL,
  `hora` TIME NOT NULL,
  `usuario` VARCHAR(45) NOT NULL,
  `nombre_emp` VARCHAR(45) NOT NULL,
  `apellido_emp` VARCHAR(45) NOT NULL,
  `cuit_emp` BIGINT NOT NULL,
  `Condicion` VARCHAR(45) NOT NULL);
  
CREATE TRIGGER `ingreso_emp`
BEFORE INSERT ON `empleados`
FOR EACH ROW
INSERT INTO `gestion_empleados_log` (fecha, hora, usuario, nombre_emp, apellido_emp, cuil, condicion)
VALUES (CURDATE(), CURTIME(), USER(), NEW.nombre_emp, NEW.apellido_emp, NEW.cuit_emp, "Ingreso");

CREATE TRIGGER `despido_emp`
After Delete ON `empleados`
FOR EACH ROW
INSERT INTO `gestion_empleados` (fecha, hora, usuario, nombre_emp, apellido_emp, cuil, condicion)
VALUES (CURDATE(), CURTIME(), USER(), OLD.nombre_emp, OLD.apellido_emp, OLD.cuit_emp, "Despedido");

CREATE TRIGGER `creacion_presupuesto`
BEFORE INSERT ON `presupuesto`
FOR EACH ROW
INSERT INTO `movimiento_presupuestos_log` (fecha, hora, usuario, id_presupuesto, Accion)
VALUES (CURDATE(), CURTIME(), USER(), NEW.id_presupuesto, "Creado");

CREATE TRIGGER `eliminacion_presupuesto`
After DELETE ON `presupuesto`
FOR EACH ROW
INSERT INTO `movimiento_presupuestos_log` (fecha, hora, usuario, id_presupuesto, Accion)
VALUES (CURDATE(), CURTIME(), USER(), OLD.id_presupuesto, "Cancelado");