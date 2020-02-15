-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 15-02-2020 a las 02:08:42
-- Versión del servidor: 5.6.12-log
-- Versión de PHP: 5.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `macanadb`
--
CREATE DATABASE IF NOT EXISTS `macanadb` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `macanadb`;

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `listclimatologico`(iduser int)
    COMMENT 'Procedimiento que lista los cambios climatologicos'
BEGIN
   select id, fecha,nubosidad, pluviometria, observaciones, idresponsable
   from estadoclimatologico
   order by id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listPermisosAsignados`(vidrol int)
    COMMENT 'Procedimiento que lista los menus asignados a un rol'
BEGIN
   select idrol, idmenu
   from menu_rol
   where idrol = vidrol;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listrol`(iduser int)
    COMMENT 'Procedimiento que lista los roles de un determinado usuario'
BEGIN
   select id,nombre as nombre_rol,descripcion 
   from rol
   order by nombre;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listuser`(IN `iduser` INT)
    DETERMINISTIC
    COMMENT 'Procedimiento que lista los usuarios'
BEGIN
   
	SELECT us.id, 
           us.primer_nombre as primer_nombre, 
           us.segundo_nombre as segundo_nombre, 
           us.primer_apellido as primer_apellido,
		   us.segundo_apellido as segundo_apellido,
           us.cedula as cedula,
           us.correo as correo,
           us.celular as celular, 
           us.foto as foto,
		   us.foto as foto_copia_ruta_original,
		   us.usuario as usuario, 
		   r.nombre as rol_nombre,
           r.id as rol_id,
	       us.descripcion as descripcion
	FROM usuario as us
	INNER JOIN rol as r on r.id = us.rol
	ORDER BY us.primer_nombre;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `loadallmenu`()
    COMMENT 'Procedimiento que lista todos los menus del sistema'
BEGIN
   
	select m.id,m.nombre,m.codigo,m.padre as codpadre,m2.nombre as nombrepadre,m.prioridad, m.icono as icono
	from menu as m
	left JOIN menu as m2 on m.padre = m2.id	
	order by m.prioridad;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `loadapage`(IN `vpage` VARCHAR(2000), IN `vrol` INT)
    COMMENT 'Procedimiento que lista los menus'
BEGIN
   
	select m.codigo
	from menu as m 	
	inner join menu_rol as mr on mr.idmenu = m.id
	where mr.idrol = vrol AND m.codigo = vpage;	

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `loadmenu`(IN `rol` INT)
    COMMENT 'Procedimiento que lista los menus de un determinado rol'
BEGIN
   
	select m.id,m.nombre,m.codigo,m.padre as codpadre,m2.nombre as nombrepadre,mr.idrol,m.prioridad, m.icono as icono
	from menu as m
	left JOIN menu as m2 on m.padre = m2.id
	LEFT join menu_rol as mr on mr.idmenu = m.id
	where (mr.idrol = rol OR (m.padre = -1 AND (mr.idrol = rol OR mr.idrol IS NULL)))
	order by m.prioridad;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `loadrol`(IN `idfilter` INT)
    COMMENT 'Procedimiento que lista los roles'
BEGIN
 
	IF idfilter > -1 THEN
	
		select id,nombre
		from rol
		ORDER BY nombre;
		
   ELSE	
	
		select id,nombre
		from rol
		ORDER BY nombre;
	
   END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `login`(IN `usu` VARCHAR(50), IN `pass` VARCHAR(50))
    COMMENT 'Procedimiento que valida las credenciales de un usuairo'
BEGIN
   select u.usuario,u.primer_nombre,u.primer_apellido,u.rol,u.id,r.nombre as rol_nombre,u.foto
   from usuario as u
   inner join rol as r on u.rol = r.id
   where password=pass and usuario=usu;		
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `searchrol`(idrol int)
    COMMENT 'Procedimiento que carga la informacion de un rol'
BEGIN
 
	
	select id,nombre,descripcion
	from rol
	where id = idrol;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `searchuser`(vid int)
    COMMENT 'Procedimiento que carga la informacion de un usuario'
BEGIN
 	
	SELECT id, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, 
	usuario, rol, descripcion
	FROM usuario
	where id = vid;	
	
END$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `deleteclimatologico`(vid INT) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que elimina un estado climatologico'
BEGIN 
    DECLARE res INT DEFAULT 0;
    DELETE FROM estadoclimatologico WHERE id = vid;
SET res = 1;
	RETURN res;

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `deleterol`(cod INT) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que elimina un rol'
BEGIN
	DECLARE res INT default 0;	
    delete from rol where id = cod;
	SET res = 1;
	RETURN res;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `deleteuser`(vid INT) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que elimina un usuario'
BEGIN 
    DECLARE res INT DEFAULT 0;
    DELETE FROM usuario WHERE id = vid;
SET res = 1;
	RETURN res;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `saveclimatologico`(id int, 
                          vfecha varchar(20), 
                          vnubosidad varchar(20), 
                          vpluviometria int, 
                          vobservaciones varchar(2000), 
						  vidresponsable int) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que almacena un estado climatologico'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select fecha from estadoclimatologico where fecha=vfecha)
		THEN
			insert into estadoclimatologico(fecha, 	nubosidad,pluviometria,	observaciones,	idresponsable)
			VALUES (vfecha,vnubosidad,vpluviometria,vobservaciones,
                                vidresponsable);
			set res = 1;
			
				
			
		END IF;

	RETURN res;
	
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `saverol`(cod INT,nom varchar(50),des varchar(2000)) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que almacena un rol'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select nombre from rol where nombre=nom)
		THEN
			insert into rol(nombre,descripcion) values(nom,des);	
			set res = 1;							
			
		END IF;

	RETURN res;
	

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `saveuser`(`id` INT, `vfirstname` VARCHAR(50), `vsecondname` VARCHAR(50), `vfirstlastname` VARCHAR(50), `vsecondlastname` VARCHAR(50), `vcedula` VARCHAR(50), `vcorreo` VARCHAR(50), `vcelular` VARCHAR(50), `vfoto` VARCHAR(200), `vuser` VARCHAR(50), `vpass` VARCHAR(50), `vrol` INT, `vdescription` VARCHAR(50)) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que almacena un usuario'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select usuario from usuario where usuario=vuser)
		THEN
			insert into usuario(primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, 
                                            cedula,correo,celular,foto,
					   usuario, password, rol,descripcion)
			VALUES (vfirstname,vsecondname,vfirstlastname,vsecondlastname,
                                vcedula,vcorreo,vcelular,vfoto,
                                vuser,vpass,vrol,vdescription);
			set res = 1;
			
				
			
		END IF;

	RETURN res;
	
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `updateclimatologico`(`vid` INT, `vfecha` VARCHAR(20), `vnubosidad` VARCHAR(20), `vpluviometria` INT, `vobservaciones` VARCHAR(2000), `vidresponsable` INT) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que modifica un estado climatologico'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select fecha from estadoclimatologico where fecha=vfecha and id<>vid)
		THEN

UPDATE estadoclimatologico
   SET  fecha = vfecha, nubosidad = vnubosidad, pluviometria = vpluviometria, observaciones = vobservaciones, idresponsable = vidresponsable
 WHERE id=vid;

			set res=1;
								
			
		END IF;

	RETURN res;
	

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `updatepassword`(vid int, vpass varchar(50)) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que actualiza el password del usuario'
BEGIN 
    DECLARE res INT DEFAULT 0;
    

            UPDATE usuario
            SET  password=vpass
            WHERE id=vid;

	    set res=1;
								

	RETURN res;
	

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `updatepermission`(vid integer, vpermission varchar(2000)) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que actualiza los permisos de un rol'
BEGIN 
    DECLARE res INT DEFAULT 0;
    /*Variable que contendra el permiso a almacenar*/
    DECLARE permiso varchar(50) DEFAULT '';    

    /*Se borra todos los permisos existentes del usuario*/
    delete from menu_rol where idrol = vid;
    
    WHILE (LOCATE(',', vpermission) > 0) DO
        /*Se saca el primer campo separado por coma del varchar*/
    	SET permiso = ELT(1, vpermission);
        /*Se elimina ese primer valor y se reemplaza en la cadena*/
    	SET vpermission = SUBSTRING(vpermission, LOCATE(',',vpermission) + 1);
        /*Se almacena en la tabla, siempre y cuando tenga un dato para almacenar*/
		IF permiso <> ',' THEN	
    		INSERT INTO menu_rol(idrol, idmenu) VALUES (vid, permiso);
		END IF;
    END WHILE;

    SET res = 1;

    RETURN res;	
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `updaterol`(cod INT,nom varchar(50),des varchar(2000)) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que modifica un rol'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select nombre from rol where nombre=nom and id<>cod)
		THEN
			update rol set nombre = nom,descripcion = des where id = cod;		
			set res=1;
														
		END IF;

	RETURN res;
	

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `updateuser`(`vid` INT, `vfirstname` VARCHAR(50), `vsecondname` VARCHAR(50), `vfirstlastname` VARCHAR(50), `vsecondlastname` VARCHAR(50), `vcedula` VARCHAR(50), `vcorreo` VARCHAR(50), `vcelular` VARCHAR(50), `vfoto` VARCHAR(200), `vuser` VARCHAR(50), `vrol` INT, `vdescription` VARCHAR(50)) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que modifica un usuario'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select usuario from usuario where usuario=vuser and id<>vid)
		THEN

UPDATE usuario
   SET  primer_nombre=vfirstname, segundo_nombre=vsecondname, primer_apellido=vfirstlastname, segundo_apellido=vsecondlastname, 
        cedula = vcedula, correo = vcorreo, celular = vcelular, foto = vfoto,
        usuario=vuser, rol=vrol, descripcion=vdescription
 WHERE id=vid;

			set res=1;
								
			
		END IF;

	RETURN res;
	

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estadoclimatologico`
--

CREATE TABLE IF NOT EXISTS `estadoclimatologico` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` varchar(20) DEFAULT NULL,
  `nubosidad` varchar(20) DEFAULT NULL,
  `pluviometria` int(11) DEFAULT NULL,
  `observaciones` varchar(2000) CHARACTER SET utf8 DEFAULT NULL,
  `idresponsable` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Volcado de datos para la tabla `estadoclimatologico`
--

INSERT INTO `estadoclimatologico` (`id`, `fecha`, `nubosidad`, `pluviometria`, `observaciones`, `idresponsable`) VALUES
(5, '2020-02-02', '444', 4444, 'Este es el registro final', 0),
(6, '2020-02-06', 'fsdf', 2323, '23432423', 1),
(7, '2020-02-05', '23423', 342343, '', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menu`
--

CREATE TABLE IF NOT EXISTS `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) DEFAULT NULL,
  `codigo` varchar(2000) DEFAULT NULL,
  `padre` int(11) DEFAULT NULL,
  `descripcion` varchar(2000) DEFAULT NULL,
  `prioridad` int(11) DEFAULT NULL,
  `icono` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=18 ;

--
-- Volcado de datos para la tabla `menu`
--

INSERT INTO `menu` (`id`, `nombre`, `codigo`, `padre`, `descripcion`, `prioridad`, `icono`) VALUES
(1, 'Inicio', '/master-page', -1, NULL, 1, 'home'),
(2, 'Usuarios', '/usuarios', -1, NULL, 2, 'person'),
(3, 'Roles', '/roles', -1, NULL, 3, 'person'),
(4, 'Permisos', '/permisos', -1, NULL, 4, 'person'),
(5, 'Estado climatologico', '/estado-climatologico', -1, NULL, 5, 'person'),
(6, 'Rotacion', '/lote', -1, NULL, 6, 'person'),
(7, 'Potreros', '/potrero', -1, NULL, 7, 'person'),
(8, 'Aforos', '/aforos', -1, NULL, 8, 'person'),
(9, 'Vacas', '/vacas', -1, NULL, 9, 'person'),
(10, 'Cambio climatico', '/cambio-climatico', -1, NULL, 10, 'person'),
(11, 'Pluviosidad', '/pluviosidad', -1, NULL, 11, 'person'),
(12, 'Plaga', '/plaga', -1, NULL, 12, 'person'),
(13, 'Fertilizacion', '/fertilizacion', -1, NULL, 13, 'person'),
(14, 'Reportes', '/reportes', -1, NULL, 14, 'person'),
(15, 'Plan de manejo', '/plan-manejo', -1, NULL, 15, 'person'),
(16, 'Analisis', '/analisis', -1, NULL, 16, 'person'),
(17, 'Informe', '/informe', -1, NULL, 16, 'person');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menu_rol`
--

CREATE TABLE IF NOT EXISTS `menu_rol` (
  `idrol` int(11) DEFAULT NULL,
  `idmenu` int(11) DEFAULT NULL,
  KEY `menu_usuario_idmenu_fkey` (`idmenu`),
  KEY `menu_usuario_idrol_fkey` (`idrol`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `menu_rol`
--

INSERT INTO `menu_rol` (`idrol`, `idmenu`) VALUES
(93, 1),
(93, 3),
(93, 5),
(94, 2),
(94, 4),
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(1, 11),
(1, 12),
(1, 13),
(1, 14),
(1, 15),
(1, 16),
(1, 17),
(85, 1),
(85, 2),
(85, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE IF NOT EXISTS `rol` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `descripcion` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=95 ;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`id`, `nombre`, `descripcion`) VALUES
(1, 'administrador', 'Super administrador del sistema, tiene todos los permisos'),
(85, 'root', 'Tiene todos los permisos, excepto configuracion de roles, usuarios y permisos de usuario'),
(93, 'Rol de prueba 1', 'Este rol es de prueba'),
(94, 'Rol modificado', 'Este rol se modifico');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE IF NOT EXISTS `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `primer_nombre` varchar(50) DEFAULT NULL,
  `segundo_nombre` varchar(50) DEFAULT NULL,
  `primer_apellido` varchar(50) DEFAULT NULL,
  `segundo_apellido` varchar(50) DEFAULT NULL,
  `cedula` varchar(20) DEFAULT NULL,
  `correo` varchar(50) DEFAULT NULL,
  `celular` varchar(20) DEFAULT NULL,
  `foto` varchar(200) DEFAULT NULL,
  `usuario` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `rol` int(11) DEFAULT NULL,
  `descripcion` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `usuario_rol_fkey` (`rol`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=37 ;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `primer_nombre`, `segundo_nombre`, `primer_apellido`, `segundo_apellido`, `cedula`, `correo`, `celular`, `foto`, `usuario`, `password`, `rol`, `descripcion`) VALUES
(1, 'Johnny', 'Alexander', 'Salazar', 'Cardona', '1053802815', 'alexander9052@gmail.com', '3217501560', 'Resource/Images/Users/johnny9052_1581479770333.jpg', 'johnny9052', 'df5be1862ca6bf8589cf799004248e87', 1, ''),
(2, 'David', '', 'Angarita', '', '423423423', 'davidangaritag@gmail.com', 'null', '', 'davidangaritag', '202cb962ac59075b964b07152d234b70', 85, 'es una loquita'),
(36, 'usuario de prueba', '', 'macana', '', '12345', 'prueba@correo.com', '231654', '', 'prueba', '202cb962ac59075b964b07152d234b70', 85, 'undefined');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `menu_rol`
--
ALTER TABLE `menu_rol`
  ADD CONSTRAINT `menu_rol_ibfk_1` FOREIGN KEY (`idrol`) REFERENCES `rol` (`id`),
  ADD CONSTRAINT `menu_rol_ibfk_2` FOREIGN KEY (`idmenu`) REFERENCES `menu` (`id`);

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`rol`) REFERENCES `rol` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
