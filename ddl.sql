-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema prueba_stf
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `prueba_stf` ;

-- -----------------------------------------------------
-- Schema prueba_stf
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `prueba_stf` DEFAULT CHARACTER SET utf8 ;
USE `prueba_stf` ;

-- -----------------------------------------------------
-- Table `prueba_stf`.`ubicacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `prueba_stf`.`ubicacion` (
  `idubicacion` INT NOT NULL,
  `latitud` DOUBLE NOT NULL,
  `longitud` DOUBLE NOT NULL,
  PRIMARY KEY (`idubicacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `prueba_stf`.`puerto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `prueba_stf`.`puerto` (
  `idpuerto` INT NOT NULL,
  `capacidad` INT NULL,
  `ubicaciones_idubicacion` INT NOT NULL,
  PRIMARY KEY (`idpuerto`),
  INDEX `fk_puertos_ubicaciones1_idx` (`ubicaciones_idubicacion` ASC),
  CONSTRAINT `fk_puertos_ubicaciones1`
    FOREIGN KEY (`ubicaciones_idubicacion`)
    REFERENCES `prueba_stf`.`ubicacion` (`idubicacion`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `prueba_stf`.`embarcacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `prueba_stf`.`embarcacion` (
  `idembarcacion` INT NOT NULL,
  `disponibilidad` TINYINT(1) NOT NULL,
  `calado` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `boton_panico` CHAR(1) NOT NULL,
  `ubicaciones_idubicacion` INT NOT NULL,
  PRIMARY KEY (`idembarcacion`),
  INDEX `fk_embarcaciones_ubicaciones1_idx` (`ubicaciones_idubicacion` ASC),
  CONSTRAINT `fk_embarcaciones_ubicaciones1`
    FOREIGN KEY (`ubicaciones_idubicacion`)
    REFERENCES `prueba_stf`.`ubicacion` (`idubicacion`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `prueba_stf`.`cab`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `prueba_stf`.`cab` (
  `idcab` INT NOT NULL,
  `embarcaciones_idembarcacion` INT NOT NULL,
  PRIMARY KEY (`idcab`),
  INDEX `fk_CABs_embarcaciones1_idx` (`embarcaciones_idembarcacion` ASC),
  CONSTRAINT `fk_CABs_embarcaciones1`
    FOREIGN KEY (`embarcaciones_idembarcacion`)
    REFERENCES `prueba_stf`.`embarcacion` (`idembarcacion`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `prueba_stf`.`cargo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `prueba_stf`.`cargo` (
  `idcargo` INT NOT NULL,
  `peso_carga` INT NOT NULL,
  `embarcaciones_idembarcacion` INT NOT NULL,
  PRIMARY KEY (`idcargo`),
  INDEX `fk_cargos_embarcaciones1_idx` (`embarcaciones_idembarcacion` ASC),
  CONSTRAINT `fk_cargos_embarcaciones1`
    FOREIGN KEY (`embarcaciones_idembarcacion`)
    REFERENCES `prueba_stf`.`embarcacion` (`idembarcacion`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `prueba_stf`.`passenger`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `prueba_stf`.`passenger` (
  `idpassengers` INT NOT NULL,
  `cantidad_pasageros` INT NOT NULL,
  `embarcaciones_idembarcacion` INT NOT NULL,
  PRIMARY KEY (`idpassengers`),
  INDEX `fk_passengers_embarcaciones1_idx` (`embarcaciones_idembarcacion` ASC),
  CONSTRAINT `fk_passengers_embarcaciones1`
    FOREIGN KEY (`embarcaciones_idembarcacion`)
    REFERENCES `prueba_stf`.`embarcacion` (`idembarcacion`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `prueba_stf`.`transporte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `prueba_stf`.`transporte` (
  `idtransporte` INT NOT NULL,
  `tipo` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `cabs_idcab` INT NULL,
  `cargos_idcargo` INT NULL,
  `passengers_idpassengers` INT NULL,
  PRIMARY KEY (`idtransporte`),
  INDEX `fk_transportes_CABs1_idx` (`cabs_idcab` ASC),
  INDEX `fk_transportes_cargos1_idx` (`cargos_idcargo` ASC),
  INDEX `fk_transportes_passengers1_idx` (`passengers_idpassengers` ASC),
  CONSTRAINT `fk_transportes_CABs1`
    FOREIGN KEY (`cabs_idcab`)
    REFERENCES `prueba_stf`.`cab` (`idcab`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_transportes_cargos1`
    FOREIGN KEY (`cargos_idcargo`)
    REFERENCES `prueba_stf`.`cargo` (`idcargo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_transportes_passengers1`
    FOREIGN KEY (`passengers_idpassengers`)
    REFERENCES `prueba_stf`.`passenger` (`idpassengers`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `prueba_stf`.`hora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `prueba_stf`.`hora` (
  `idhora` INT NOT NULL,
  `hora_salida` TIME NULL,
  `hora_llegada` TIME NULL,
  PRIMARY KEY (`idhora`));


-- -----------------------------------------------------
-- Table `prueba_stf`.`ruta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `prueba_stf`.`ruta` (
  `idruta` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `trayecto` VARCHAR(500) NOT NULL,
  `tiempo_invertido` VARCHAR(45) NOT NULL,
  `puertos_idpuerto` INT NOT NULL,
  `transportes_idtransporte` INT NOT NULL,
  `horas_idhora` INT NOT NULL,
  PRIMARY KEY (`idruta`),
  INDEX `fk_rutas_puertos_idx` (`puertos_idpuerto` ASC),
  INDEX `fk_rutas_transportes1_idx` (`transportes_idtransporte` ASC),
  INDEX `fk_rutas_horas1_idx` (`horas_idhora` ASC),
  CONSTRAINT `fk_rutas_puertos`
    FOREIGN KEY (`puertos_idpuerto`)
    REFERENCES `prueba_stf`.`puerto` (`idpuerto`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_rutas_transportes1`
    FOREIGN KEY (`transportes_idtransporte`)
    REFERENCES `prueba_stf`.`transporte` (`idtransporte`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_rutas_horas1`
    FOREIGN KEY (`horas_idhora`)
    REFERENCES `prueba_stf`.`hora` (`idhora`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `prueba_stf`.`sensor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `prueba_stf`.`sensor` (
  `idsensor` INT NOT NULL,
  `nivel_agua` INT NOT NULL,
  `fecha` DATE NOT NULL,
  `ubicaciones_idubicacion` INT NOT NULL,
  PRIMARY KEY (`idsensor`),
  INDEX `fk_sensores_ubicaciones1_idx` (`ubicaciones_idubicacion` ASC),
  CONSTRAINT `fk_sensores_ubicaciones1`
    FOREIGN KEY (`ubicaciones_idubicacion`)
    REFERENCES `prueba_stf`.`ubicacion` (`idubicacion`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `prueba_stf`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `prueba_stf`.`persona` (
  `idpersona` INT NOT NULL,
  `nombres` VARCHAR(100) NOT NULL,
  `apellidos` VARCHAR(100) NOT NULL,
  `telefono` VARCHAR(16) NULL,
  `identificacion` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`idpersona`),
  UNIQUE INDEX `identificacion_UNIQUE` (`identificacion` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `prueba_stf`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `prueba_stf`.`usuario` (
  `idusuario` INT NOT NULL,
  `usuario` VARCHAR(16) NOT NULL,
  `password` VARCHAR(16) NOT NULL,
  `email` VARCHAR(100) NULL,
  `tipo_u` INT NOT NULL,
  `personas_idpersona` INT NOT NULL,
  PRIMARY KEY (`idusuario`),
  UNIQUE INDEX `usuario_UNIQUE` (`usuario` ASC),
  INDEX `fk_usuarios_personas1_idx` (`personas_idpersona` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  CONSTRAINT `fk_usuarios_personas1`
    FOREIGN KEY (`personas_idpersona`)
    REFERENCES `prueba_stf`.`persona` (`idpersona`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `prueba_stf`.`servicio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `prueba_stf`.`servicio` (
  `idservicio` INT NOT NULL,
  `descripcion` VARCHAR(100) NULL,
  `usuarios_idusuario` INT NOT NULL,
  `transportes_idtransporte` INT NOT NULL,
  `puertollegada` INT NOT NULL,
  `pesocarga` INT NULL,
  PRIMARY KEY (`idservicio`),
  INDEX `fk_servicios_usuarios1_idx` (`usuarios_idusuario` ASC),
  INDEX `fk_servicios_transportes1_idx` (`transportes_idtransporte` ASC),
  CONSTRAINT `fk_servicios_usuarios1`
    FOREIGN KEY (`usuarios_idusuario`)
    REFERENCES `prueba_stf`.`usuario` (`idusuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_servicios_transportes1`
    FOREIGN KEY (`transportes_idtransporte`)
    REFERENCES `prueba_stf`.`transporte` (`idtransporte`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

USE `prueba_stf` ;

-- -----------------------------------------------------
-- procedure insertar_persona
-- -----------------------------------------------------

DELIMITER $$
USE `prueba_stf`$$
CREATE PROCEDURE insertar_persona(idpersona INT, nombres VARCHAR(100), apellidos VARCHAR(100), telefono VARCHAR(16), identificacion VARCHAR(30))
COMMENT 'Insertar Persona'
BEGIN
IF NOT EXISTS ( SELECT p.idpersona
FROM persona AS p
WHERE p.idpersona = idpersona OR p.identificacion = identificacion) THEN
INSERT INTO persona
VALUES (idpersona, nombres, apellidos, telefono, identificacion);
ELSE
SELECT 'Esta persona ya esta registrada en la base de datos!';
END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure borrar_persona
-- -----------------------------------------------------

DELIMITER $$
USE `prueba_stf`$$
CREATE PROCEDURE borrar_persona(idpersona INT)
COMMENT 'Borra Persona'
BEGIN
DELETE FROM persona WHERE persona.idpersona = idpersona;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure actualizar_persona
-- -----------------------------------------------------

DELIMITER $$
USE `prueba_stf`$$
CREATE PROCEDURE actualizar_persona(id INT, nom VARCHAR(100), ape VARCHAR(100), tel VARCHAR(16), ident VARCHAR(30))
COMMENT 'Actualiza Persona'
BEGIN
UPDATE persona 
SET nombres=nom,  apellidos=ape, telefono=tel, identificacion=ident
WHERE persona.idpersona=id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure actualizar_usuario
-- -----------------------------------------------------

DELIMITER $$
USE `prueba_stf`$$
CREATE PROCEDURE actualizar_usuario(id INT, u varchar(16), pw varchar(16), e varchar(100), tipo int)
COMMENT 'Actualiza Usuario'
BEGIN
UPDATE usuario 
SET usuario=u,  usuario.password=pw, email=e, tipo_u=tipo
WHERE usuario.idusuario=id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertar_usuario
-- -----------------------------------------------------

DELIMITER $$
USE `prueba_stf`$$
CREATE PROCEDURE insertar_usuario(id int, us varchar(16), pw varchar(16), e varchar(100), tipo int, persona int)
COMMENT 'Insertar Persona'
BEGIN
IF NOT EXISTS ( SELECT u.idusuario
FROM usuario AS u
WHERE u.idusuario = id) THEN
INSERT INTO usuario
VALUES (id, us, pw, e, tipo, persona);
ELSE
SELECT 'Este usuario ya esta registrado en la base de datos!';
END IF;
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `prueba_stf`.`ubicacion`
-- -----------------------------------------------------
START TRANSACTION;
USE `prueba_stf`;
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (20, 5.207630218, -74.73411083);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (40, 5.548800144, -74.63239074);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (60, 5.917092985, -74.59073067);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (80, 6.27673706, -74.5214653);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (100, 6.598789627, -74.38825607);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (120, 6.934947198, -73.99377823);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (140, 7.134619688, -73.91687393);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (160, 7.578626176, -73.86091232);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (180, 7.973727733, -73.85807991);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (200, 8.308492146, -73.75782967);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (220, 8.737515, -73.805662);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (240, 9.009394, -73.986422);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (260, 9.141965, -74.22871);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (280, 9.260328, -74.533495);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (300, 9.522424, -74.784517);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (320, 9.913894, -74.868106);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (340, 5.207630218, -74.73411083);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (360, 5.207630218, -74.73411083);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (380, 5.207630218, -74.73411083);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (400, 5.207630218, -74.73411083);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (420, 5.207630218, -74.73411083);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (440, 5.207630218, -74.73411083);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (460, 5.207630218, -74.73411083);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (480, 5.207630218, -74.73411083);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (500, 5.548800144, -74.63239074);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (520, 5.548800144, -74.63239074);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (540, 5.548800144, -74.63239074);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (560, 5.548800144, -74.63239074);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (580, 5.548800144, -74.63239074);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (600, 5.548800144, -74.63239074);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (620, 5.548800144, -74.63239074);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (640, 5.548800144, -74.63239074);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (660, 5.917092985, -74.59073067);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (680, 5.917092985, -74.59073067);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (700, 5.917092985, -74.59073067);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (720, 5.917092985, -74.59073067);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (740, 5.917092985, -74.59073067);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (760, 5.917092985, -74.59073067);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (780, 5.917092985, -74.59073067);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (800, 5.917092985, -74.59073067);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (820, 6.27673706, -74.5214653);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (840, 6.27673706, -74.5214653);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (860, 6.27673706, -74.5214653);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (880, 6.27673706, -74.5214653);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (900, 6.27673706, -74.5214653);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (920, 6.27673706, -74.5214653);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (940, 6.27673706, -74.5214653);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (960, 6.27673706, -74.5214653);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (980, 6.598789627, -74.38825607);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1000, 6.598789627, -74.38825607);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1020, 6.598789627, -74.38825607);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1040, 6.598789627, -74.38825607);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1060, 6.598789627, -74.38825607);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1080, 6.598789627, -74.38825607);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1100, 6.598789627, -74.38825607);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1120, 6.598789627, -74.38825607);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1140, 6.934947198, -73.99377823);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1160, 6.934947198, -73.99377823);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1180, 6.934947198, -73.99377823);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1200, 6.934947198, -73.99377823);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1220, 6.934947198, -73.99377823);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1240, 6.934947198, -73.99377823);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1260, 6.934947198, -73.99377823);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1280, 6.934947198, -73.99377823);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1300, 7.134619688, -73.91687393);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1320, 7.134619688, -73.91687393);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1340, 7.134619688, -73.91687393);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1360, 7.134619688, -73.91687393);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1380, 7.134619688, -73.91687393);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1400, 7.134619688, -73.91687393);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1420, 7.134619688, -73.91687393);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1440, 7.134619688, -73.91687393);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1460, 7.578626176, -73.86091232);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1480, 7.578626176, -73.86091232);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1500, 7.578626176, -73.86091232);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1520, 7.578626176, -73.86091232);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1540, 7.578626176, -73.86091232);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1560, 7.578626176, -73.86091232);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1580, 7.578626176, -73.86091232);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1600, 7.578626176, -73.86091232);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1620, 7.973727733, -73.85807991);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1640, 7.973727733, -73.85807991);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1660, 7.973727733, -73.85807991);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1680, 7.973727733, -73.85807991);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1700, 7.973727733, -73.85807991);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1720, 7.973727733, -73.85807991);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1740, 7.973727733, -73.85807991);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1760, 7.973727733, -73.85807991);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1780, 8.308492146, -73.75782967);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1800, 8.308492146, -73.75782967);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1820, 8.308492146, -73.75782967);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1840, 8.308492146, -73.75782967);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1860, 8.308492146, -73.75782967);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1880, 8.308492146, -73.75782967);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1900, 8.308492146, -73.75782967);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1920, 8.308492146, -73.75782967);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1940, 8.737515, -73.805662);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1960, 8.737515, -73.805662);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (1980, 8.737515, -73.805662);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2000, 8.737515, -73.805662);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2020, 8.737515, -73.805662);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2040, 8.737515, -73.805662);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2060, 8.737515, -73.805662);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2080, 8.737515, -73.805662);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2100, 9.141965, -74.22871);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2120, 9.141965, -74.22871);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2140, 9.141965, -74.22871);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2160, 9.141965, -74.22871);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2180, 9.141965, -74.22871);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2200, 9.141965, -74.22871);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2220, 9.141965, -74.22871);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2240, 9.141965, -74.22871);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2260, 9.260328, -74.533495);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2280, 9.260328, -74.533495);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2300, 9.260328, -74.533495);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2320, 9.260328, -74.533495);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2340, 9.260328, -74.533495);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2360, 9.260328, -74.533495);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2380, 9.260328, -74.533495);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2400, 9.260328, -74.533495);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2420, 9.522424, -74.784517);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2440, 9.522424, -74.784517);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2460, 9.522424, -74.784517);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2480, 9.522424, -74.784517);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2500, 9.522424, -74.784517);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2520, 9.522424, -74.784517);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2540, 9.522424, -74.784517);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2560, 9.522424, -74.784517);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2580, 9.522424, -74.784517);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2600, 9.913894, -74.868106);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2620, 9.913894, -74.868106);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2640, 9.913894, -74.868106);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2660, 9.913894, -74.868106);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2680, 9.913894, -74.868106);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2700, 9.913894, -74.868106);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2720, 9.913894, -74.868106);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2740, 9.913894, -74.868106);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2760, 9.913894, -74.868106);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2780, 5.207630218, -74.73411083);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2800, 5.207630218, -74.73411083);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2820, 5.207630218, -74.73411083);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2840, 5.207630218, -74.73411083);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2860, 5.207630218, -74.73411083);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2880, 5.207630218, -74.73411083);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2900, 5.207630218, -74.73411083);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2920, 5.207630218, -74.73411083);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2940, 5.207630218, -74.73411083);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2960, 5.548800144, -74.63239074);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (2980, 5.548800144, -74.63239074);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3000, 5.548800144, -74.63239074);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3020, 5.548800144, -74.63239074);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3040, 5.548800144, -74.63239074);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3060, 5.548800144, -74.63239074);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3080, 5.548800144, -74.63239074);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3100, 5.548800144, -74.63239074);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3120, 5.917092985, -74.59073067);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3140, 5.917092985, -74.59073067);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3160, 5.917092985, -74.59073067);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3180, 5.917092985, -74.59073067);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3200, 5.917092985, -74.59073067);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3220, 5.917092985, -74.59073067);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3240, 5.917092985, -74.59073067);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3260, 5.917092985, -74.59073067);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3280, 5.917092985, -74.59073067);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3300, 6.27673706, -74.5214653);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3320, 6.27673706, -74.5214653);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3340, 6.27673706, -74.5214653);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3360, 6.27673706, -74.5214653);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3380, 6.27673706, -74.5214653);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3400, 6.27673706, -74.5214653);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3420, 6.27673706, -74.5214653);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3440, 6.27673706, -74.5214653);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3460, 6.27673706, -74.5214653);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3480, 6.598789627, -74.38825607);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3500, 6.598789627, -74.38825607);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3520, 6.598789627, -74.38825607);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3540, 6.598789627, -74.38825607);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3560, 6.598789627, -74.38825607);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3580, 6.598789627, -74.38825607);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3600, 6.598789627, -74.38825607);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3620, 6.598789627, -74.38825607);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3640, 6.934947198, -73.99377823);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3660, 6.934947198, -73.99377823);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3680, 6.934947198, -73.99377823);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3700, 6.934947198, -73.99377823);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3720, 6.934947198, -73.99377823);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3740, 6.934947198, -73.99377823);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3760, 6.934947198, -73.99377823);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3780, 6.934947198, -73.99377823);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3800, 7.134619688, -73.91687393);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3820, 7.134619688, -73.91687393);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3840, 7.134619688, -73.91687393);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3860, 7.134619688, -73.91687393);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3880, 7.134619688, -73.91687393);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3900, 7.134619688, -73.91687393);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3920, 7.134619688, -73.91687393);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3940, 7.134619688, -73.91687393);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3960, 7.134619688, -73.91687393);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (3980, 7.578626176, -73.86091232);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4000, 7.578626176, -73.86091232);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4020, 7.578626176, -73.86091232);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4040, 7.578626176, -73.86091232);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4060, 7.578626176, -73.86091232);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4080, 7.578626176, -73.86091232);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4100, 7.578626176, -73.86091232);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4120, 7.578626176, -73.86091232);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4140, 7.578626176, -73.86091232);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4160, 7.973727733, -73.85807991);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4180, 7.973727733, -73.85807991);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4200, 7.973727733, -73.85807991);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4220, 7.973727733, -73.85807991);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4240, 7.973727733, -73.85807991);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4260, 7.973727733, -73.85807991);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4280, 7.973727733, -73.85807991);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4300, 7.973727733, -73.85807991);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4320, 8.308492146, -73.75782967);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4340, 8.308492146, -73.75782967);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4360, 8.308492146, -73.75782967);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4380, 8.308492146, -73.75782967);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4400, 8.308492146, -73.75782967);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4420, 8.308492146, -73.75782967);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4440, 8.308492146, -73.75782967);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4460, 8.308492146, -73.75782967);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4480, 8.308492146, -73.75782967);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4500, 8.737515, -73.805662);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4520, 8.737515, -73.805662);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4540, 8.737515, -73.805662);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4560, 8.737515, -73.805662);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4580, 8.737515, -73.805662);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4600, 8.737515, -73.805662);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4620, 8.737515, -73.805662);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4640, 8.737515, -73.805662);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4660, 9.141965, -74.22871);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4680, 9.141965, -74.22871);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4700, 9.141965, -74.22871);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4720, 9.141965, -74.22871);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4740, 9.141965, -74.22871);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4760, 9.141965, -74.22871);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4780, 9.141965, -74.22871);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4800, 9.141965, -74.22871);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4820, 9.260328, -74.533495);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4840, 9.260328, -74.533495);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4860, 9.260328, -74.533495);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4880, 9.260328, -74.533495);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4900, 9.260328, -74.533495);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4920, 9.260328, -74.533495);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4940, 9.260328, -74.533495);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4960, 9.260328, -74.533495);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (4980, 9.260328, -74.533495);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5000, 9.522424, -74.784517);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5020, 9.522424, -74.784517);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5040, 9.522424, -74.784517);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5060, 9.522424, -74.784517);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5080, 9.522424, -74.784517);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5100, 9.522424, -74.784517);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5120, 9.522424, -74.784517);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5140, 9.522424, -74.784517);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5160, 9.522424, -74.784517);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5180, 9.913894, -74.868106);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5200, 9.913894, -74.868106);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5220, 9.913894, -74.868106);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5240, 9.913894, -74.868106);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5260, 9.913894, -74.868106);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5280, 9.913894, -74.868106);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5300, 9.913894, -74.868106);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5320, 9.913894, -74.868106);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5340, 5.207630218, -74.73411083);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5360, 5.207630218, -74.73411083);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5380, 5.548800144, -74.63239074);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5400, 5.917092985, -74.59073067);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5420, 6.27673706, -74.5214653);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5440, 6.598789627, -74.38825607);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5460, 6.934947198, -73.99377823);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5480, 7.134619688, -73.91687393);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5500, 7.578626176, -73.86091232);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5520, 7.973727733, -73.85807991);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5540, 8.308492146, -73.75782967);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5560, 8.737515, -73.805662);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5580, 8.737515, -73.805662);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5600, 9.141965, -74.22871);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5620, 9.260328, -74.533495);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5640, 9.522424, -74.784517);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5660, 9.913894, -74.868106);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5680, 9.913894, -74.868106);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5700, 5.207630218, -74.73411083);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5720, 5.548800144, -74.63239074);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5740, 5.917092985, -74.59073067);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5760, 6.27673706, -74.5214653);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5780, 6.27673706, -74.5214653);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5800, 6.598789627, -74.38825607);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5820, 6.934947198, -73.99377823);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5840, 6.934947198, -73.99377823);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5860, 7.134619688, -73.91687393);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5880, 7.578626176, -73.86091232);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5900, 7.973727733, -73.85807991);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5920, 8.308492146, -73.75782967);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5940, 8.737515, -73.805662);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5960, 8.737515, -73.805662);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (5980, 9.141965, -74.22871);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6000, 9.141965, -74.22871);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6020, 9.260328, -74.533495);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6040, 9.260328, -74.533495);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6060, 9.522424, -74.784517);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6080, 9.522424, -74.784517);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6100, 9.913894, -74.868106);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6120, 9.913894, -74.868106);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6140, 5.207630218, -74.73411083);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6160, 5.207630218, -74.73411083);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6180, 5.548800144, -74.63239074);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6200, 5.548800144, -74.63239074);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6220, 5.917092985, -74.59073067);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6240, 5.917092985, -74.59073067);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6260, 6.27673706, -74.5214653);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6280, 6.27673706, -74.5214653);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6300, 6.598789627, -74.38825607);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6320, 6.598789627, -74.38825607);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6340, 6.934947198, -73.99377823);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6360, 7.134619688, -73.91687393);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6380, 7.578626176, -73.86091232);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6400, 7.973727733, -73.85807991);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6420, 8.308492146, -73.75782967);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6440, 8.308492146, -73.75782967);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6460, 8.737515, -73.805662);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6480, 9.141965, -74.22871);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6500, 9.260328, -74.533495);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6520, 9.522424, -74.784517);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6540, 9.913894, -74.868106);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6560, 9.913894, -74.868106);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6580, 5.207630218, -74.73411083);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6600, 5.548800144, -74.63239074);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6620, 5.917092985, -74.59073067);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6640, 5.917092985, -74.59073067);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6660, 6.27673706, -74.5214653);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6680, 6.27673706, -74.5214653);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6700, 6.598789627, -74.38825607);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6720, 6.598789627, -74.38825607);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6740, 6.934947198, -73.99377823);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6760, 7.134619688, -73.91687393);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6780, 7.578626176, -73.86091232);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6800, 7.973727733, -73.85807991);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6820, 7.973727733, -73.85807991);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6840, 7.578626176, -73.86091232);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6860, 5.548800144, -74.63239074);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6880, 9.260328, -74.533495);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6900, 9.141965, -74.22871);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6920, 7.578626176, -73.86091232);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6940, 8.308492146, -73.75782967);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6960, 8.308492146, -73.75782967);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (6980, 8.737515, -73.805662);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7000, 8.737515, -73.805662);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7020, 9.141965, -74.22871);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7040, 9.260328, -74.533495);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7060, 9.522424, -74.784517);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7080, 9.522424, -74.784517);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7100, 9.913894, -74.868106);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7120, 9.913894, -74.868106);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7140, 5.207630218, -74.73411083);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7160, 5.214681982, -74.72912192);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7180, 5.222567042, -74.73163247);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7200, 5.23162726, -74.7304523);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7220, 5.238315497, -74.72427249);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7240, 5.246648983, -74.72545266);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7260, 5.255858425, -74.72742677);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7280, 5.263657497, -74.72483039);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7300, 5.27228978, -74.72828507);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7320, 5.280387779, -74.73163247);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7340, 5.288528404, -74.73401427);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7360, 5.297694492, -74.73208308);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7380, 5.313526505, -74.71632242);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7400, 5.321175295, -74.71327543);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7420, 5.330917749, -74.71058249);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7440, 5.345232039, -74.70784664);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7460, 5.350957661, -74.70261097);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7480, 5.362195108, -74.69967127);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7500, 5.365570574, -74.68881369);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7520, 5.36997147, -74.68151808);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7540, 5.377491375, -74.67787027);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7560, 5.384840283, -74.68138933);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7580, 5.393769941, -74.68499422);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7600, 5.402827642, -74.68168974);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7620, 5.403425787, -74.67302084);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7640, 5.406929198, -74.66671228);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7660, 5.415559464, -74.66615438);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7680, 5.423591483, -74.6698451);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7700, 5.429529981, -74.67396498);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7720, 5.439527032, -74.67499495);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7740, 5.442560293, -74.66555357);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7760, 5.440808694, -74.65727091);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7780, 5.442090352, -74.65001822);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7800, 5.44589259, -74.65267897);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7820, 5.453197945, -74.66027498);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7840, 5.461870269, -74.66224909);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7860, 5.470457028, -74.66345072);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7880, 5.479299979, -74.66490984);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7900, 5.487929206, -74.66658354);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7920, 5.497412667, -74.66808558);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7940, 5.50591348, -74.67053175);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7960, 5.515567522, -74.67014551);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (7980, 5.523512766, -74.66774225);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8000, 5.525050542, -74.65722799);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8020, 5.525007826, -74.6499753);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8040, 5.529791996, -74.6440959);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8060, 5.537267183, -74.6429801);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8080, 5.547006143, -74.64044809);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8100, 5.548800144, -74.63239074);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8120, 5.557385646, -74.64117765);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8140, 5.562425833, -74.64855909);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8160, 5.567935818, -74.65383768);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8180, 5.574983398, -74.65409517);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8200, 5.583653941, -74.64911699);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8220, 5.592537911, -74.64486837);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8240, 5.600695669, -74.6463275);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8260, 5.610903384, -74.64263678);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8280, 5.618035865, -74.63898897);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8300, 5.626620352, -74.63546991);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8320, 5.634350553, -74.63280916);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8340, 5.64404519, -74.63104963);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8360, 5.648401317, -74.62409735);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8380, 5.655191686, -74.62656498);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8400, 5.662793388, -74.63190794);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8420, 5.671804265, -74.63911772);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8440, 5.680644183, -74.64139223);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8460, 5.687694, -74.632852);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8480, 5.697213, -74.62811);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8500, 5.706864, -74.63017);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8520, 5.713953, -74.636865);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8540, 5.716857, -74.645276);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8560, 5.722579, -74.652228);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8580, 5.733083, -74.654889);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8600, 5.743673, -74.656348);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8620, 5.752554, -74.660468);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8640, 5.762802, -74.65858);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8660, 5.771598, -74.657035);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8680, 5.782101, -74.656692);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8700, 5.789531, -74.653258);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8720, 5.799778, -74.650769);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8740, 5.811647, -74.650855);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8760, 5.823004, -74.653087);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8780, 5.833848, -74.652228);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8800, 5.845716, -74.648623);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8820, 5.850242, -74.64107);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8840, 5.858782, -74.633775);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8860, 5.870392, -74.632058);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8880, 5.881918, -74.630427);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8900, 5.887468, -74.622874);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8920, 5.889773, -74.612317);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8940, 5.893871, -74.602103);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8960, 5.898054, -74.591889);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (8980, 5.909068, -74.591117);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9000, 5.917092985, -74.59073067);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9020, 5.920593, -74.590859);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9040, 5.930242, -74.59558);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9060, 5.939375, -74.602275);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9080, 5.949278, -74.60176);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9100, 5.959266, -74.604335);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9120, 5.968144, -74.607596);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9140, 5.977363, -74.60279);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9160, 5.982656, -74.592404);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9180, 5.982485, -74.58262);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9200, 5.982997, -74.573007);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9220, 5.990253, -74.566398);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9240, 6.005021, -74.562535);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9260, 6.014325, -74.566054);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9280, 6.022519, -74.565797);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9300, 6.031994, -74.565282);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9320, 6.043263, -74.567342);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9340, 6.053929, -74.570346);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9360, 6.065025, -74.566483);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9380, 6.071768, -74.562535);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9400, 6.080644, -74.564681);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9420, 6.082778, -74.576354);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9440, 6.082863, -74.586053);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9460, 6.087216, -74.597812);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9480, 6.091824, -74.607081);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9500, 6.095153, -74.612575);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9520, 6.100735, -74.616094);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9540, 6.105992, -74.613605);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9560, 6.116574, -74.614978);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9580, 6.125364, -74.614034);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9600, 6.134412, -74.609828);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9620, 6.143456, -74.607596);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9640, 6.151734, -74.602876);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9660, 6.157707, -74.597297);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9680, 6.164534, -74.592233);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9700, 6.170422, -74.587255);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9720, 6.178735, -74.58365);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9740, 6.186294, -74.580045);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9760, 6.192267, -74.579701);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9780, 6.198496, -74.580388);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9800, 6.207235, -74.582105);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9820, 6.213599, -74.576268);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9840, 6.220425, -74.569402);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9860, 6.225545, -74.565368);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9880, 6.230323, -74.562192);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9900, 6.233821, -74.556613);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9920, 6.242098, -74.549918);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9940, 6.248074, -74.545884);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9960, 6.255664, -74.541593);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (9980, 6.264195, -74.538674);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10000, 6.269144, -74.532752);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10020, 6.274775, -74.52477);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10040, 6.273324, -74.515371);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10060, 6.272642, -74.50696);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10080, 6.27673706, -74.5214653);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10100, 6.277761, -74.502325);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10120, 6.282539, -74.495802);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10140, 6.287657, -74.488077);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10160, 6.291075, -74.478807);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10180, 6.300454, -74.473658);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10200, 6.311033, -74.468851);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10220, 6.317005, -74.460783);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10240, 6.325024, -74.452372);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10260, 6.332701, -74.448938);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10280, 6.343109, -74.44087);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10300, 6.353345, -74.436579);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10320, 6.370406, -74.433489);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10340, 6.384395, -74.427481);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10360, 6.390195, -74.407053);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10380, 6.392925, -74.39435);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10400, 6.397531, -74.37993);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10420, 6.403331, -74.372721);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10440, 6.416637, -74.369631);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10460, 6.429601, -74.373922);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10480, 6.439495, -74.384222);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10500, 6.447682, -74.393148);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10520, 6.458087, -74.400702);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10540, 6.467812, -74.404306);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10560, 6.481796, -74.401903);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10580, 6.495154, -74.394865);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10600, 6.511474, -74.391603);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10620, 6.526312, -74.400358);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10640, 6.539444, -74.406023);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10660, 6.556157, -74.405851);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10680, 6.573551, -74.396067);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10700, 6.587023, -74.389715);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10720, 6.598789627, -74.38825607);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10740, 6.601347, -74.38405);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10760, 6.611926, -74.372034);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10780, 6.626755, -74.362764);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10800, 6.634428, -74.347315);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10820, 6.630847, -74.334784);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10840, 6.637497, -74.322767);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10860, 6.644317, -74.317446);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10880, 6.655571, -74.309721);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10900, 6.656594, -74.298048);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10920, 6.661709, -74.285345);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10940, 6.671257, -74.275045);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10960, 6.673644, -74.259081);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (10980, 6.684556, -74.250669);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11000, 6.697172, -74.24346);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11020, 6.709106, -74.231958);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11040, 6.717631, -74.225607);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11060, 6.727348, -74.214106);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11080, 6.723257, -74.200201);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11100, 6.720874, -74.186296);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11120, 6.726837, -74.176512);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11140, 6.736724, -74.165354);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11160, 6.747805, -74.157629);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11180, 6.760079, -74.146986);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11200, 6.776785, -74.135828);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11220, 6.789911, -74.12982);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11240, 6.790081, -74.117117);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11260, 6.785478, -74.109907);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11280, 6.790081, -74.098406);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11300, 6.803376, -74.092569);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11320, 6.817694, -74.082613);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11340, 6.833545, -74.081755);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11360, 6.846328, -74.073343);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11380, 6.854853, -74.065275);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11400, 6.865417, -74.055147);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11420, 6.875813, -74.046564);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11440, 6.883141, -74.031973);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11460, 6.890812, -74.017382);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11480, 6.898992, -74.009829);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11500, 6.911092, -74.003477);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11520, 6.924041, -73.996439);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11540, 6.931028, -73.988199);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11560, 6.934947198, -73.99377823);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11580, 6.939378, -73.975668);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11600, 6.944319, -73.962107);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11620, 6.947727, -73.947001);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11640, 6.949431, -73.937216);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11660, 6.954373, -73.928976);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11680, 6.960337, -73.920908);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11700, 6.967494, -73.913698);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11720, 6.976184, -73.902197);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11740, 6.990326, -73.892927);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11760, 7.000889, -73.887777);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11780, 7.015542, -73.885031);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11800, 7.029172, -73.886061);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11820, 7.037009, -73.879538);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11840, 7.046549, -73.876619);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11860, 7.059667, -73.877134);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11880, 7.064437, -73.883314);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11900, 7.073126, -73.888636);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11920, 7.080451, -73.894815);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11940, 7.091353, -73.897734);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11960, 7.102426, -73.89945);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (11980, 7.109751, -73.902369);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12000, 7.120482, -73.909407);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12020, 7.134619688, -73.91687393);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12040, 7.135471, -73.915415);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12060, 7.155911, -73.91593);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12080, 7.164938, -73.920393);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12100, 7.181288, -73.925886);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12120, 7.193721, -73.930349);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12140, 7.206494, -73.927946);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12160, 7.219097, -73.923826);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12180, 7.232039, -73.920565);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12200, 7.244641, -73.918333);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12220, 7.257242, -73.921251);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12240, 7.270354, -73.924341);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12260, 7.283636, -73.924856);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12280, 7.298109, -73.923998);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12300, 7.309517, -73.919535);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12320, 7.315476, -73.914557);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12340, 7.325181, -73.912153);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12360, 7.336418, -73.909407);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12380, 7.344761, -73.907003);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12400, 7.355146, -73.905973);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12420, 7.365361, -73.90666);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12440, 7.375235, -73.90254);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12460, 7.388003, -73.899622);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12480, 7.396345, -73.899107);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12500, 7.406388, -73.901682);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12520, 7.417964, -73.900824);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12540, 7.431241, -73.899622);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12560, 7.442986, -73.898592);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12580, 7.452858, -73.900824);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12600, 7.462391, -73.90666);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12620, 7.470049, -73.911982);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12640, 7.479921, -73.915071);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12660, 7.491154, -73.914042);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12680, 7.500004, -73.909063);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12700, 7.503408, -73.899279);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12720, 7.503919, -73.891554);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12740, 7.507663, -73.884344);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12760, 7.515492, -73.876448);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12780, 7.525022, -73.870955);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12800, 7.533701, -73.86426);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12820, 7.542721, -73.860998);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12840, 7.554633, -73.85499);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12860, 7.567566, -73.853102);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12880, 7.578626176, -73.86091232);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12900, 7.589012, -73.854367);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12920, 7.602709, -73.84544);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12940, 7.615894, -73.831649);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12960, 7.633234, -73.840155);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (12980, 7.650169, -73.845133);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13000, 7.650169, -73.845133);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13020, 7.666735, -73.835104);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13040, 7.683477, -73.828647);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13060, 7.698469, -73.835055);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13080, 7.712771, -73.834635);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13100, 7.731593, -73.830571);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13120, 7.744636, -73.819793);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13140, 7.752865, -73.810075);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13160, 7.767133, -73.802919);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13180, 7.780876, -73.804686);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13200, 7.796194, -73.806806);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13220, 7.811161, -73.812283);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13240, 7.831379, -73.81299);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13260, 7.84477, -73.818733);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13280, 7.863411, -73.8205);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13300, 7.881789, -73.818998);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13320, 7.896315, -73.830748);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13340, 7.911279, -73.837639);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13360, 7.931492, -73.835783);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13380, 7.950479, -73.838522);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13400, 7.966228, -73.854778);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13420, 7.973727733, -73.85807991);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13440, 7.987051, -73.863259);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13460, 7.999912, -73.870062);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13480, 8.019771, -73.872094);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13500, 8.038666, -73.868913);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13520, 8.057124, -73.862199);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13540, 8.073831, -73.864054);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13560, 8.087913, -73.849212);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13580, 8.099371, -73.835253);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13600, 8.111179, -73.817319);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13620, 8.121145, -73.810315);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13640, 8.12994, -73.806839);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13660, 8.134953, -73.796496);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13680, 8.13661, -73.786712);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13700, 8.142812, -73.777742);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13720, 8.15271, -73.770833);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13740, 8.162481, -73.769975);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13760, 8.175522, -73.772721);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13780, 8.188893, -73.775049);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13800, 8.199258, -73.77359);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13820, 8.209197, -73.779169);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13840, 8.224913, -73.774534);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13860, 8.236041, -73.766809);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13880, 8.252944, -73.763548);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13900, 8.264157, -73.755308);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13920, 8.279666, -73.75202);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13940, 8.288386, -73.756939);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13960, 8.299945, -73.759859);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (13980, 8.308492146, -73.75782967);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14000, 8.310389, -73.754223);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14020, 8.319108, -73.746948);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14040, 8.3258, -73.753813);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14060, 8.333759, -73.759039);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14080, 8.345418, -73.758066);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14100, 8.355404, -73.751815);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14120, 8.369596, -73.748844);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14140, 8.383305, -73.751556);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14160, 8.394941, -73.750134);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14180, 8.407471, -73.750134);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14200, 8.419233, -73.749445);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14220, 8.432573, -73.747937);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14240, 8.444633, -73.748281);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14260, 8.457886, -73.745783);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14280, 8.466366, -73.748454);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14300, 8.473683, -73.756153);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14320, 8.489745, -73.76503);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14340, 8.502665, -73.773186);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14360, 8.51844, -73.779898);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14380, 8.53243, -73.77831);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14400, 8.549488, -73.776867);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14420, 8.563263, -73.777228);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14440, 8.576466, -73.784806);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14460, 8.588384, -73.792745);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14480, 8.600231, -73.800324);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14500, 8.61222, -73.80386);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14520, 8.625278, -73.81115);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14540, 8.638308, -73.818567);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14560, 8.651268, -73.824394);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14580, 8.661558, -73.82057);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14600, 8.674038, -73.814562);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14620, 8.686757, -73.80825);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14640, 8.700316, -73.808796);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14660, 8.713274, -73.811406);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14680, 8.728391, -73.809828);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14700, 8.737515, -73.805662);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14720, 8.739489, -73.803212);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14740, 8.749627, -73.792157);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14760, 8.761045, -73.79181);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14780, 8.771581, -73.795776);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14800, 8.785399, -73.791958);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14820, 8.799903, -73.793247);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14840, 8.812888, -73.795776);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14860, 8.824745, -73.803362);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14880, 8.836944, -73.81199);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14900, 8.841207, -73.823344);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14920, 8.850613, -73.831674);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14940, 8.86144, -73.841144);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14960, 8.870601, -73.850118);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (14980, 8.879028, -73.859737);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15000, 8.890295, -73.866778);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15020, 8.897349, -73.869703);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15040, 8.909693, -73.871786);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15060, 8.921596, -73.870447);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15080, 8.93198, -73.867125);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15100, 8.942658, -73.865291);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15120, 8.952943, -73.863506);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15140, 8.963865, -73.862811);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15160, 8.972779, -73.876893);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15180, 8.973367, -73.888743);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15200, 8.97513, -73.902626);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15220, 8.977676, -73.913584);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15240, 8.981056, -73.926525);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15260, 8.985219, -73.937036);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15280, 8.992907, -73.9473);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15300, 8.99642, -73.957054);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15320, 8.995386, -73.967375);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15340, 8.991226, -73.969821);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15360, 8.987887, -73.974389);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15380, 8.985319, -73.979627);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15400, 8.988988, -73.984084);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15420, 8.994307, -73.98791);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15440, 8.994307, -73.98791);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15460, 8.995995, -73.999685);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15480, 9.001865, -74.004662);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15500, 9.007812, -74.00387);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15520, 9.011187, -73.995401);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15540, 9.008143, -73.988121);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15560, 9.009394, -73.986422);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15580, 9.012398, -73.987081);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15600, 9.01603, -73.993209);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15620, 9.021019, -73.998744);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15640, 9.026119, -74.001381);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15660, 9.030337, -74.003759);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15680, 9.032648, -74.008736);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15700, 9.031108, -74.012562);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15720, 9.02843, -74.015348);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15740, 9.024945, -74.020139);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15760, 9.026119, -74.02508);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15780, 9.027893, -74.029375);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15800, 9.033754, -74.03406);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15820, 9.038165, -74.03456);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15840, 9.043224, -74.033842);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15860, 9.043934, -74.038902);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15880, 9.041743, -74.042556);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15900, 9.037857, -74.044711);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15920, 9.033446, -74.045367);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15940, 9.029806, -74.045992);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15960, 9.024777, -74.04671);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (15980, 9.021631, -74.05049);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16000, 9.019225, -74.05683);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16020, 9.020366, -74.065108);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16040, 9.023389, -74.070917);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16060, 9.026381, -74.075821);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16080, 9.024808, -74.083786);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16100, 9.024962, -74.090658);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16120, 9.024962, -74.090658);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16140, 9.019903, -74.10134);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16160, 9.024345, -74.106338);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16180, 9.029929, -74.108618);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16200, 9.036685, -74.109992);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16220, 9.041157, -74.114834);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16240, 9.038844, -74.120206);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16260, 9.034309, -74.121549);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16280, 9.030176, -74.124579);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16300, 9.027708, -74.131451);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16320, 9.029374, -74.137635);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16340, 9.033507, -74.142445);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16360, 9.039152, -74.142133);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16380, 9.043162, -74.137604);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16400, 9.043934, -74.130045);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16420, 9.04307, -74.123611);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16440, 9.04563, -74.117645);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16460, 9.05001, -74.117426);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16480, 9.051583, -74.123205);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16500, 9.054514, -74.129296);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16520, 9.054514, -74.129296);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16540, 9.061855, -74.142352);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16560, 9.057167, -74.150067);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16580, 9.060899, -74.158625);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16600, 9.068332, -74.157782);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16620, 9.073854, -74.164529);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16640, 9.075673, -74.176304);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16660, 9.084217, -74.177304);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16680, 9.090941, -74.178584);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16700, 9.094426, -74.188517);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16720, 9.098744, -74.197388);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16740, 9.104665, -74.204072);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16760, 9.11071, -74.206758);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16780, 9.118605, -74.211162);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16800, 9.121258, -74.219908);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16820, 9.125113, -74.228904);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16840, 9.131034, -74.226342);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16860, 9.134889, -74.219502);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16880, 9.140131, -74.226467);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16900, 9.141965, -74.22871);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16920, 9.14488, -74.232558);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16940, 9.1504, -74.23818);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16960, 9.15885, -74.243397);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (16980, 9.165418, -74.248332);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17000, 9.167422, -74.255797);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17020, 9.168193, -74.263856);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17040, 9.167206, -74.271227);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17060, 9.162334, -74.276474);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17080, 9.157678, -74.284065);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17100, 9.158418, -74.293248);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17120, 9.162828, -74.299651);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17140, 9.169766, -74.299495);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17160, 9.178184, -74.297308);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17180, 9.185584, -74.294497);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17200, 9.194773, -74.291061);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17220, 9.201895, -74.295465);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17240, 9.20689, -74.301431);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17260, 9.209572, -74.309958);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17280, 9.215091, -74.318767);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17300, 9.220949, -74.330261);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17320, 9.227763, -74.338538);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17340, 9.233097, -74.346441);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17360, 9.232727, -74.356249);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17380, 9.229335, -74.364776);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17400, 9.224803, -74.372459);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17420, 9.223354, -74.380424);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17440, 9.217496, -74.387733);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17460, 9.214321, -74.396229);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17480, 9.215585, -74.404975);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17500, 9.221381, -74.409442);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17520, 9.230445, -74.413658);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17540, 9.237875, -74.419687);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17560, 9.244812, -74.424497);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17580, 9.252982, -74.428089);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17600, 9.260328, -74.533495);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17620, 9.260658, -74.431431);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17640, 9.268519, -74.431212);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17660, 9.274438, -74.435054);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17680, 9.272927, -74.442644);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17700, 9.268334, -74.448329);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17720, 9.271602, -74.460136);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17740, 9.268611, -74.468975);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17760, 9.263679, -74.47591);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17780, 9.256219, -74.481251);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17800, 9.250176, -74.488185);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17820, 9.244781, -74.497024);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17840, 9.238091, -74.504052);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17860, 9.234052, -74.513079);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17880, 9.239016, -74.521731);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17900, 9.244041, -74.526729);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17920, 9.252057, -74.531133);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17940, 9.25961, -74.533288);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17960, 9.267532, -74.537505);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (17980, 9.271848, -74.544376);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18000, 9.278353, -74.549936);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18020, 9.285905, -74.553872);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18040, 9.291299, -74.558026);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18060, 9.297834, -74.561868);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18080, 9.305664, -74.56243);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18100, 9.314277, -74.565897);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18120, 9.317336, -74.57073);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18140, 9.321275, -74.583442);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18160, 9.325267, -74.595367);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18180, 9.330917, -74.602406);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18200, 9.335634, -74.6085);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18220, 9.340973, -74.615013);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18240, 9.352169, -74.61391);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18260, 9.360099, -74.613595);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18280, 9.367977, -74.616012);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18300, 9.37513, -74.621737);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18320, 9.379121, -74.629144);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18340, 9.381142, -74.639178);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18360, 9.382334, -74.651155);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18380, 9.386169, -74.65998);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18400, 9.394565, -74.665916);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18420, 9.403168, -74.669067);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18440, 9.410579, -74.671064);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18460, 9.416124, -74.680782);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18480, 9.418974, -74.6905);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18500, 9.425659, -74.697382);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18520, 9.424001, -74.706469);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18540, 9.419752, -74.713929);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18560, 9.417523, -74.72391);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18580, 9.419389, -74.73326);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18600, 9.426437, -74.73741);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18620, 9.436334, -74.738303);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18640, 9.44675, -74.742295);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18660, 9.454108, -74.748441);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18680, 9.460533, -74.755218);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18700, 9.464316, -74.765199);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18720, 9.464368, -74.776335);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18740, 9.461259, -74.786736);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18760, 9.483706, -74.781006);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18780, 9.504534, -74.772601);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18800, 9.519144, -74.783002);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18820, 9.522424, -74.784517);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18840, 9.527847, -74.787415);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18860, 9.539244, -74.79666);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18880, 9.548258, -74.80412);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18900, 9.561209, -74.794664);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18920, 9.572915, -74.781952);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18940, 9.58514, -74.772181);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18960, 9.602129, -74.77071);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (18980, 9.618599, -74.774177);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (19000, 9.634137, -74.780166);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (19020, 9.64988, -74.788361);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (19040, 9.660445, -74.79666);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (19060, 9.679294, -74.805275);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (19080, 9.691396, -74.808885);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (19100, 9.707159, -74.80976);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (19120, 9.722184, -74.805762);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (19140, 9.7393, -74.815382);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (19160, 9.753724, -74.807266);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (19180, 9.771857, -74.800932);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (19200, 9.787006, -74.809678);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (19220, 9.797279, -74.821163);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (19240, 9.807203, -74.831764);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (19260, 9.816257, -74.840864);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (19280, 9.82679, -74.846165);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (19300, 9.844721, -74.850935);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (19320, 9.864915, -74.853056);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (19340, 9.883715, -74.857738);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (19360, 9.892244, -74.863039);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (19380, 9.910086, -74.86833);
INSERT INTO `prueba_stf`.`ubicacion` (`idubicacion`, `latitud`, `longitud`) VALUES (19400, 9.913894, -74.868106);

COMMIT;


-- -----------------------------------------------------
-- Data for table `prueba_stf`.`puerto`
-- -----------------------------------------------------
START TRANSACTION;
USE `prueba_stf`;
INSERT INTO `prueba_stf`.`puerto` (`idpuerto`, `capacidad`, `ubicaciones_idubicacion`) VALUES (1, 12, 20);
INSERT INTO `prueba_stf`.`puerto` (`idpuerto`, `capacidad`, `ubicaciones_idubicacion`) VALUES (2, 11, 40);
INSERT INTO `prueba_stf`.`puerto` (`idpuerto`, `capacidad`, `ubicaciones_idubicacion`) VALUES (3, 11, 60);
INSERT INTO `prueba_stf`.`puerto` (`idpuerto`, `capacidad`, `ubicaciones_idubicacion`) VALUES (4, 11, 80);
INSERT INTO `prueba_stf`.`puerto` (`idpuerto`, `capacidad`, `ubicaciones_idubicacion`) VALUES (5, 11, 100);
INSERT INTO `prueba_stf`.`puerto` (`idpuerto`, `capacidad`, `ubicaciones_idubicacion`) VALUES (6, 10, 120);
INSERT INTO `prueba_stf`.`puerto` (`idpuerto`, `capacidad`, `ubicaciones_idubicacion`) VALUES (7, 10, 140);
INSERT INTO `prueba_stf`.`puerto` (`idpuerto`, `capacidad`, `ubicaciones_idubicacion`) VALUES (8, 11, 160);
INSERT INTO `prueba_stf`.`puerto` (`idpuerto`, `capacidad`, `ubicaciones_idubicacion`) VALUES (9, 10, 180);
INSERT INTO `prueba_stf`.`puerto` (`idpuerto`, `capacidad`, `ubicaciones_idubicacion`) VALUES (10, 11, 200);
INSERT INTO `prueba_stf`.`puerto` (`idpuerto`, `capacidad`, `ubicaciones_idubicacion`) VALUES (11, 11, 220);
INSERT INTO `prueba_stf`.`puerto` (`idpuerto`, `capacidad`, `ubicaciones_idubicacion`) VALUES (12, 11, 240);
INSERT INTO `prueba_stf`.`puerto` (`idpuerto`, `capacidad`, `ubicaciones_idubicacion`) VALUES (13, 11, 260);
INSERT INTO `prueba_stf`.`puerto` (`idpuerto`, `capacidad`, `ubicaciones_idubicacion`) VALUES (14, 11, 280);
INSERT INTO `prueba_stf`.`puerto` (`idpuerto`, `capacidad`, `ubicaciones_idubicacion`) VALUES (15, 13, 300);
INSERT INTO `prueba_stf`.`puerto` (`idpuerto`, `capacidad`, `ubicaciones_idubicacion`) VALUES (16, 0, 320);

COMMIT;


-- -----------------------------------------------------
-- Data for table `prueba_stf`.`embarcacion`
-- -----------------------------------------------------
START TRANSACTION;
USE `prueba_stf`;
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (1, 1, 30, 'elit', '0', 340);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (2, 1, 30, 'ullamcorper,', '0', 360);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (3, 1, 30, 'et', '0', 380);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (4, 1, 30, 'fermentum', '0', 400);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (5, 1, 30, 'felis', '0', 420);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (6, 1, 30, 'egestas', '0', 440);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (7, 1, 30, 'Proin', '0', 460);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (8, 1, 30, 'Nulla', '0', 480);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (9, 1, 30, 'pretium', '0', 500);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (10, 1, 30, 'Integer', '0', 520);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (11, 1, 30, 'nibh.', '0', 540);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (12, 1, 30, 'per', '0', 560);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (13, 1, 30, 'dis', '0', 580);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (14, 1, 30, 'ultricies', '0', 600);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (15, 1, 30, 'molestie', '0', 620);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (16, 1, 30, 'a,', '0', 640);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (17, 1, 30, 'in', '0', 660);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (18, 1, 30, 'mauris,', '0', 680);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (19, 1, 30, 'dolor', '0', 700);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (20, 1, 30, 'facilisis', '0', 720);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (21, 1, 30, 'Curabitur', '0', 740);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (22, 1, 30, 'Aliquam', '0', 760);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (23, 1, 30, 'iaculis', '0', 780);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (24, 1, 30, 'scelerisque,', '0', 800);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (25, 1, 30, 'et,', '0', 820);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (26, 1, 30, 'Sed', '0', 840);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (27, 1, 30, 'gravida', '0', 860);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (28, 1, 30, 'vel,', '0', 880);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (29, 1, 30, 'semper.', '0', 900);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (30, 1, 30, 'erat', '0', 920);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (31, 1, 30, 'et', '0', 940);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (32, 1, 30, 'enim.', '0', 960);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (33, 1, 30, 'sem.', '0', 980);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (34, 1, 30, 'Nunc', '0', 1000);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (35, 1, 30, 'consectetuer', '0', 1020);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (36, 1, 30, 'eleifend', '0', 1040);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (37, 1, 30, 'libero', '0', 1060);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (38, 1, 30, 'justo.', '0', 1080);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (39, 1, 30, 'mauris.', '0', 1100);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (40, 1, 30, 'dolor', '0', 1120);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (41, 1, 30, 'pede', '0', 1140);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (42, 1, 30, 'Morbi', '0', 1160);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (43, 1, 30, 'interdum.', '0', 1180);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (44, 1, 30, 'magna.', '0', 1200);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (45, 1, 30, 'est,', '0', 1220);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (46, 1, 30, 'ante', '0', 1240);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (47, 1, 30, 'porttitor', '0', 1260);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (48, 1, 30, 'erat.', '0', 1280);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (49, 1, 30, 'orci,', '0', 1300);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (50, 1, 30, 'enim,', '0', 1320);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (51, 1, 30, 'turpis', '0', 1340);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (52, 1, 30, 'ipsum', '0', 1360);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (53, 1, 30, 'dictum', '0', 1380);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (54, 1, 30, 'Aenean', '0', 1400);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (55, 1, 30, 'imperdiet,', '0', 1420);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (56, 1, 30, 'molestie', '0', 1440);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (57, 1, 30, 'Sed', '0', 1460);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (58, 1, 30, 'arcu.', '0', 1480);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (59, 1, 30, 'eu,', '0', 1500);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (60, 1, 30, 'imperdiet', '0', 1520);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (61, 1, 30, 'dictum.', '0', 1540);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (62, 1, 30, 'sed', '0', 1560);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (63, 1, 30, 'Vivamus', '0', 1580);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (64, 1, 30, 'vitae,', '0', 1600);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (65, 1, 30, 'ut', '0', 1620);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (66, 1, 30, 'vitae', '0', 1640);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (67, 1, 30, 'lacus.', '0', 1660);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (68, 1, 30, 'nunc', '0', 1680);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (69, 1, 30, 'eu', '0', 1700);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (70, 1, 30, 'Donec', '0', 1720);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (71, 1, 30, 'dolor', '0', 1740);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (72, 1, 30, 'ut', '0', 1760);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (73, 1, 30, 'eleifend', '0', 1780);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (74, 1, 30, 'erat', '0', 1800);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (75, 1, 30, 'magna.', '0', 1820);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (76, 1, 30, 'dui.', '0', 1840);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (77, 1, 30, 'hendrerit', '0', 1860);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (78, 1, 30, 'in', '0', 1880);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (79, 1, 30, 'mus.', '0', 1900);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (80, 1, 30, 'ligula', '0', 1920);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (81, 1, 30, 'malesuada.', '0', 1940);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (82, 1, 30, 'Etiam', '0', 1960);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (83, 1, 30, 'posuere', '0', 1980);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (84, 1, 30, 'magna.', '0', 2000);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (85, 1, 30, 'tristique', '0', 2020);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (86, 1, 30, 'Curabitur', '0', 2040);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (87, 1, 30, 'elit,', '0', 2060);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (88, 1, 30, 'inceptos', '0', 2080);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (89, 1, 30, 'interdum', '0', 2100);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (90, 1, 30, 'fermentum', '0', 2120);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (91, 1, 30, 'ac', '0', 2140);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (92, 1, 30, 'dapibus', '0', 2160);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (93, 1, 30, 'dolor', '0', 2180);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (94, 1, 30, 'felis', '0', 2200);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (95, 1, 30, 'cursus', '0', 2220);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (96, 1, 30, 'Suspendisse', '0', 2240);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (97, 1, 30, 'tellus', '0', 2260);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (98, 1, 30, 'faucibus', '0', 2280);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (99, 1, 30, 'bibendum', '0', 2300);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (100, 1, 30, 'ante', '0', 2320);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (101, 1, 30, 'ornare', '0', 2340);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (102, 1, 30, 'egestas', '0', 2360);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (103, 1, 30, 'vulputate', '0', 2380);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (104, 1, 30, 'et,', '0', 2400);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (105, 1, 30, 'eu', '0', 2420);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (106, 1, 30, 'tellus.', '0', 2440);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (107, 1, 30, 'Cum', '0', 2460);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (108, 1, 30, 'euismod', '0', 2480);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (109, 1, 30, 'pede', '0', 2500);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (110, 1, 30, 'mi', '0', 2520);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (111, 1, 30, 'viverra.', '0', 2540);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (112, 1, 30, 'gravida', '0', 2560);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (113, 1, 30, 'vulputate', '0', 2580);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (114, 1, 30, 'bibendum', '0', 2600);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (115, 1, 30, 'augue', '0', 2620);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (116, 1, 30, 'cursus', '0', 2640);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (117, 1, 30, 'Suspendisse', '0', 2660);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (118, 1, 30, 'lorem', '0', 2680);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (119, 1, 30, 'vitae', '0', 2700);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (120, 1, 30, 'tristique', '0', 2720);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (121, 1, 30, 'at', '0', 2740);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (122, 1, 30, 'pulvinar', '0', 2760);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (123, 1, 30, 'sagittis', '0', 2780);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (124, 1, 30, 'venenatis', '0', 2800);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (125, 1, 30, 'in', '0', 2820);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (126, 1, 30, 'mauris,', '0', 2840);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (127, 1, 30, 'sit', '0', 2860);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (128, 1, 30, 'Fusce', '0', 2880);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (129, 1, 30, 'mi', '0', 2900);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (130, 1, 30, 'metus.', '0', 2920);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (131, 1, 30, 'tellus.', '0', 2940);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (132, 1, 30, 'Vivamus', '0', 2960);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (133, 1, 30, 'quam', '0', 2980);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (134, 1, 30, 'nibh', '0', 3000);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (135, 1, 30, 'eu', '0', 3020);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (136, 1, 30, 'Nulla', '0', 3040);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (137, 1, 30, 'pharetra', '0', 3060);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (138, 1, 30, 'imperdiet', '0', 3080);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (139, 1, 30, 'magna', '0', 3100);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (140, 1, 30, 'malesuada', '0', 3120);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (141, 1, 30, 'montes,', '0', 3140);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (142, 1, 30, 'fermentum', '0', 3160);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (143, 1, 30, 'ridiculus', '0', 3180);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (144, 1, 30, 'et', '0', 3200);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (145, 1, 30, 'orci', '0', 3220);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (146, 1, 30, 'consequat,', '0', 3240);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (147, 1, 30, 'Duis', '0', 3260);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (148, 1, 30, 'orci', '0', 3280);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (149, 1, 30, 'purus,', '0', 3300);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (150, 1, 30, 'nisl', '0', 3320);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (151, 1, 30, 'mus.', '0', 3340);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (152, 1, 30, 'Quisque', '0', 3360);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (153, 1, 30, 'sodales', '0', 3380);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (154, 1, 30, 'cursus.', '0', 3400);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (155, 1, 30, 'mus.', '0', 3420);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (156, 1, 30, 'ac', '0', 3440);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (157, 1, 30, 'ac', '0', 3460);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (158, 1, 30, 'nec,', '0', 3480);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (159, 1, 30, 'placerat.', '0', 3500);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (160, 1, 30, 'sed', '0', 3520);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (161, 1, 30, 'eget', '0', 3540);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (162, 1, 30, 'aliquam', '0', 3560);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (163, 1, 30, 'Cum', '0', 3580);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (164, 1, 30, 'Vivamus', '0', 3600);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (165, 1, 30, 'elementum', '0', 3620);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (166, 1, 30, 'magna.', '0', 3640);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (167, 1, 30, 'vitae', '0', 3660);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (168, 1, 30, 'dolor.', '0', 3680);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (169, 1, 30, 'eu', '0', 3700);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (170, 1, 30, 'scelerisque,', '0', 3720);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (171, 1, 30, 'convallis', '0', 3740);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (172, 1, 30, 'dui,', '0', 3760);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (173, 1, 30, 'purus,', '0', 3780);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (174, 1, 30, 'eget', '0', 3800);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (175, 1, 30, 'Duis', '0', 3820);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (176, 1, 30, 'velit', '0', 3840);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (177, 1, 30, 'varius.', '0', 3860);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (178, 1, 30, 'Nam', '0', 3880);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (179, 1, 30, 'et', '0', 3900);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (180, 1, 30, 'Donec', '0', 3920);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (181, 1, 30, 'blandit', '0', 3940);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (182, 1, 30, 'lacus.', '0', 3960);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (183, 1, 30, 'nunc', '0', 3980);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (184, 1, 30, 'fringilla', '0', 4000);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (185, 1, 30, 'nec', '0', 4020);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (186, 1, 30, 'viverra.', '0', 4040);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (187, 1, 30, 'Cum', '0', 4060);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (188, 1, 30, 'libero.', '0', 4080);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (189, 1, 30, 'purus.', '0', 4100);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (190, 1, 30, 'elementum,', '0', 4120);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (191, 1, 30, 'Ut', '0', 4140);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (192, 1, 30, 'Etiam', '0', 4160);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (193, 1, 30, 'enim', '0', 4180);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (194, 1, 30, 'convallis', '0', 4200);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (195, 1, 30, 'tempus', '0', 4220);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (196, 1, 30, 'nunc.', '0', 4240);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (197, 1, 30, 'conubia', '0', 4260);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (198, 1, 30, 'Mauris', '0', 4280);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (199, 1, 30, 'magna', '0', 4300);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (200, 1, 30, 'Quisque', '0', 4320);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (201, 1, 30, 'Proin', '0', 4340);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (202, 1, 30, 'dolor', '0', 4360);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (203, 1, 30, 'dapibus', '0', 4380);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (204, 1, 30, 'dolor.', '0', 4400);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (205, 1, 30, 'velit.', '0', 4420);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (206, 1, 30, 'enim', '0', 4440);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (207, 1, 30, 'pellentesque', '0', 4460);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (208, 1, 30, 'ornare,', '0', 4480);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (209, 1, 30, 'faucibus', '0', 4500);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (210, 1, 30, 'eu,', '0', 4520);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (211, 1, 30, 'elementum', '0', 4540);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (212, 1, 30, 'metus', '0', 4560);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (213, 1, 30, 'hendrerit', '0', 4580);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (214, 1, 30, 'fringilla', '0', 4600);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (215, 1, 30, 'mus.', '0', 4620);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (216, 1, 30, 'luctus', '0', 4640);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (217, 1, 30, 'ut,', '0', 4660);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (218, 1, 30, 'scelerisque', '0', 4680);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (219, 1, 30, 'tortor,', '0', 4700);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (220, 1, 30, 'leo.', '0', 4720);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (221, 1, 30, 'sed,', '0', 4740);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (222, 1, 30, 'egestas', '0', 4760);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (223, 1, 30, 'In', '0', 4780);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (224, 1, 30, 'taciti', '0', 4800);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (225, 1, 30, 'imperdiet,', '0', 4820);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (226, 1, 30, 'posuere', '0', 4840);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (227, 1, 30, 'eget,', '0', 4860);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (228, 1, 30, 'Etiam', '0', 4880);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (229, 1, 30, 'ante', '0', 4900);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (230, 1, 30, 'dolor', '0', 4920);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (231, 1, 30, 'pede,', '0', 4940);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (232, 1, 30, 'fermentum', '0', 4960);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (233, 1, 30, 'fringilla,', '0', 4980);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (234, 1, 30, 'blandit', '0', 5000);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (235, 1, 30, 'Nam', '0', 5020);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (236, 1, 30, 'in,', '0', 5040);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (237, 1, 30, 'dictum.', '0', 5060);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (238, 1, 30, 'commodo', '0', 5080);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (239, 1, 30, 'elit', '0', 5100);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (240, 1, 30, 'aliquam', '0', 5120);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (241, 1, 30, 'dui.', '0', 5140);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (242, 1, 30, 'ut', '0', 5160);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (243, 1, 30, 'at,', '0', 5180);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (244, 1, 30, 'in', '0', 5200);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (245, 1, 30, 'amet', '0', 5220);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (246, 1, 30, 'erat.', '0', 5240);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (247, 1, 30, 'sociis', '0', 5260);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (248, 1, 30, 'Phasellus', '0', 5280);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (249, 1, 30, 'metus.', '0', 5300);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (250, 1, 30, 'sodales', '0', 5320);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (251, 1, 150, 'adipiscing', '0', 5340);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (252, 1, 150, 'pede.', '0', 5360);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (253, 1, 150, 'semper', '0', 5380);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (254, 1, 150, 'vitae', '0', 5400);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (255, 1, 150, 'ligula', '0', 5420);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (256, 1, 150, 'turpis.', '0', 5440);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (257, 1, 150, 'magna.', '0', 5460);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (258, 1, 150, 'nisi', '0', 5480);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (259, 1, 150, 'eget', '0', 5500);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (260, 1, 150, 'blandit', '0', 5520);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (261, 1, 150, 'tempor', '0', 5540);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (262, 1, 150, 'eu', '0', 5560);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (263, 1, 150, 'est', '0', 5580);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (264, 1, 150, 'non', '0', 5600);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (265, 1, 150, 'eget', '0', 5620);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (266, 1, 150, 'eu,', '0', 5640);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (267, 1, 150, 'accumsan', '0', 5660);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (268, 1, 150, 'gravida', '0', 5680);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (269, 1, 150, 'velit.', '0', 5700);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (270, 1, 150, 'vulputate', '0', 5720);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (271, 1, 150, 'sem.', '0', 5740);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (272, 1, 150, 'amet', '0', 5760);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (273, 1, 150, 'in', '0', 5780);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (274, 1, 150, 'lorem', '0', 5800);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (275, 1, 150, 'sem', '0', 5820);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (276, 1, 150, 'lacus.', '0', 5840);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (277, 1, 150, 'facilisis', '0', 5860);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (278, 1, 150, 'Curae;', '0', 5880);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (279, 1, 150, 'nunc.', '0', 5900);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (280, 1, 150, 'Vestibulum', '0', 5920);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (281, 1, 150, 'ligula.', '0', 5940);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (282, 1, 150, 'aliquet', '0', 5960);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (283, 1, 150, 'a,', '0', 5980);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (284, 1, 150, 'In', '0', 6000);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (285, 1, 150, 'semper', '0', 6020);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (286, 1, 150, 'malesuada', '0', 6040);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (287, 1, 150, 'augue', '0', 6060);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (288, 1, 150, 'feugiat', '0', 6080);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (289, 1, 150, 'ad', '0', 6100);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (290, 1, 150, 'at,', '0', 6120);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (291, 1, 125, 'pede', '0', 6140);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (292, 1, 125, 'tempus', '0', 6160);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (293, 1, 125, 'nonummy', '0', 6180);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (294, 1, 125, 'convallis', '0', 6200);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (295, 1, 125, 'velit', '0', 6220);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (296, 1, 125, 'Mauris', '0', 6240);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (297, 1, 125, 'cursus', '0', 6260);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (298, 1, 125, 'Proin', '0', 6280);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (299, 1, 125, 'sem', '0', 6300);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (300, 1, 125, 'consequat', '0', 6320);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (301, 1, 125, 'est', '0', 6340);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (302, 1, 125, 'arcu', '0', 6360);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (303, 1, 125, 'metus.', '0', 6380);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (304, 1, 125, 'at', '0', 6400);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (305, 1, 125, 'aliquet', '0', 6420);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (306, 1, 125, 'id', '0', 6440);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (307, 1, 125, 'Donec', '0', 6460);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (308, 1, 125, 'eu', '0', 6480);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (309, 1, 125, 'quis,', '0', 6500);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (310, 1, 125, 'primis', '0', 6520);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (311, 1, 125, 'euismod', '0', 6540);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (312, 1, 125, 'elementum,', '0', 6560);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (313, 1, 125, 'conubia', '0', 6580);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (314, 1, 125, 'tempus,', '0', 6600);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (315, 1, 125, 'est', '0', 6620);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (316, 1, 125, 'Suspendisse', '0', 6640);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (317, 1, 125, 'torquent', '0', 6660);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (318, 1, 125, 'amet,', '0', 6680);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (319, 1, 125, 'sed', '0', 6700);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (320, 1, 125, 'enim.', '0', 6720);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (321, 1, 125, 'ut', '0', 6740);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (322, 1, 125, 'malesuada', '0', 6760);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (323, 1, 125, 'sit', '0', 6780);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (324, 1, 125, 'eu', '0', 6800);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (325, 1, 125, 'faucibus', '0', 6820);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (326, 1, 125, 'at', '0', 6840);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (327, 1, 125, 'magna.', '0', 6860);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (328, 1, 125, 'sem', '0', 6880);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (329, 1, 125, 'pretium', '0', 6900);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (330, 1, 125, 'sed,', '0', 6920);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (331, 1, 125, 'ornare,', '0', 6940);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (332, 1, 125, 'neque', '0', 6960);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (333, 1, 125, 'arcu', '0', 6980);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (334, 1, 125, 'ante', '0', 7000);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (335, 1, 125, 'lectus.', '0', 7020);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (336, 1, 125, 'metus.', '0', 7040);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (337, 1, 125, 'lobortis', '0', 7060);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (338, 1, 125, 'eget', '0', 7080);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (339, 1, 125, 'lorem,', '0', 7100);
INSERT INTO `prueba_stf`.`embarcacion` (`idembarcacion`, `disponibilidad`, `calado`, `descripcion`, `boton_panico`, `ubicaciones_idubicacion`) VALUES (340, 1, 125, 'nibh', '0', 7120);

COMMIT;


-- -----------------------------------------------------
-- Data for table `prueba_stf`.`cab`
-- -----------------------------------------------------
START TRANSACTION;
USE `prueba_stf`;
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (1, 1);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (2, 2);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (3, 3);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (4, 4);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (5, 5);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (6, 6);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (7, 7);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (8, 8);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (9, 9);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (10, 10);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (11, 11);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (12, 12);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (13, 13);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (14, 14);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (15, 15);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (16, 16);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (17, 17);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (18, 18);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (19, 19);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (20, 20);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (21, 21);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (22, 22);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (23, 23);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (24, 24);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (25, 25);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (26, 26);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (27, 27);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (28, 28);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (29, 29);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (30, 30);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (31, 31);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (32, 32);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (33, 33);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (34, 34);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (35, 35);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (36, 36);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (37, 37);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (38, 38);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (39, 39);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (40, 40);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (41, 41);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (42, 42);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (43, 43);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (44, 44);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (45, 45);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (46, 46);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (47, 47);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (48, 48);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (49, 49);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (50, 50);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (51, 51);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (52, 52);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (53, 53);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (54, 54);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (55, 55);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (56, 56);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (57, 57);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (58, 58);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (59, 59);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (60, 60);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (61, 61);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (62, 62);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (63, 63);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (64, 64);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (65, 65);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (66, 66);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (67, 67);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (68, 68);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (69, 69);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (70, 70);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (71, 71);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (72, 72);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (73, 73);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (74, 74);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (75, 75);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (76, 76);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (77, 77);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (78, 78);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (79, 79);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (80, 80);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (81, 81);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (82, 82);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (83, 83);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (84, 84);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (85, 85);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (86, 86);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (87, 87);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (88, 88);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (89, 89);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (90, 90);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (91, 91);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (92, 92);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (93, 93);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (94, 94);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (95, 95);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (96, 96);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (97, 97);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (98, 98);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (99, 99);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (100, 100);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (101, 101);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (102, 102);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (103, 103);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (104, 104);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (105, 105);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (106, 106);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (107, 107);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (108, 108);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (109, 109);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (110, 110);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (111, 111);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (112, 112);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (113, 113);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (114, 114);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (115, 115);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (116, 116);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (117, 117);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (118, 118);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (119, 119);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (120, 120);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (121, 121);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (122, 122);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (123, 123);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (124, 124);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (125, 125);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (126, 126);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (127, 127);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (128, 128);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (129, 129);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (130, 130);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (131, 131);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (132, 132);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (133, 133);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (134, 134);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (135, 135);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (136, 136);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (137, 137);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (138, 138);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (139, 139);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (140, 140);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (141, 141);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (142, 142);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (143, 143);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (144, 144);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (145, 145);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (146, 146);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (147, 147);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (148, 148);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (149, 149);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (150, 150);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (151, 151);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (152, 152);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (153, 153);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (154, 154);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (155, 155);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (156, 156);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (157, 157);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (158, 158);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (159, 159);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (160, 160);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (161, 161);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (162, 162);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (163, 163);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (164, 164);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (165, 165);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (166, 166);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (167, 167);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (168, 168);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (169, 169);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (170, 170);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (171, 171);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (172, 172);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (173, 173);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (174, 174);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (175, 175);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (176, 176);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (177, 177);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (178, 178);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (179, 179);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (180, 180);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (181, 181);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (182, 182);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (183, 183);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (184, 184);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (185, 185);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (186, 186);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (187, 187);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (188, 188);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (189, 189);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (190, 190);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (191, 191);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (192, 192);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (193, 193);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (194, 194);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (195, 195);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (196, 196);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (197, 197);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (198, 198);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (199, 199);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (200, 200);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (201, 201);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (202, 202);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (203, 203);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (204, 204);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (205, 205);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (206, 206);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (207, 207);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (208, 208);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (209, 209);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (210, 210);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (211, 211);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (212, 212);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (213, 213);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (214, 214);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (215, 215);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (216, 216);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (217, 217);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (218, 218);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (219, 219);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (220, 220);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (221, 221);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (222, 222);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (223, 223);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (224, 224);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (225, 225);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (226, 226);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (227, 227);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (228, 228);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (229, 229);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (230, 230);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (231, 231);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (232, 232);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (233, 233);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (234, 234);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (235, 235);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (236, 236);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (237, 237);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (238, 238);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (239, 239);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (240, 240);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (241, 241);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (242, 242);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (243, 243);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (244, 244);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (245, 245);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (246, 246);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (247, 247);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (248, 248);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (249, 249);
INSERT INTO `prueba_stf`.`cab` (`idcab`, `embarcaciones_idembarcacion`) VALUES (250, 250);

COMMIT;


-- -----------------------------------------------------
-- Data for table `prueba_stf`.`cargo`
-- -----------------------------------------------------
START TRANSACTION;
USE `prueba_stf`;
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (1, 0, 251);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (2, 0, 252);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (3, 0, 253);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (4, 0, 254);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (5, 0, 255);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (6, 0, 256);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (7, 0, 257);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (8, 0, 258);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (9, 0, 259);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (10, 0, 260);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (11, 0, 261);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (12, 0, 262);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (13, 0, 263);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (14, 0, 264);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (15, 0, 265);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (16, 0, 266);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (17, 0, 267);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (18, 0, 268);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (19, 0, 269);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (20, 0, 270);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (21, 0, 271);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (22, 0, 272);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (23, 0, 273);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (24, 0, 274);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (25, 0, 275);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (26, 0, 276);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (27, 0, 277);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (28, 0, 278);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (29, 0, 279);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (30, 0, 280);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (31, 0, 281);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (32, 0, 282);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (33, 0, 283);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (34, 0, 284);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (35, 0, 285);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (36, 0, 286);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (37, 0, 287);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (38, 0, 288);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (39, 0, 289);
INSERT INTO `prueba_stf`.`cargo` (`idcargo`, `peso_carga`, `embarcaciones_idembarcacion`) VALUES (40, 0, 290);

COMMIT;


-- -----------------------------------------------------
-- Data for table `prueba_stf`.`passenger`
-- -----------------------------------------------------
START TRANSACTION;
USE `prueba_stf`;
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (1, 0, 291);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (2, 0, 292);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (3, 0, 293);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (4, 0, 294);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (5, 0, 295);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (6, 0, 296);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (7, 0, 297);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (8, 0, 298);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (9, 0, 299);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (10, 0, 300);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (11, 0, 301);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (12, 0, 302);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (13, 0, 303);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (14, 0, 304);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (15, 0, 305);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (16, 0, 306);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (17, 0, 307);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (18, 0, 308);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (19, 0, 309);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (20, 0, 310);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (21, 0, 311);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (22, 0, 312);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (23, 0, 313);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (24, 0, 314);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (25, 0, 315);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (26, 0, 316);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (27, 0, 317);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (28, 0, 318);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (29, 0, 319);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (30, 0, 320);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (31, 0, 321);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (32, 0, 322);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (33, 0, 323);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (34, 0, 324);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (35, 0, 325);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (36, 0, 326);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (37, 0, 327);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (38, 0, 328);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (39, 0, 329);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (40, 0, 330);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (41, 0, 331);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (42, 0, 332);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (43, 0, 333);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (44, 0, 334);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (45, 0, 335);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (46, 0, 336);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (47, 0, 337);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (48, 0, 338);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (49, 0, 339);
INSERT INTO `prueba_stf`.`passenger` (`idpassengers`, `cantidad_pasageros`, `embarcaciones_idembarcacion`) VALUES (50, 0, 340);

COMMIT;


-- -----------------------------------------------------
-- Data for table `prueba_stf`.`sensor`
-- -----------------------------------------------------
START TRANSACTION;
USE `prueba_stf`;
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (1, 200, '0000-00-00', 7140);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (2, 200, '0000-00-00', 7160);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (3, 200, '0000-00-00', 7180);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (4, 200, '0000-00-00', 7200);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (5, 200, '0000-00-00', 7220);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (6, 200, '0000-00-00', 7240);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (7, 200, '0000-00-00', 7260);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (8, 200, '0000-00-00', 7280);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (9, 200, '0000-00-00', 7300);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (10, 200, '0000-00-00', 7320);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (11, 200, '0000-00-00', 7340);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (12, 200, '0000-00-00', 7360);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (13, 200, '0000-00-00', 7380);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (14, 200, '0000-00-00', 7400);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (15, 200, '0000-00-00', 7420);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (16, 200, '0000-00-00', 7440);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (17, 200, '0000-00-00', 7460);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (18, 200, '0000-00-00', 7480);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (19, 200, '0000-00-00', 7500);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (20, 200, '0000-00-00', 7520);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (21, 200, '0000-00-00', 7540);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (22, 200, '0000-00-00', 7560);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (23, 200, '0000-00-00', 7580);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (24, 200, '0000-00-00', 7600);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (25, 200, '0000-00-00', 7620);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (26, 200, '0000-00-00', 7640);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (27, 200, '0000-00-00', 7660);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (28, 200, '0000-00-00', 7680);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (29, 200, '0000-00-00', 7700);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (30, 200, '0000-00-00', 7720);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (31, 200, '0000-00-00', 7740);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (32, 200, '0000-00-00', 7760);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (33, 200, '0000-00-00', 7780);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (34, 200, '0000-00-00', 7800);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (35, 200, '0000-00-00', 7820);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (36, 200, '0000-00-00', 7840);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (37, 200, '0000-00-00', 7860);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (38, 200, '0000-00-00', 7880);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (39, 200, '0000-00-00', 7900);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (40, 200, '0000-00-00', 7920);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (41, 200, '0000-00-00', 7940);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (42, 200, '0000-00-00', 7960);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (43, 200, '0000-00-00', 7980);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (44, 200, '0000-00-00', 8000);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (45, 200, '0000-00-00', 8020);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (46, 200, '0000-00-00', 8040);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (47, 200, '0000-00-00', 8060);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (48, 200, '0000-00-00', 8080);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (49, 200, '0000-00-00', 8100);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (50, 200, '0000-00-00', 8120);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (51, 200, '0000-00-00', 8140);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (52, 200, '0000-00-00', 8160);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (53, 200, '0000-00-00', 8180);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (54, 200, '0000-00-00', 8200);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (55, 200, '0000-00-00', 8220);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (56, 200, '0000-00-00', 8240);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (57, 200, '0000-00-00', 8260);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (58, 200, '0000-00-00', 8280);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (59, 200, '0000-00-00', 8300);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (60, 200, '0000-00-00', 8320);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (61, 200, '0000-00-00', 8340);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (62, 200, '0000-00-00', 8360);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (63, 200, '0000-00-00', 8380);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (64, 200, '0000-00-00', 8400);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (65, 200, '0000-00-00', 8420);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (66, 200, '0000-00-00', 8440);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (67, 200, '0000-00-00', 8460);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (68, 200, '0000-00-00', 8480);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (69, 200, '0000-00-00', 8500);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (70, 200, '0000-00-00', 8520);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (71, 200, '0000-00-00', 8540);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (72, 200, '0000-00-00', 8560);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (73, 200, '0000-00-00', 8580);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (74, 200, '0000-00-00', 8600);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (75, 200, '0000-00-00', 8620);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (76, 200, '0000-00-00', 8640);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (77, 200, '0000-00-00', 8660);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (78, 200, '0000-00-00', 8680);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (79, 200, '0000-00-00', 8700);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (80, 200, '0000-00-00', 8720);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (81, 200, '0000-00-00', 8740);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (82, 200, '0000-00-00', 8760);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (83, 200, '0000-00-00', 8780);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (84, 200, '0000-00-00', 8800);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (85, 200, '0000-00-00', 8820);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (86, 200, '0000-00-00', 8840);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (87, 200, '0000-00-00', 8860);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (88, 200, '0000-00-00', 8880);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (89, 200, '0000-00-00', 8900);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (90, 200, '0000-00-00', 8920);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (91, 200, '0000-00-00', 8940);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (92, 200, '0000-00-00', 8960);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (93, 200, '0000-00-00', 8980);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (94, 200, '0000-00-00', 9000);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (95, 200, '0000-00-00', 9020);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (96, 200, '0000-00-00', 9040);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (97, 200, '0000-00-00', 9060);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (98, 200, '0000-00-00', 9080);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (99, 200, '0000-00-00', 9100);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (100, 200, '0000-00-00', 9120);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (101, 200, '0000-00-00', 9140);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (102, 200, '0000-00-00', 9160);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (103, 200, '0000-00-00', 9180);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (104, 200, '0000-00-00', 9200);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (105, 200, '0000-00-00', 9220);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (106, 200, '0000-00-00', 9240);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (107, 200, '0000-00-00', 9260);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (108, 200, '0000-00-00', 9280);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (109, 200, '0000-00-00', 9300);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (110, 200, '0000-00-00', 9320);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (111, 200, '0000-00-00', 9340);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (112, 200, '0000-00-00', 9360);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (113, 200, '0000-00-00', 9380);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (114, 200, '0000-00-00', 9400);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (115, 200, '0000-00-00', 9420);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (116, 200, '0000-00-00', 9440);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (117, 200, '0000-00-00', 9460);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (118, 200, '0000-00-00', 9480);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (119, 200, '0000-00-00', 9500);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (120, 200, '0000-00-00', 9520);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (121, 200, '0000-00-00', 9540);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (122, 200, '0000-00-00', 9560);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (123, 200, '0000-00-00', 9580);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (124, 200, '0000-00-00', 9600);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (125, 200, '0000-00-00', 9620);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (126, 200, '0000-00-00', 9640);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (127, 200, '0000-00-00', 9660);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (128, 200, '0000-00-00', 9680);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (129, 200, '0000-00-00', 9700);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (130, 200, '0000-00-00', 9720);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (131, 200, '0000-00-00', 9740);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (132, 200, '0000-00-00', 9760);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (133, 200, '0000-00-00', 9780);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (134, 200, '0000-00-00', 9800);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (135, 200, '0000-00-00', 9820);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (136, 200, '0000-00-00', 9840);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (137, 200, '0000-00-00', 9860);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (138, 200, '0000-00-00', 9880);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (139, 200, '0000-00-00', 9900);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (140, 200, '0000-00-00', 9920);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (141, 200, '0000-00-00', 9940);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (142, 200, '0000-00-00', 9960);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (143, 200, '0000-00-00', 9980);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (144, 200, '0000-00-00', 10000);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (145, 200, '0000-00-00', 10020);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (146, 200, '0000-00-00', 10040);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (147, 200, '0000-00-00', 10060);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (148, 200, '0000-00-00', 10080);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (149, 200, '0000-00-00', 10100);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (150, 200, '0000-00-00', 10120);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (151, 200, '0000-00-00', 10140);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (152, 200, '0000-00-00', 10160);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (153, 200, '0000-00-00', 10180);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (154, 200, '0000-00-00', 10200);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (155, 200, '0000-00-00', 10220);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (156, 200, '0000-00-00', 10240);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (157, 200, '0000-00-00', 10260);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (158, 200, '0000-00-00', 10280);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (159, 200, '0000-00-00', 10300);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (160, 200, '0000-00-00', 10320);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (161, 200, '0000-00-00', 10340);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (162, 200, '0000-00-00', 10360);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (163, 200, '0000-00-00', 10380);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (164, 200, '0000-00-00', 10400);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (165, 200, '0000-00-00', 10420);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (166, 200, '0000-00-00', 10440);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (167, 200, '0000-00-00', 10460);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (168, 200, '0000-00-00', 10480);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (169, 200, '0000-00-00', 10500);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (170, 200, '0000-00-00', 10520);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (171, 200, '0000-00-00', 10540);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (172, 200, '0000-00-00', 10560);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (173, 200, '0000-00-00', 10580);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (174, 200, '0000-00-00', 10600);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (175, 200, '0000-00-00', 10620);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (176, 200, '0000-00-00', 10640);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (177, 200, '0000-00-00', 10660);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (178, 200, '0000-00-00', 10680);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (179, 200, '0000-00-00', 10700);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (180, 200, '0000-00-00', 10720);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (181, 200, '0000-00-00', 10740);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (182, 200, '0000-00-00', 10760);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (183, 200, '0000-00-00', 10780);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (184, 200, '0000-00-00', 10800);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (185, 200, '0000-00-00', 10820);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (186, 200, '0000-00-00', 10840);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (187, 200, '0000-00-00', 10860);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (188, 200, '0000-00-00', 10880);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (189, 200, '0000-00-00', 10900);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (190, 200, '0000-00-00', 10920);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (191, 200, '0000-00-00', 10940);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (192, 200, '0000-00-00', 10960);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (193, 200, '0000-00-00', 10980);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (194, 200, '0000-00-00', 11000);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (195, 200, '0000-00-00', 11020);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (196, 200, '0000-00-00', 11040);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (197, 200, '0000-00-00', 11060);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (198, 200, '0000-00-00', 11080);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (199, 200, '0000-00-00', 11100);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (200, 200, '0000-00-00', 11120);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (201, 200, '0000-00-00', 11140);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (202, 200, '0000-00-00', 11160);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (203, 200, '0000-00-00', 11180);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (204, 200, '0000-00-00', 11200);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (205, 200, '0000-00-00', 11220);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (206, 200, '0000-00-00', 11240);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (207, 200, '0000-00-00', 11260);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (208, 200, '0000-00-00', 11280);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (209, 200, '0000-00-00', 11300);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (210, 200, '0000-00-00', 11320);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (211, 200, '0000-00-00', 11340);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (212, 200, '0000-00-00', 11360);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (213, 200, '0000-00-00', 11380);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (214, 200, '0000-00-00', 11400);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (215, 200, '0000-00-00', 11420);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (216, 200, '0000-00-00', 11440);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (217, 200, '0000-00-00', 11460);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (218, 200, '0000-00-00', 11480);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (219, 200, '0000-00-00', 11500);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (220, 200, '0000-00-00', 11520);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (221, 200, '0000-00-00', 11540);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (222, 200, '0000-00-00', 11560);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (223, 200, '0000-00-00', 11580);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (224, 200, '0000-00-00', 11600);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (225, 200, '0000-00-00', 11620);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (226, 200, '0000-00-00', 11640);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (227, 200, '0000-00-00', 11660);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (228, 200, '0000-00-00', 11680);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (229, 200, '0000-00-00', 11700);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (230, 200, '0000-00-00', 11720);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (231, 200, '0000-00-00', 11740);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (232, 200, '0000-00-00', 11760);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (233, 200, '0000-00-00', 11780);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (234, 200, '0000-00-00', 11800);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (235, 200, '0000-00-00', 11820);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (236, 200, '0000-00-00', 11840);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (237, 200, '0000-00-00', 11860);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (238, 200, '0000-00-00', 11880);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (239, 200, '0000-00-00', 11900);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (240, 200, '0000-00-00', 11920);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (241, 200, '0000-00-00', 11940);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (242, 200, '0000-00-00', 11960);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (243, 200, '0000-00-00', 11980);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (244, 200, '0000-00-00', 12000);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (245, 200, '0000-00-00', 12020);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (246, 200, '0000-00-00', 12040);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (247, 200, '0000-00-00', 12060);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (248, 200, '0000-00-00', 12080);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (249, 200, '0000-00-00', 12100);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (250, 200, '0000-00-00', 12120);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (251, 200, '0000-00-00', 12140);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (252, 200, '0000-00-00', 12160);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (253, 200, '0000-00-00', 12180);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (254, 200, '0000-00-00', 12200);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (255, 200, '0000-00-00', 12220);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (256, 200, '0000-00-00', 12240);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (257, 200, '0000-00-00', 12260);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (258, 200, '0000-00-00', 12280);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (259, 200, '0000-00-00', 12300);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (260, 200, '0000-00-00', 12320);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (261, 200, '0000-00-00', 12340);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (262, 200, '0000-00-00', 12360);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (263, 200, '0000-00-00', 12380);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (264, 200, '0000-00-00', 12400);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (265, 200, '0000-00-00', 12420);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (266, 200, '0000-00-00', 12440);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (267, 200, '0000-00-00', 12460);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (268, 200, '0000-00-00', 12480);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (269, 200, '0000-00-00', 12500);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (270, 200, '0000-00-00', 12520);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (271, 200, '0000-00-00', 12540);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (272, 200, '0000-00-00', 12560);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (273, 200, '0000-00-00', 12580);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (274, 200, '0000-00-00', 12600);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (275, 200, '0000-00-00', 12620);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (276, 200, '0000-00-00', 12640);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (277, 200, '0000-00-00', 12660);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (278, 200, '0000-00-00', 12680);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (279, 200, '0000-00-00', 12700);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (280, 200, '0000-00-00', 12720);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (281, 200, '0000-00-00', 12740);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (282, 200, '0000-00-00', 12760);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (283, 200, '0000-00-00', 12780);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (284, 200, '0000-00-00', 12800);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (285, 200, '0000-00-00', 12820);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (286, 200, '0000-00-00', 12840);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (287, 200, '0000-00-00', 12860);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (288, 200, '0000-00-00', 12880);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (289, 200, '0000-00-00', 12900);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (290, 200, '0000-00-00', 12920);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (291, 200, '0000-00-00', 12940);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (292, 200, '0000-00-00', 12960);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (293, 200, '0000-00-00', 12980);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (294, 200, '0000-00-00', 13000);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (295, 200, '0000-00-00', 13020);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (296, 200, '0000-00-00', 13040);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (297, 200, '0000-00-00', 13060);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (298, 200, '0000-00-00', 13080);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (299, 200, '0000-00-00', 13100);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (300, 200, '0000-00-00', 13120);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (301, 200, '0000-00-00', 13140);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (302, 200, '0000-00-00', 13160);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (303, 200, '0000-00-00', 13180);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (304, 200, '0000-00-00', 13200);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (305, 200, '0000-00-00', 13220);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (306, 200, '0000-00-00', 13240);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (307, 200, '0000-00-00', 13260);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (308, 200, '0000-00-00', 13280);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (309, 200, '0000-00-00', 13300);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (310, 200, '0000-00-00', 13320);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (311, 200, '0000-00-00', 13340);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (312, 200, '0000-00-00', 13360);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (313, 200, '0000-00-00', 13380);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (314, 200, '0000-00-00', 13400);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (315, 200, '0000-00-00', 13420);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (316, 200, '0000-00-00', 13440);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (317, 200, '0000-00-00', 13460);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (318, 200, '0000-00-00', 13480);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (319, 200, '0000-00-00', 13500);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (320, 200, '0000-00-00', 13520);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (321, 200, '0000-00-00', 13540);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (322, 200, '0000-00-00', 13560);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (323, 200, '0000-00-00', 13580);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (324, 200, '0000-00-00', 13600);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (325, 200, '0000-00-00', 13620);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (326, 200, '0000-00-00', 13640);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (327, 200, '0000-00-00', 13660);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (328, 200, '0000-00-00', 13680);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (329, 200, '0000-00-00', 13700);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (330, 200, '0000-00-00', 13720);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (331, 200, '0000-00-00', 13740);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (332, 200, '0000-00-00', 13760);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (333, 200, '0000-00-00', 13780);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (334, 200, '0000-00-00', 13800);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (335, 200, '0000-00-00', 13820);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (336, 200, '0000-00-00', 13840);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (337, 200, '0000-00-00', 13860);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (338, 200, '0000-00-00', 13880);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (339, 200, '0000-00-00', 13900);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (340, 200, '0000-00-00', 13920);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (341, 200, '0000-00-00', 13940);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (342, 200, '0000-00-00', 13960);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (343, 200, '0000-00-00', 13980);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (344, 200, '0000-00-00', 14000);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (345, 200, '0000-00-00', 14020);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (346, 200, '0000-00-00', 14040);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (347, 200, '0000-00-00', 14060);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (348, 200, '0000-00-00', 14080);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (349, 200, '0000-00-00', 14100);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (350, 200, '0000-00-00', 14120);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (351, 200, '0000-00-00', 14140);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (352, 200, '0000-00-00', 14160);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (353, 200, '0000-00-00', 14180);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (354, 200, '0000-00-00', 14200);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (355, 200, '0000-00-00', 14220);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (356, 200, '0000-00-00', 14240);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (357, 200, '0000-00-00', 14260);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (358, 200, '0000-00-00', 14280);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (359, 200, '0000-00-00', 14300);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (360, 200, '0000-00-00', 14320);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (361, 200, '0000-00-00', 14340);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (362, 200, '0000-00-00', 14360);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (363, 200, '0000-00-00', 14380);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (364, 200, '0000-00-00', 14400);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (365, 200, '0000-00-00', 14420);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (366, 200, '0000-00-00', 14440);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (367, 200, '0000-00-00', 14460);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (368, 200, '0000-00-00', 14480);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (369, 200, '0000-00-00', 14500);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (370, 200, '0000-00-00', 14520);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (371, 200, '0000-00-00', 14540);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (372, 200, '0000-00-00', 14560);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (373, 200, '0000-00-00', 14580);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (374, 200, '0000-00-00', 14600);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (375, 200, '0000-00-00', 14620);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (376, 200, '0000-00-00', 14640);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (377, 200, '0000-00-00', 14660);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (378, 200, '0000-00-00', 14680);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (379, 200, '0000-00-00', 14700);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (380, 200, '0000-00-00', 14720);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (381, 200, '0000-00-00', 14740);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (382, 200, '0000-00-00', 14760);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (383, 200, '0000-00-00', 14780);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (384, 200, '0000-00-00', 14800);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (385, 200, '0000-00-00', 14820);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (386, 200, '0000-00-00', 14840);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (387, 200, '0000-00-00', 14860);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (388, 200, '0000-00-00', 14880);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (389, 200, '0000-00-00', 14900);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (390, 200, '0000-00-00', 14920);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (391, 200, '0000-00-00', 14940);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (392, 200, '0000-00-00', 14960);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (393, 200, '0000-00-00', 14980);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (394, 200, '0000-00-00', 15000);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (395, 200, '0000-00-00', 15020);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (396, 200, '0000-00-00', 15040);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (397, 200, '0000-00-00', 15060);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (398, 200, '0000-00-00', 15080);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (399, 200, '0000-00-00', 15100);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (400, 200, '0000-00-00', 15120);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (401, 200, '0000-00-00', 15140);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (402, 200, '0000-00-00', 15160);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (403, 200, '0000-00-00', 15180);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (404, 200, '0000-00-00', 15200);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (405, 200, '0000-00-00', 15220);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (406, 200, '0000-00-00', 15240);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (407, 200, '0000-00-00', 15260);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (408, 200, '0000-00-00', 15280);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (409, 200, '0000-00-00', 15300);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (410, 200, '0000-00-00', 15320);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (411, 200, '0000-00-00', 15340);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (412, 200, '0000-00-00', 15360);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (413, 200, '0000-00-00', 15380);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (414, 200, '0000-00-00', 15400);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (415, 200, '0000-00-00', 15420);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (416, 200, '0000-00-00', 15440);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (417, 200, '0000-00-00', 15460);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (418, 200, '0000-00-00', 15480);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (419, 200, '0000-00-00', 15500);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (420, 200, '0000-00-00', 15520);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (421, 200, '0000-00-00', 15540);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (422, 200, '0000-00-00', 15560);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (423, 200, '0000-00-00', 15580);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (424, 200, '0000-00-00', 15600);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (425, 200, '0000-00-00', 15620);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (426, 200, '0000-00-00', 15640);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (427, 200, '0000-00-00', 15660);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (428, 200, '0000-00-00', 15680);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (429, 200, '0000-00-00', 15700);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (430, 200, '0000-00-00', 15720);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (431, 200, '0000-00-00', 15740);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (432, 200, '0000-00-00', 15760);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (433, 200, '0000-00-00', 15780);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (434, 200, '0000-00-00', 15800);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (435, 200, '0000-00-00', 15820);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (436, 200, '0000-00-00', 15840);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (437, 200, '0000-00-00', 15860);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (438, 200, '0000-00-00', 15880);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (439, 200, '0000-00-00', 15900);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (440, 200, '0000-00-00', 15920);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (441, 200, '0000-00-00', 15940);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (442, 200, '0000-00-00', 15960);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (443, 200, '0000-00-00', 15980);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (444, 200, '0000-00-00', 16000);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (445, 200, '0000-00-00', 16020);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (446, 200, '0000-00-00', 16040);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (447, 200, '0000-00-00', 16060);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (448, 200, '0000-00-00', 16080);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (449, 200, '0000-00-00', 16100);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (450, 200, '0000-00-00', 16120);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (451, 200, '0000-00-00', 16140);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (452, 200, '0000-00-00', 16160);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (453, 200, '0000-00-00', 16180);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (454, 200, '0000-00-00', 16200);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (455, 200, '0000-00-00', 16220);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (456, 200, '0000-00-00', 16240);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (457, 200, '0000-00-00', 16260);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (458, 200, '0000-00-00', 16280);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (459, 200, '0000-00-00', 16300);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (460, 200, '0000-00-00', 16320);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (461, 200, '0000-00-00', 16340);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (462, 200, '0000-00-00', 16360);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (463, 200, '0000-00-00', 16380);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (464, 200, '0000-00-00', 16400);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (465, 200, '0000-00-00', 16420);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (466, 200, '0000-00-00', 16440);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (467, 200, '0000-00-00', 16460);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (468, 200, '0000-00-00', 16480);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (469, 200, '0000-00-00', 16500);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (470, 200, '0000-00-00', 16520);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (471, 200, '0000-00-00', 16540);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (472, 200, '0000-00-00', 16560);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (473, 200, '0000-00-00', 16580);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (474, 200, '0000-00-00', 16600);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (475, 200, '0000-00-00', 16620);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (476, 200, '0000-00-00', 16640);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (477, 200, '0000-00-00', 16660);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (478, 200, '0000-00-00', 16680);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (479, 200, '0000-00-00', 16700);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (480, 200, '0000-00-00', 16720);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (481, 200, '0000-00-00', 16740);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (482, 200, '0000-00-00', 16760);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (483, 200, '0000-00-00', 16780);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (484, 200, '0000-00-00', 16800);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (485, 200, '0000-00-00', 16820);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (486, 200, '0000-00-00', 16840);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (487, 200, '0000-00-00', 16860);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (488, 200, '0000-00-00', 16880);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (489, 200, '0000-00-00', 16900);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (490, 200, '0000-00-00', 16920);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (491, 200, '0000-00-00', 16940);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (492, 200, '0000-00-00', 16960);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (493, 200, '0000-00-00', 16980);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (494, 200, '0000-00-00', 17000);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (495, 200, '0000-00-00', 17020);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (496, 200, '0000-00-00', 17040);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (497, 200, '0000-00-00', 17060);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (498, 200, '0000-00-00', 17080);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (499, 200, '0000-00-00', 17100);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (500, 200, '0000-00-00', 17120);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (501, 200, '0000-00-00', 17140);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (502, 200, '0000-00-00', 17160);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (503, 200, '0000-00-00', 17180);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (504, 200, '0000-00-00', 17200);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (505, 200, '0000-00-00', 17220);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (506, 200, '0000-00-00', 17240);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (507, 200, '0000-00-00', 17260);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (508, 200, '0000-00-00', 17280);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (509, 200, '0000-00-00', 17300);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (510, 200, '0000-00-00', 17320);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (511, 200, '0000-00-00', 17340);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (512, 200, '0000-00-00', 17360);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (513, 200, '0000-00-00', 17380);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (514, 200, '0000-00-00', 17400);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (515, 200, '0000-00-00', 17420);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (516, 200, '0000-00-00', 17440);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (517, 200, '0000-00-00', 17460);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (518, 200, '0000-00-00', 17480);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (519, 200, '0000-00-00', 17500);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (520, 200, '0000-00-00', 17520);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (521, 200, '0000-00-00', 17540);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (522, 200, '0000-00-00', 17560);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (523, 200, '0000-00-00', 17580);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (524, 200, '0000-00-00', 17600);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (525, 200, '0000-00-00', 17620);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (526, 200, '0000-00-00', 17640);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (527, 200, '0000-00-00', 17660);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (528, 200, '0000-00-00', 17680);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (529, 200, '0000-00-00', 17700);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (530, 200, '0000-00-00', 17720);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (531, 200, '0000-00-00', 17740);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (532, 200, '0000-00-00', 17760);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (533, 200, '0000-00-00', 17780);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (534, 200, '0000-00-00', 17800);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (535, 200, '0000-00-00', 17820);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (536, 200, '0000-00-00', 17840);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (537, 200, '0000-00-00', 17860);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (538, 200, '0000-00-00', 17880);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (539, 200, '0000-00-00', 17900);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (540, 200, '0000-00-00', 17920);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (541, 200, '0000-00-00', 17940);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (542, 200, '0000-00-00', 17960);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (543, 200, '0000-00-00', 17980);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (544, 200, '0000-00-00', 18000);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (545, 200, '0000-00-00', 18020);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (546, 200, '0000-00-00', 18040);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (547, 200, '0000-00-00', 18060);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (548, 200, '0000-00-00', 18080);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (549, 200, '0000-00-00', 18100);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (550, 200, '0000-00-00', 18120);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (551, 200, '0000-00-00', 18140);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (552, 200, '0000-00-00', 18160);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (553, 200, '0000-00-00', 18180);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (554, 200, '0000-00-00', 18200);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (555, 200, '0000-00-00', 18220);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (556, 200, '0000-00-00', 18240);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (557, 200, '0000-00-00', 18260);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (558, 200, '0000-00-00', 18280);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (559, 200, '0000-00-00', 18300);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (560, 200, '0000-00-00', 18320);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (561, 200, '0000-00-00', 18340);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (562, 200, '0000-00-00', 18360);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (563, 200, '0000-00-00', 18380);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (564, 200, '0000-00-00', 18400);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (565, 200, '0000-00-00', 18420);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (566, 200, '0000-00-00', 18440);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (567, 200, '0000-00-00', 18460);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (568, 200, '0000-00-00', 18480);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (569, 200, '0000-00-00', 18500);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (570, 200, '0000-00-00', 18520);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (571, 200, '0000-00-00', 18540);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (572, 200, '0000-00-00', 18560);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (573, 200, '0000-00-00', 18580);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (574, 200, '0000-00-00', 18600);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (575, 200, '0000-00-00', 18620);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (576, 200, '0000-00-00', 18640);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (577, 200, '0000-00-00', 18660);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (578, 200, '0000-00-00', 18680);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (579, 200, '0000-00-00', 18700);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (580, 200, '0000-00-00', 18720);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (581, 200, '0000-00-00', 18740);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (582, 200, '0000-00-00', 18760);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (583, 200, '0000-00-00', 18780);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (584, 200, '0000-00-00', 18800);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (585, 200, '0000-00-00', 18820);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (586, 200, '0000-00-00', 18840);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (587, 200, '0000-00-00', 18860);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (588, 200, '0000-00-00', 18880);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (589, 200, '0000-00-00', 18900);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (590, 200, '0000-00-00', 18920);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (591, 200, '0000-00-00', 18940);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (592, 200, '0000-00-00', 18960);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (593, 200, '0000-00-00', 18980);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (594, 200, '0000-00-00', 19000);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (595, 200, '0000-00-00', 19020);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (596, 200, '0000-00-00', 19040);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (597, 200, '0000-00-00', 19060);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (598, 200, '0000-00-00', 19080);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (599, 200, '0000-00-00', 19100);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (600, 200, '0000-00-00', 19120);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (601, 200, '0000-00-00', 19140);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (602, 200, '0000-00-00', 19160);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (603, 200, '0000-00-00', 19180);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (604, 200, '0000-00-00', 19200);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (605, 200, '0000-00-00', 19220);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (606, 200, '0000-00-00', 19240);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (607, 200, '0000-00-00', 19260);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (608, 200, '0000-00-00', 19280);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (609, 200, '0000-00-00', 19300);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (610, 200, '0000-00-00', 19320);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (611, 200, '0000-00-00', 19340);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (612, 200, '0000-00-00', 19360);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (613, 200, '0000-00-00', 19380);
INSERT INTO `prueba_stf`.`sensor` (`idsensor`, `nivel_agua`, `fecha`, `ubicaciones_idubicacion`) VALUES (614, 200, '0000-00-00', 19400);

COMMIT;


-- -----------------------------------------------------
-- Data for table `prueba_stf`.`persona`
-- -----------------------------------------------------
START TRANSACTION;
USE `prueba_stf`;
INSERT INTO `prueba_stf`.`persona` (`idpersona`, `nombres`, `apellidos`, `telefono`, `identificacion`) VALUES (1, 'admin', 'admin', '475515', '753951');
INSERT INTO `prueba_stf`.`persona` (`idpersona`, `nombres`, `apellidos`, `telefono`, `identificacion`) VALUES (2, 'user', 'user', '2556262486', '523');

COMMIT;


-- -----------------------------------------------------
-- Data for table `prueba_stf`.`usuario`
-- -----------------------------------------------------
START TRANSACTION;
USE `prueba_stf`;
INSERT INTO `prueba_stf`.`usuario` (`idusuario`, `usuario`, `password`, `email`, `tipo_u`, `personas_idpersona`) VALUES (1, 'admin', 'admin', 'admin@admin.com', 1, 1);
INSERT INTO `prueba_stf`.`usuario` (`idusuario`, `usuario`, `password`, `email`, `tipo_u`, `personas_idpersona`) VALUES (2, 'user', 'user', 'user@user.com', 0, 2);

COMMIT;

