-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 21-02-2018 a las 22:00:10
-- Versión del servidor: 5.6.12-log
-- Versión de PHP: 5.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `exaudio1_exaudi`
--
CREATE DATABASE IF NOT EXISTS `exaudio1_exaudi` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `exaudio1_exaudi`;

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`exaudio1`@`localhost` PROCEDURE `listnoticia`(IN `iduser` INT)
    COMMENT 'Procedimiento que lista los roles de un determinado usuario'
BEGIN
   select id,titulo as titulo_noticia,descripcion ,fecha,foto as ruta_foto,video as ruta_video
   from noticia
   order by fecha desc;
END$$

CREATE DEFINER=`exaudio1`@`localhost` PROCEDURE `listrol`(iduser int)
    COMMENT 'Procedimiento que lista los roles de un determinado usuario'
BEGIN
   select id,nombre as nombre_rol,descripcion 
   from rol
   order by nombre;
END$$

CREATE DEFINER=`exaudio1`@`localhost` PROCEDURE `listuser`(iduser int)
    COMMENT 'Procedimiento que lista los usuarios'
BEGIN
   
	SELECT us.id, us.primer_nombre as primer_nombre, us.primer_apellido as primer_apellido, us.usuario as nickname, r.nombre as rol, 
	       us.descripcion as descripcion
	FROM usuario as us
	INNER JOIN rol as r on r.id = us.rol
	ORDER BY us.primer_nombre;

END$$

CREATE DEFINER=`exaudio1`@`localhost` PROCEDURE `loadallmenu`()
    COMMENT 'Procedimiento que lista todos los menus del sistema'
BEGIN
   
	select m.id,m.nombre,m.codigo,m.padre as codpadre,m2.nombre as nombrepadre,m.prioridad
	from menu as m
	left JOIN menu as m2 on m.padre = m2.id	
	order by m.prioridad;

END$$

CREATE DEFINER=`exaudio1`@`localhost` PROCEDURE `loadapage`(IN `vpage` VARCHAR(2000), IN `vrol` INT)
    COMMENT 'Procedimiento que lista los menus'
BEGIN
   
	select m.codigo
	from menu as m 	
	inner join menu_rol as mr on mr.idmenu = m.id
	where mr.idrol = vrol AND m.codigo = vpage;	

END$$

CREATE DEFINER=`exaudio1`@`localhost` PROCEDURE `loadmenu`(IN `rol` INT)
    COMMENT 'Procedimiento que lista los menus de un determinado rol'
BEGIN
   
	select m.id,m.nombre,m.codigo,m.padre as codpadre,m2.nombre as nombrepadre,mr.idrol,m.prioridad, m.icono as icono
	from menu as m
	left JOIN menu as m2 on m.padre = m2.id
	LEFT join menu_rol as mr on mr.idmenu = m.id
	where (mr.idrol = rol OR (m.padre = -1 AND (mr.idrol = rol OR mr.idrol IS NULL)))
	order by m.prioridad;
END$$

CREATE DEFINER=`exaudio1`@`localhost` PROCEDURE `loadrol`(IN `idfilter` INT)
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

CREATE DEFINER=`exaudio1`@`localhost` PROCEDURE `login`(IN `usu` VARCHAR(50), IN `pass` VARCHAR(50))
    COMMENT 'Procedimiento que valida las credenciales de un usuairo'
BEGIN
   select u.usuario,u.primer_nombre,u.primer_apellido,u.rol,u.id,r.nombre as rol_nombre
   from usuario as u
   inner join rol as r on u.rol = r.id
   where password=pass and usuario=usu;		
END$$

CREATE DEFINER=`exaudio1`@`localhost` PROCEDURE `searchnoticia`(idnoticia int)
    COMMENT 'Procedimiento que carga la informacion de una noticia'
BEGIN
 
	
	select id,titulo,descripcion, fecha,foto,video
	from noticia
	where id = idnoticia;
	
END$$

CREATE DEFINER=`exaudio1`@`localhost` PROCEDURE `searchrol`(idrol int)
    COMMENT 'Procedimiento que carga la informacion de un rol'
BEGIN
 
	
	select id,nombre,descripcion
	from rol
	where id = idrol;
	
END$$

CREATE DEFINER=`exaudio1`@`localhost` PROCEDURE `searchuser`(vid int)
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
CREATE DEFINER=`exaudio1`@`localhost` FUNCTION `deletenoticia`(vid INT) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que elimina una noticia'
BEGIN 
    DECLARE res INT DEFAULT 0;
    DELETE FROM noticia WHERE id = vid;
SET res = 1;
	RETURN res;
END$$

CREATE DEFINER=`exaudio1`@`localhost` FUNCTION `deleterol`(cod INT) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que elimina un rol'
BEGIN
	DECLARE res INT default 0;	
    delete from rol where id = cod;
	SET res = 1;
	RETURN res;
END$$

CREATE DEFINER=`exaudio1`@`localhost` FUNCTION `deleteuser`(vid INT) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que elimina un usuario'
BEGIN 
    DECLARE res INT DEFAULT 0;
    DELETE FROM usuario WHERE id = vid;
SET res = 1;
	RETURN res;
END$$

CREATE DEFINER=`exaudio1`@`localhost` FUNCTION `savenoticia`(`cod` INT, `titl` VARCHAR(200), `des` VARCHAR(10000), `fech` VARCHAR(20), `phot` VARCHAR(2000), `vid` VARCHAR(2000)) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que almacena una noticia'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select titulo from noticia where titulo=titl)
		THEN
			insert into noticia(titulo,descripcion,fecha,foto,video) values(titl,des,fech,phot,vid);	
			set res = 1;							
			
		END IF;

	RETURN res;
	
END$$

CREATE DEFINER=`exaudio1`@`localhost` FUNCTION `saverol`(cod INT,nom varchar(50),des varchar(2000)) RETURNS int(1)
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

CREATE DEFINER=`exaudio1`@`localhost` FUNCTION `saveuser`(id int, vfirstname varchar(50), vsecondname varchar(50), vfirstlastname varchar(50), vsecondlastname varchar(50), vuser varchar(50), vpass varchar(50), vrol int, vdescription varchar(50)) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que almacena un rol'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select usuario from usuario where usuario=vuser)
		THEN
			insert into usuario(primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, 
					   usuario, password, rol,descripcion)
			VALUES (vfirstname,vsecondname,vfirstlastname,vsecondlastname,vuser,vpass,vrol,vdescription);
			set res = 1;
			
				
			
		END IF;

	RETURN res;
	
	

END$$

CREATE DEFINER=`exaudio1`@`localhost` FUNCTION `updatenoticia`(`cod` INT, `titl` VARCHAR(200), `des` VARCHAR(10000), `fech` VARCHAR(20), `phot` VARCHAR(2000), `vid` VARCHAR(2000)) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que modifica una noticia'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select titulo from noticia where titulo=titl and id<>cod)
		THEN
			update noticia set titulo = titl,descripcion = des, fecha = fech,foto = phot, video = vid
                        where id = cod;		
			set res=1;
														
		END IF;

	RETURN res;
	

END$$

CREATE DEFINER=`exaudio1`@`localhost` FUNCTION `updatepermission`(vid integer, vpermission varchar(2000)) RETURNS int(1)
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

CREATE DEFINER=`exaudio1`@`localhost` FUNCTION `updaterol`(cod INT,nom varchar(50),des varchar(2000)) RETURNS int(1)
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

CREATE DEFINER=`exaudio1`@`localhost` FUNCTION `updateuser`(vid int, vfirstname varchar(50), vsecondname varchar(50), vfirstlastname varchar(50), vsecondlastname varchar(50), vuser varchar(50), vpass varchar(50), vrol int, vdescription varchar(50)) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que modifica un rol'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select usuario from usuario where usuario=vuser and id<>vid)
		THEN

UPDATE usuario
   SET  primer_nombre=vfirstname, segundo_nombre=vsecondname, primer_apellido=vfirstlastname, segundo_apellido=vsecondlastname, 
       usuario=vuser, password= vpass, rol=vrol, descripcion=vdescription
 WHERE id=vid;

			
			set res=1;
								
			
		END IF;

	RETURN res;
	

END$$

DELIMITER ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Volcado de datos para la tabla `menu`
--

INSERT INTO `menu` (`id`, `nombre`, `codigo`, `padre`, `descripcion`, `prioridad`, `icono`) VALUES
(1, 'Parametrizacion', NULL, -1, NULL, 4, 'fa-gear'),
(2, 'Configuracion', NULL, -1, NULL, 3, 'fa-group'),
(3, 'Roles', 'Configuration/Rol', 2, NULL, 1, ''),
(4, 'Usuarios', 'Configuration/User', 2, NULL, 2, ''),
(5, 'Inicio', NULL, -1, NULL, 1, 'fa-home'),
(6, 'Permisos', 'Configuration/Permission', 2, NULL, 3, ''),
(7, 'Noticias', 'Parameterized/New', 1, NULL, 1, '');

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
(85, 3),
(85, 6),
(1, 3),
(1, 4),
(1, 6),
(1, 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `noticia`
--

CREATE TABLE IF NOT EXISTS `noticia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(200) DEFAULT NULL,
  `descripcion` varchar(10000) DEFAULT NULL,
  `fecha` varchar(20) DEFAULT NULL,
  `foto` varchar(2000) DEFAULT NULL,
  `video` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=39 ;

--
-- Volcado de datos para la tabla `noticia`
--

INSERT INTO `noticia` (`id`, `titulo`, `descripcion`, `fecha`, `foto`, `video`) VALUES
(30, 'Noticia numero 1', 'Esta es una prueba del primer registro', '02/21/2018', 'System/Resource/Images/News/Noticia numero 120180219021557.jpg', ''),
(31, 'Noticia numero 2', 'jkkjkjkj', '02/22/2018', '', ''),
(32, 'Noticia numero 3', 'kjsdkjasda', '02/20/2018', '', ''),
(33, 'Noticia numero 4', 'djasjsak', '02/23/2018', '', ''),
(34, 'Noticia numero 5', 'jdsads', '02/18/2018', '', ''),
(35, 'Noticia numero 6', 'djajdka', '02/28/2018', '', ''),
(36, 'Mau mau fue coronada como la gatita mas hermosa', 'Mau mau maua mua maua maua mau', '02/19/2018', 'System/Resource/Images/News/Mau mau fue coronada como la gatita mas hermosa20180219181247.jpg', ''),
(37, 'RECONOCIMIENTO DEL FAMILY FIRM INSTITUTE A GUILLERMO SALAZAR EN EL MARCO DE LA CONFERENCIA GLOBAL 2017', 'Guillermo Salazar, Director de Exaudi Family Busines Consulting, recibiÃ³ el reconocimiento como Fellow del Family Firm Institute (FFI) en el marco de la Conferencia Global 2017, que se celebrÃ³ del 25 al 28 de Octubre en la ciudad de Chicago. AdemÃ¡s, fue acreditado como Advanced Certificate in Family Business Advising (ACFBA). El estatus de Fellow del Family Firm Institute es un reconocimiento que emite esta prestigiosa instituciÃ³n a personas por realizar un programa de estudios avanzados en asesorÃ­a de empresas familiares como parte del Family Firm Instituteâ€™s Global Education Network (GEN), y presentarlo en conferencias anuales y/o publicaciones del FFI, asÃ­ como tambiÃ©n ser miembro del FFI por mÃ¡s de 10 aÃ±os. \n\nSegÃºn palabras de Judy Green, Presidenta del Family Firm Institute â€œcon este reconocimiento como Fellow del FFI, Guillermo Salazar ha consolidado sus conocimientos y capacidad diagnÃ³stica de las necesidades de las familias propietarias de empresas, de los mÃºltiples roles que cumplen tanto miembros de familias empresarias como de las personas que hacen vida dentro de las empresas familiares, no vinculadas a las familiasâ€. Los expertos que son reconocidos con el estatus de Fellow cuentan ademÃ¡s con acceso a las mÃ¡s innovadoras herramientas de investigaciÃ³n, a informaciÃ³n de Ãºltima tendencia en psicologÃ­a, finanzas, leyes y gerencia, orientados a las empresas familiares, asÃ­ como tambiÃ©n a una red de apoyo para la investigaciÃ³n y colaboraciÃ³n.\n\nLa personas acreditadas con el Advanced Certicate Family Business Advisor (ACFBA) que otorga el Global Education Network (GEN) del FFI, cuentan con un nivel profundo de conocimientos y experiencia necesaria para generar valor a los propietarios de empresas y sus patrimonios. Los asesores con esta distinciÃ³n estan en la capacidad de implementar los procesos de consultorÃ­a alineadas con las mejores prÃ¡cticas y los mÃ¡s altos estÃ¡ndares, establecidos por FFI. Esta certificaciÃ³n tiene como objetivo dotar de conocimientos, desarrollar habilidades y brindar herramientas que optimicen la efectividad de los consultores y asesores de empresas familiares. \n\nEl Family Firm Institute (www.ffi.org), es una organizaciÃ³n internacional que agrupa cerca de 1800 miembros y organizaciones en mÃ¡s de 80 paÃ­ses, dedicada a la formaciÃ³n y creaciÃ³n de espacios de networking para asesores y consultores de familias empresarias, formadores e investigadores de las empresas familiares. El FFI se dedica a la generaciÃ³n de conocimiento, y el desarrollo de metodologÃ­as y tendencias en el campo de las empresas familiares y sus patrimonios. \n\nLas empresas familiares son la forma de negocio dominante en el mundo, y es por ello que contribuyen de manera Ãºnica al tejido social y a la economÃ­a de las comunidades. El Family Firm Institute busca incrementar el conocimiento acerca de las empresas familiares como protagonistas del crecimiento econÃ³mico y la prosperidad.\n\nEFBC, Houston 15 de Novimebre de 2007\nSolicite mayor informaciÃ³n aquÃ­', '11/15/2017', 'System/Resource/Images/News/RECONOCIMIENTO DEL FAMILY FIRM INSTITUTE A GUILLERMO SALAZAR EN EL MARCO DE LA CONFERENCIA GLOBAL 201720180221202342.jpg', 'https://www.youtube.com/watch?v=ADrnNtmrTAw'),
(38, 'aaaaa', 'bbbbb', '02/21/2018', '', 'ccccccc');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE IF NOT EXISTS `rol` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `descripcion` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=86 ;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`id`, `nombre`, `descripcion`) VALUES
(1, 'administrador', 'Super administrador del sistema, tiene todos los permisos'),
(85, 'exaudio1', 'Tiene todos los permisos, excepto configuracion de roles, usuarios y permisos de usuario');

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
  `usuario` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `rol` int(11) DEFAULT NULL,
  `descripcion` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `usuario_rol_fkey` (`rol`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `primer_nombre`, `segundo_nombre`, `primer_apellido`, `segundo_apellido`, `usuario`, `password`, `rol`, `descripcion`) VALUES
(1, 'Johnny', 'Alexander', 'Salazar', 'Cardona', 'johnny9052', 'df5be1862ca6bf8589cf799004248e87', 1, ''),
(2, 'David', 'Alberto', 'Angarita', 'Garcia', 'David', 'e10adc3949ba59abbe56e057f20f883e', 1, 'Es un gran programador jajajajajaaj');

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
