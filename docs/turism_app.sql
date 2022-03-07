-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Tipos_Usuario
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Tipos_Usuario
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Tipos_Usuario` ;
USE `Tipos_Usuario` ;

-- -----------------------------------------------------
-- Table `Tipos_Usuario`.`usuario_app`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tipos_Usuario`.`usuario_app` (
  `idUsuario` INT NOT NULL,
  `nombreUsuario` VARCHAR(20) NULL,
  `nombre` VARCHAR(50) NOT NULL,
  `fechaNacimiento` DATE NOT NULL,
  `correo` VARCHAR(100) NOT NULL,
  `genero` VARCHAR(1) NOT NULL,
  `tiposTurismo` VARCHAR(20) NOT NULL DEFAULT 'NT',
  `imagenUsuario` BLOB NULL,
  `thumbnailImagen` BLOB NULL,
  `claveAcceso` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE INDEX `idUsuario_UNIQUE` (`idUsuario` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `Tipos_Usuario`.`establecimientos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tipos_Usuario`.`establecimientos` (
  `idEstablecimiento` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(40) NULL,
  `tipoEstablecimiento` VARCHAR(2) NULL,
  `telefono` VARCHAR(10) NULL,
  `correo` VARCHAR(100) NULL,
  `pro` CHAR(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`idEstablecimiento`),
  UNIQUE INDEX `idEstablecimiento_UNIQUE` (`idEstablecimiento` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `Tipos_Usuario`.`administrador_ciudad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tipos_Usuario`.`administrador_ciudad` (
  `idUsuario` INT NOT NULL,
  `nombreUsuario` VARCHAR(20) NULL,
  `nombre` VARCHAR(50) NOT NULL,
  `correo` VARCHAR(100) NOT NULL,
  `imagenUsuario` BLOB NULL,
  `thumbnailImagen` BLOB NULL,
  `cargoCiudad` VARCHAR(45) NULL,
  `claveAcceso` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE INDEX `idUsuario_UNIQUE` (`idUsuario` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `Tipos_Usuario`.`ciudades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tipos_Usuario`.`ciudades` (
  `idCiudad` INT NOT NULL AUTO_INCREMENT,
  `_id_administrador` INT NOT NULL,
  `nombreCiudad` VARCHAR(100) NOT NULL,
  `region` VARCHAR(2) NOT NULL,
  `municipio` VARCHAR(100) NOT NULL,
  `correo` VARCHAR(100) NULL,
  `telefono` VARCHAR(10) NULL,
  `urlMaps` VARCHAR(100) NULL,
  `puebloMagico` BIT(1) NOT NULL DEFAULT 0,
  `tiposTurismo` VARCHAR(10) NOT NULL DEFAULT 'N',
  `imagenRepresentativa` BLOB NOT NULL,
  `clima` VARCHAR(2) NOT NULL,
  `numero_emergencias` VARCHAR(10) NULL,
  PRIMARY KEY (`idCiudad`, `_id_administrador`),
  INDEX `fk_Ciudad_AdministradorCiudad1_idx` (`_id_administrador` ASC) VISIBLE,
  CONSTRAINT `fk_Ciudad_AdministradorCiudad1`
    FOREIGN KEY (`_id_administrador`)
    REFERENCES `Tipos_Usuario`.`administrador_ciudad` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `Tipos_Usuario`.`tipos_turismo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tipos_Usuario`.`tipos_turismo` (
  `idTiposTurismo` VARCHAR(2) NOT NULL,
  `tipoTurismo` VARCHAR(20) NULL,
  PRIMARY KEY (`idTiposTurismo`),
  UNIQUE INDEX `idTiposTurismo_UNIQUE` (`idTiposTurismo` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `Tipos_Usuario`.`direccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tipos_Usuario`.`direccion` (
  `idDireccion` INT NOT NULL AUTO_INCREMENT,
  `_idEstablecimiento` INT NOT NULL,
  `colonia` VARCHAR(50) NOT NULL,
  `numero` VARCHAR(10) NULL DEFAULT 'S/N',
  `cp` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`idDireccion`, `_idEstablecimiento`),
  INDEX `fk_Direccion_Establecimiento_idx` (`_idEstablecimiento` ASC) VISIBLE,
  CONSTRAINT `fk_Direccion_Establecimiento`
    FOREIGN KEY (`_idEstablecimiento`)
    REFERENCES `Tipos_Usuario`.`establecimientos` (`idEstablecimiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `Tipos_Usuario`.`administrador_establecimiento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tipos_Usuario`.`administrador_establecimiento` (
  `idUsuario` INT NOT NULL,
  `claveAcceso` VARCHAR(45) NOT NULL,
  `nombreUsuario` VARCHAR(20) NULL,
  `nombre` VARCHAR(50) NOT NULL,
  `correo` VARCHAR(100) NOT NULL,
  `imagenUsuario` BLOB NULL,
  `thumbnailImagen` BLOB NULL,
  `cargoEmpresa` VARCHAR(45) NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE INDEX `idUsuario_UNIQUE` (`idUsuario` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `Tipos_Usuario`.`establecimiento_pro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tipos_Usuario`.`establecimiento_pro` (
  `_idEstablecimiento` INT NOT NULL,
  `_idAdministrador` INT NOT NULL,
  `calificacion` TINYINT(1) NOT NULL DEFAULT 0,
  `cantidadCalificaciones` INT NOT NULL DEFAULT 0,
  `paginaWeb` VARCHAR(100) NULL,
  `urlMaps` VARCHAR(300) NULL,
  `tiposPago` VARCHAR(45) NOT NULL DEFAULT 'S/T',
  PRIMARY KEY (`_idEstablecimiento`, `_idAdministrador`),
  INDEX `fk_EstablecimientoPro_Establecimiento1_idx` (`_idEstablecimiento` ASC) VISIBLE,
  INDEX `fk_EstablecimientoPro_UsuarioEstablecimiento1_idx` (`_idAdministrador` ASC) VISIBLE,
  CONSTRAINT `fk_EstablecimientoPro_Establecimiento1`
    FOREIGN KEY (`_idEstablecimiento`)
    REFERENCES `Tipos_Usuario`.`establecimientos` (`idEstablecimiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EstablecimientoPro_UsuarioEstablecimiento1`
    FOREIGN KEY (`_idAdministrador`)
    REFERENCES `Tipos_Usuario`.`administrador_establecimiento` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Tipos_Usuario`.`horario_atencion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tipos_Usuario`.`horario_atencion` (
  `idHorarioAtencion` INT NOT NULL AUTO_INCREMENT,
  `_idEstablecimiento` INT NOT NULL,
  `lunes` VARCHAR(10) NOT NULL DEFAULT 'S/A',
  `martes` VARCHAR(10) NOT NULL DEFAULT 'S/A',
  `miercoles` VARCHAR(10) NOT NULL DEFAULT 'S/A',
  `jueves` VARCHAR(10) NOT NULL DEFAULT 'S/A',
  `viernes` VARCHAR(10) NOT NULL DEFAULT 'S/A',
  `sabado` VARCHAR(10) NOT NULL DEFAULT 'S/A',
  `domingo` VARCHAR(10) NOT NULL DEFAULT 'S/A',
  PRIMARY KEY (`idHorarioAtencion`, `_idEstablecimiento`),
  INDEX `fk_HorarioAtencion_EstablecimientoPro1_idx` (`_idEstablecimiento` ASC) VISIBLE,
  CONSTRAINT `fk_HorarioAtencion_EstablecimientoPro1`
    FOREIGN KEY (`_idEstablecimiento`)
    REFERENCES `Tipos_Usuario`.`establecimiento_pro` (`_idEstablecimiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Tipos_Usuario`.`resenhas_establecimiento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tipos_Usuario`.`resenhas_establecimiento` (
  `idResenha` INT NOT NULL AUTO_INCREMENT,
  `_idEstablecimiento` INT NOT NULL,
  `_idUsuario` INT NOT NULL,
  `contenido` TEXT(500) NOT NULL,
  PRIMARY KEY (`idResenha`, `_idEstablecimiento`, `_idUsuario`),
  INDEX `fk_Reseñas_EstablecimientoPro1_idx` (`_idEstablecimiento` ASC) VISIBLE,
  INDEX `fk_Reseñas_Usuario1_idx` (`_idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_Reseñas_EstablecimientoPro1`
    FOREIGN KEY (`_idEstablecimiento`)
    REFERENCES `Tipos_Usuario`.`establecimiento_pro` (`_idEstablecimiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reseñas_Usuario1`
    FOREIGN KEY (`_idUsuario`)
    REFERENCES `Tipos_Usuario`.`usuario_app` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `Tipos_Usuario`.`festividad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tipos_Usuario`.`festividad` (
  `idFecha` INT NOT NULL AUTO_INCREMENT,
  `_idCiudad` INT NOT NULL,
  `dia` TINYINT(2) NOT NULL,
  `mes` TINYINT(2) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(300) NOT NULL,
  `imagen` BLOB NOT NULL,
  PRIMARY KEY (`idFecha`, `_idCiudad`),
  INDEX `fk_FechasImportantes_Ciudad1_idx` (`_idCiudad` ASC) VISIBLE,
  CONSTRAINT `fk_FechasImportantes_Ciudad1`
    FOREIGN KEY (`_idCiudad`)
    REFERENCES `Tipos_Usuario`.`ciudades` (`idCiudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `Tipos_Usuario`.`resenhas_ciudad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tipos_Usuario`.`resenhas_ciudad` (
  `idResenhasCiudad` INT NOT NULL AUTO_INCREMENT,
  `_idCiudad` INT NOT NULL,
  `_idUsuario` INT NOT NULL,
  `contenido` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`idResenhasCiudad`, `_idCiudad`, `_idUsuario`),
  INDEX `fk_ReseñasCiudad_Ciudad1_idx` (`_idCiudad` ASC) VISIBLE,
  INDEX `fk_ReseñasCiudad_Usuario1_idx` (`_idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_ReseñasCiudad_Ciudad1`
    FOREIGN KEY (`_idCiudad`)
    REFERENCES `Tipos_Usuario`.`ciudades` (`idCiudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ReseñasCiudad_Usuario1`
    FOREIGN KEY (`_idUsuario`)
    REFERENCES `Tipos_Usuario`.`usuario_app` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `Tipos_Usuario`.`fotos_ciudad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tipos_Usuario`.`fotos_ciudad` (
  `idFoto` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  `foto` BLOB NOT NULL,
  `_idCiudad` INT NOT NULL,
  PRIMARY KEY (`idFoto`, `_idCiudad`),
  INDEX `fk_FotosCiudad_Ciudad1_idx` (`_idCiudad` ASC) VISIBLE,
  CONSTRAINT `fk_FotosCiudad_Ciudad1`
    FOREIGN KEY (`_idCiudad`)
    REFERENCES `Tipos_Usuario`.`ciudades` (`idCiudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `Tipos_Usuario`.`personajes_importantes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tipos_Usuario`.`personajes_importantes` (
  `idPersonajes` INT NOT NULL AUTO_INCREMENT,
  `_idCiudad` INT NOT NULL,
  `nombre` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL,
  `fechaNacimiento` DATE NOT NULL,
  `fechaFallecimiento` DATE NOT NULL,
  `descripcion` VARCHAR(100) NOT NULL,
  `foto` BLOB NULL,
  PRIMARY KEY (`idPersonajes`, `_idCiudad`),
  INDEX `fk_PersonajesImportantes_Ciudad1_idx` (`_idCiudad` ASC) VISIBLE,
  CONSTRAINT `fk_PersonajesImportantes_Ciudad1`
    FOREIGN KEY (`_idCiudad`)
    REFERENCES `Tipos_Usuario`.`ciudades` (`idCiudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `Tipos_Usuario`.`platillos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tipos_Usuario`.`platillos` (
  `idPlatillos` INT NOT NULL AUTO_INCREMENT,
  `_idCiudad` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `imagen` BLOB NOT NULL,
  PRIMARY KEY (`idPlatillos`, `_idCiudad`),
  INDEX `fk_Platillos_Ciudad1_idx` (`_idCiudad` ASC) VISIBLE,
  CONSTRAINT `fk_Platillos_Ciudad1`
    FOREIGN KEY (`_idCiudad`)
    REFERENCES `Tipos_Usuario`.`ciudades` (`idCiudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;



-- -----------------------------------------------------
-- Table `Tipos_Usuario`.`entradas_usuario_agenda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tipos_Usuario`.`entradas_usuario_agenda` (
  `idEntrada` INT NOT NULL AUTO_INCREMENT,
  `_idUsuario` INT NOT NULL,
  `_idCiudad` INT NOT NULL,
  `_idTransporte` INT NOT NULL,
  `fechaVisita` DATE NULL,
  `hora` TIME NULL,
  PRIMARY KEY (`idEntrada`, `_idUsuario`, `_idCiudad`, `_idTransporte`),
  INDEX `fk_Usuario_has_Ciudad_Ciudad1_idx` (`_idCiudad` ASC) VISIBLE,
  INDEX `fk_Usuario_has_Ciudad_Usuario1_idx` (`_idUsuario` ASC) VISIBLE,
  INDEX `fk_UsuarioPorVisitarCiudad_EstablecimientoPro1_idx` (`_idTransporte` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_has_Ciudad_Usuario1`
    FOREIGN KEY (`_idUsuario`)
    REFERENCES `Tipos_Usuario`.`usuario_app` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_has_Ciudad_Ciudad1`
    FOREIGN KEY (`_idCiudad`)
    REFERENCES `Tipos_Usuario`.`ciudades` (`idCiudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_UsuarioPorVisitarCiudad_EstablecimientoPro1`
    FOREIGN KEY (`_idTransporte`)
    REFERENCES `Tipos_Usuario`.`establecimiento_pro` (`_idEstablecimiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Tipos_Usuario`.`tipo_turismo_ciudad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tipos_Usuario`.`tipo_turismo_ciudad` (
  `_idCiudad` INT NOT NULL,
  `_idTiposTurismo` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`_idCiudad`, `_idTiposTurismo`),
  INDEX `fk_Ciudad_has_TiposTurismo_TiposTurismo1_idx` (`_idTiposTurismo` ASC) VISIBLE,
  INDEX `fk_Ciudad_has_TiposTurismo_Ciudad1_idx` (`_idCiudad` ASC) VISIBLE,
  CONSTRAINT `fk_Ciudad_has_TiposTurismo_Ciudad1`
    FOREIGN KEY (`_idCiudad`)
    REFERENCES `Tipos_Usuario`.`ciudades` (`idCiudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ciudad_has_TiposTurismo_TiposTurismo1`
    FOREIGN KEY (`_idTiposTurismo`)
    REFERENCES `Tipos_Usuario`.`tipos_turismo` (`idTiposTurismo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `Tipos_Usuario`.`salidas_transporte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tipos_Usuario`.`salidas_transporte` (
  `idSalidasTransporte` INT NOT NULL AUTO_INCREMENT,
  `_idTransporte` INT NOT NULL,
  `_idCiudadDestino` INT NOT NULL,
  `dia` VARCHAR(2) NOT NULL,
  `hora` TIME NOT NULL,
  `duracionViaje` TINYINT(2) NULL,
  PRIMARY KEY (`idSalidasTransporte`, `_idTransporte`, `_idCiudadDestino`),
  INDEX `fk_SalidasTransporte_EstablecimientoPro1_idx` (`_idTransporte` ASC) VISIBLE,
  INDEX `fk_SalidasTransporte_Ciudad1_idx` (`_idCiudadDestino` ASC) VISIBLE,
  CONSTRAINT `fk_SalidasTransporte_EstablecimientoPro1`
    FOREIGN KEY (`_idTransporte`)
    REFERENCES `Tipos_Usuario`.`establecimiento_pro` (`_idEstablecimiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SalidasTransporte_Ciudad1`
    FOREIGN KEY (`_idCiudadDestino`)
    REFERENCES `Tipos_Usuario`.`ciudades` (`idCiudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Tipos_Usuario`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tipos_Usuario`.`usuarios` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `tipoUsuario` VARCHAR(2) NOT NULL DEFAULT 'UA',
  PRIMARY KEY (`idUsuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Tipos_Usuario`.`notas_ciudad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tipos_Usuario`.`notas_ciudad` (
  `idNotaCiudad` INT NOT NULL AUTO_INCREMENT,
  `_idCiudad` INT NOT NULL,
  `titulo` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(300) NULL,
  PRIMARY KEY (`idNotaCiudad`, `_idCiudad`),
  INDEX `fk_NotasCiudad_Ciudad1_idx` (`_idCiudad` ASC) VISIBLE,
  CONSTRAINT `fk_NotasCiudad_Ciudad1`
    FOREIGN KEY (`_idCiudad`)
    REFERENCES `Tipos_Usuario`.`ciudades` (`idCiudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `Tipos_Usuario`.`zonas_turisticas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tipos_Usuario`.`zonas_turisticas` (
  `idZonaTuristica` INT NOT NULL AUTO_INCREMENT,
  `_idCiudad` INT NOT NULL,
  `nombre` VARCHAR(50) NOT NULL,
  `tipoZona` CHAR(1) NOT NULL,
  `descripcion` VARCHAR(100) NOT NULL,
  `foto` BLOB NOT NULL,
  PRIMARY KEY (`idZonaTuristica`, `_idCiudad`),
  INDEX `fk_zonas_turisticas_ciudades1_idx` (`_idCiudad` ASC) VISIBLE,
  CONSTRAINT `fk_zonas_turisticas_ciudades1`
    FOREIGN KEY (`_idCiudad`)
    REFERENCES `Tipos_Usuario`.`ciudades` (`idCiudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `Tipos_Usuario`.`origen_transporte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tipos_Usuario`.`origen_transporte` (
  `identificador` INT NOT NULL AUTO_INCREMENT,
  `_idCiudad` INT NOT NULL,
  `_idTransporte` INT NOT NULL,
  PRIMARY KEY (`identificador`, `_idCiudad`, `_idTransporte`),
  INDEX `fk_ciudades_has_establecimiento_pro_establecimiento_pro1_idx` (`_idTransporte` ASC) VISIBLE,
  INDEX `fk_ciudades_has_establecimiento_pro_ciudades1_idx` (`_idCiudad` ASC) VISIBLE,
  CONSTRAINT `fk_ciudades_has_establecimiento_pro_ciudades1`
    FOREIGN KEY (`_idCiudad`)
    REFERENCES `Tipos_Usuario`.`ciudades` (`idCiudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ciudades_has_establecimiento_pro_establecimiento_pro1`
    FOREIGN KEY (`_idTransporte`)
    REFERENCES `Tipos_Usuario`.`establecimiento_pro` (`_idEstablecimiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
