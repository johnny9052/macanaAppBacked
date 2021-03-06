-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 04-04-2020 a las 20:38:50
-- Versión del servidor: 5.6.12-log
-- Versión de PHP: 5.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `dbdxbar7e6xcvq`
--
CREATE DATABASE IF NOT EXISTS `dbdxbar7e6xcvq` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `dbdxbar7e6xcvq`;

DELIMITER $$
--
-- Procedimientos
--
CREATE  PROCEDURE `listaforo`(iduser int)
    COMMENT 'Procedimiento que lista los aforos'
BEGIN
   select a.id,a.fecha,a.idpotrero,a.pastoalto,a.pastobajo,a.pastomedio,a.lancealto,a.lancemedio,a.lancebajo,a.cantlances,a.pesopastoalto,a.pesopastobajo,a.pesopastomedio,a.cantpasto,
          a.porcentajealtro,a.porcentajemedio,a.porcentajebajo,a.totalmetrocuadrado,a.cantpastopotrero,a.tiempopotrero,a.observaciones,a.idresponsable, p.numero as numeropotrero
   from aforo as a
   inner join potrero as p on p.id = a.idpotrero
   order by id;
END$$

CREATE  PROCEDURE `listaforocsv`(IN `iduser` INT)
    COMMENT 'Procedimiento que lista los aforos'
BEGIN
   select p.numero as numeropotrero, a.fecha,a.pastoalto,a.pastobajo,a.pastomedio,a.lancealto,a.lancemedio,a.lancebajo,a.cantlances,a.pesopastoalto,a.pesopastobajo,a.pesopastomedio,a.cantpasto,
          a.porcentajealtro,a.porcentajemedio,a.porcentajebajo,a.totalmetrocuadrado,a.cantpastopotrero,a.tiempopotrero,a.observaciones
   from aforo as a
   inner join potrero as p on p.id = a.idpotrero
   order by id;
END$$

CREATE  PROCEDURE `listclimatologico`(iduser int)
    COMMENT 'Procedimiento que lista los cambios climatologicos'
BEGIN
   select id, fecha,nubosidad, pluviometria, observaciones, idresponsable
   from estadoclimatologico
   order by id;
END$$

CREATE  PROCEDURE `listPermisosAsignados`(vidrol int)
    COMMENT 'Procedimiento que lista los menus asignados a un rol'
BEGIN
   select idrol, idmenu
   from menu_rol
   where idrol = vidrol;
END$$

CREATE  PROCEDURE `listplandemanejo`(iduser int)
    COMMENT 'Procedimiento que lista los cambios de plan de manejo'
BEGIN
   select id, fecha,nombre,idResponsable,observaciones
   from plandemanejo
   order by id;
END$$

CREATE  PROCEDURE `listpotrero`(IN `iduser` INT)
    COMMENT 'Procedimiento que lista los potreros'
BEGIN
   select p.id as id, p.numero as numero,p.area as area, 
          p.observacion as observacion, p.idrotacion as idrotacion, 
          case 
           when p.estado=1 then 'true'
           else 'false'
          end as estado,
          p.idresponsable as idresponsable, r.cantvacas as 	cantvacas
   from potrero as p 
   inner join rotacion as r on p.idrotacion = r.id
   order by id;
END$$

CREATE  PROCEDURE `listrazavaca`(vid int)
    COMMENT 'Procedimiento que lista las razas'
BEGIN
   select id,nombre,observaciones
   from raza_vaca
   order by id;
END$$

CREATE  PROCEDURE `listrol`(iduser int)
    COMMENT 'Procedimiento que lista los roles de un determinado usuario'
BEGIN
   select id,nombre as nombre_rol,descripcion 
   from rol
   order by nombre;
END$$

CREATE  PROCEDURE `listrotacion`(iduser int)
    COMMENT 'Procedimiento que lista las rotaciones'
BEGIN
   select id,nombre,cantvacas,idresponsable
   from rotacion
   order by id;
END$$

CREATE  PROCEDURE `listsexovaca`(vid int)
    COMMENT 'Procedimiento que lista las rotaciones'
BEGIN
   select id,nombre,observaciones
   from sexo_vaca
   order by id;
END$$

CREATE  PROCEDURE `listtipovaca`(vid int)
    COMMENT 'Procedimiento que lista los tipos de vacas'
BEGIN
   select id,nombre,observaciones
   from tipo_animal
   order by id;
END$$

CREATE  PROCEDURE `listuser`(IN `iduser` INT)
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

CREATE  PROCEDURE `listvaca`(IN `iduser` INT)
    COMMENT 'Procedimiento que lista las vacas'
BEGIN
   select v.id,v.numero,v.nombre,v.idrotacion,v.sexo,v.raza,v.tipoanimal,
          v.edad,v.idresponsable, r.nombre as nombre_rotacion
   from vaca as v inner join rotacion as r on r.id = v.idrotacion
   order by id;
END$$

CREATE  PROCEDURE `loadallmenu`()
    COMMENT 'Procedimiento que lista todos los menus del sistema'
BEGIN
   
	select m.id,m.nombre,m.codigo,m.padre as codpadre,m2.nombre as nombrepadre,m.prioridad, m.icono as icono
	from menu as m
	left JOIN menu as m2 on m.padre = m2.id	
	order by m.prioridad;

END$$

CREATE  PROCEDURE `loadapage`(IN `vpage` VARCHAR(2000), IN `vrol` INT)
    COMMENT 'Procedimiento que lista los menus'
BEGIN
   
	select m.codigo
	from menu as m 	
	inner join menu_rol as mr on mr.idmenu = m.id
	where mr.idrol = vrol AND m.codigo = vpage;	

END$$

CREATE  PROCEDURE `loadmenu`(IN `rol` INT)
    COMMENT 'Procedimiento que lista los menus de un determinado rol'
BEGIN
   
	select m.id,m.nombre,m.codigo,m.padre as codpadre,m2.nombre as nombrepadre,mr.idrol,m.prioridad, m.icono as icono
	from menu as m
	left JOIN menu as m2 on m.padre = m2.id
	LEFT join menu_rol as mr on mr.idmenu = m.id
	where (mr.idrol = rol OR (m.padre = -1 AND (mr.idrol = rol OR mr.idrol IS NULL)))
	order by m.prioridad;
END$$

CREATE  PROCEDURE `loadrol`(IN `idfilter` INT)
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

CREATE  PROCEDURE `login`(IN `usu` VARCHAR(50), IN `pass` VARCHAR(50))
    COMMENT 'Procedimiento que valida las credenciales de un usuairo'
BEGIN
   select u.usuario,u.primer_nombre,u.primer_apellido,u.rol,u.id,r.nombre as rol_nombre,u.foto
   from usuario as u
   inner join rol as r on u.rol = r.id
   where password=pass and usuario=usu;		
END$$

CREATE  PROCEDURE `searchrol`(idrol int)
    COMMENT 'Procedimiento que carga la informacion de un rol'
BEGIN
 
	
	select id,nombre,descripcion
	from rol
	where id = idrol;
	
END$$

CREATE  PROCEDURE `searchuser`(vid int)
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
CREATE  FUNCTION `deleteaforo`(vid INT) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que elimina un aforo'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
    DELETE FROM aforo WHERE id = vid;
    SET res = 1;
    RETURN res;

END$$

CREATE  FUNCTION `deleteclimatologico`(vid INT) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que elimina un estado climatologico'
BEGIN 
    DECLARE res INT DEFAULT 0;
    DELETE FROM estadoclimatologico WHERE id = vid;
SET res = 1;
	RETURN res;

END$$

CREATE  FUNCTION `deleteplandemanejo`(vid INT) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que elimina un plan de manejo'
BEGIN 
    DECLARE res INT DEFAULT 0;
    DELETE FROM plandemanejo WHERE id = vid;
    SET res = 1;
    RETURN res;

END$$

CREATE  FUNCTION `deletepotrero`(vid INT) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que elimina un potrero'
BEGIN 
    DECLARE res INT DEFAULT 0;
    DELETE FROM potrero WHERE id = vid;
SET res = 1;
	RETURN res;

END$$

CREATE  FUNCTION `deleterol`(cod INT) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que elimina un rol'
BEGIN
	DECLARE res INT default 0;	
    delete from rol where id = cod;
	SET res = 1;
	RETURN res;
END$$

CREATE  FUNCTION `deleterotacion`(vid INT) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que elimina una rotacion'
BEGIN 
    DECLARE res INT DEFAULT 0;
    DELETE FROM rotacion WHERE id = vid;
SET res = 1;
	RETURN res;

END$$

CREATE  FUNCTION `deleteuser`(vid INT) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que elimina un usuario'
BEGIN 
    DECLARE res INT DEFAULT 0;
    DELETE FROM usuario WHERE id = vid;
SET res = 1;
	RETURN res;
END$$

CREATE  FUNCTION `deletevaca`(vid INT) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que elimina una vaca'
BEGIN 
    DECLARE res INT DEFAULT 0;
    DELETE FROM vaca WHERE id = vid;
SET res = 1;
	RETURN res;

END$$

CREATE  FUNCTION `saveaforo`(vid int, 
                          vfecha varchar(20), 
                          vidpotrero int,
                          vpastoalto float,
                          vpastomedio float,
                          vpastobajo float,                          
                          vlancealto int,
                          vlancemedio int,
                          vlancebajo int,
                          vcantlances int,
                          vpesopastoalto float,
                          vpesopastomedio float, 
                          vpesopastobajo float, 
                          vcantpasto float, 
                          vporcentajealtro float, 
                          vporcentajemedio float, 
                          vporcentajebajo float, 
                          vtotalmetrocuadrado float, 
                          vcantpastopotrero float, 
                          vtiempopotrero float,  
                          vobservaciones varchar(2000), 
                          vidresponsable int) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que almacena un aforo'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select id from aforo where fecha=vfecha AND idpotrero = vidpotrero)
		THEN
			insert into aforo(fecha,idpotrero,pastoalto,pastomedio,pastobajo,lancealto,lancemedio,lancebajo,
                                          cantlances,pesopastoalto,pesopastomedio,pesopastobajo,cantpasto,porcentajealtro,
                                          porcentajemedio,porcentajebajo,totalmetrocuadrado,cantpastopotrero,
                                          tiempopotrero,idresponsable,observaciones)
                        values (vfecha,vidpotrero,vpastoalto,vpastomedio,vpastobajo,vlancealto,vlancemedio,vlancebajo,vcantlances,
                                vpesopastoalto,vpesopastomedio,vpesopastobajo,vcantpasto,vporcentajealtro,vporcentajemedio,vporcentajebajo,
                                vtotalmetrocuadrado,vcantpastopotrero,vtiempopotrero,vidresponsable,vobservaciones);
			set res = 1;
			
				
			
		END IF;

RETURN res;
	
END$$

CREATE  FUNCTION `saveclimatologico`(`id` INT, `vfecha` VARCHAR(20), `vnubosidad` VARCHAR(20), `vpluviometria` FLOAT, `vobservaciones` VARCHAR(2000), `vidresponsable` INT) RETURNS int(1)
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

CREATE  FUNCTION `saveplandemanejo`(vid int, 
                          vfecha varchar(20), 
                          vnombre varchar(20), 
                          vidresponsable int(6), 
                          vobservaciones varchar(2000)) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que almacena un plan de manejo'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select id from plandemanejo where id=vid)
		THEN
			insert into plandemanejo(fecha, nombre, idresponsable, observaciones)
			VALUES (vfecha,vnombre,vidresponsable,vobservaciones);
			set res = 1;
		END IF;

RETURN res;
	
END$$

CREATE  FUNCTION `savepotrero`(`vid` INT(11), `vnumero` INT(11), `varea` FLOAT(11), `vobservacion` VARCHAR(2000), `vidrotacion` INT(11), `vestado` TINYINT, `vidresponsable` INT(11)) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que almacena un potrero'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select numero from potrero where numero=vnumero)
		THEN
			insert into potrero(numero, area, observacion, idrotacion, estado, idresponsable)
			VALUES (vnumero, 
                          varea, 
                          vobservacion , 
                          vidrotacion ,
                    	  vestado,
                          vidresponsable);
			set res = 1;
			
				
			
		END IF;

	RETURN res;
	
END$$

CREATE  FUNCTION `saverol`(cod INT,nom varchar(50),des varchar(2000)) RETURNS int(1)
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

CREATE  FUNCTION `saverotacion`(vid int, 
                          vnombre varchar(50), 
                          vcantvacas int(11), 
                          vidresponsable int(11)) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que almacena una rotacion'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select  nombre from rotacion where nombre=vnombre)
		THEN
			insert into rotacion(nombre, cantvacas, idresponsable)
			VALUES (vnombre,vcantvacas,vidresponsable);
			set res = 1;
					
		END IF;

	RETURN res;
	
END$$

CREATE  FUNCTION `saveuser`(`id` INT, `vfirstname` VARCHAR(50), `vsecondname` VARCHAR(50), `vfirstlastname` VARCHAR(50), `vsecondlastname` VARCHAR(50), `vcedula` VARCHAR(50), `vcorreo` VARCHAR(50), `vcelular` VARCHAR(50), `vfoto` VARCHAR(200), `vuser` VARCHAR(50), `vpass` VARCHAR(50), `vrol` INT, `vdescription` VARCHAR(50)) RETURNS int(1)
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

CREATE  FUNCTION `savevaca`(vid int, 
                          vnumero varchar(20), 
                          vnombre varchar(30), 
                          vidrotacion int, 
                          vsexo int, 
                          vraza int, 
                          vtipoanimal int, 
                          vedad int,                 
                          vidresponsable int) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que almacena una vaca'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select numero from vaca where numero=vnumero)
		THEN
			insert into vaca(id,numero,nombre,idrotacion,sexo,raza,tipoanimal,edad,idresponsable)
			VALUES (vid,vnumero,vnombre,vidrotacion,vsexo,vraza,vtipoanimal,vedad,vidresponsable);
			set res = 1;
			
				
			
		END IF;

	RETURN res;
	
END$$

CREATE  FUNCTION `updaeplandemanejo`(vid int, 
                          vfecha varchar(20), 
                          vnombre varchar(20), 
                          vidresponsable int(6), 
                          vobservaciones varchar(2000)) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que modifica un plan de manejo'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select id from plandemanejo where id=vid and id<>vid)
		THEN

            UPDATE plandemanejo
            SET  fecha = vfecha , nombre = vnombre , idResponsable = vidResponsable , observaciones = vobservaciones
            WHERE id=vid;

	set res=1;
								
			
		END IF;

	RETURN res;
	

END$$

CREATE  FUNCTION `updateaforo`(vid int, 
                          vfecha varchar(20), 
                          vidpotrero int,
                          vpastoalto float,
                          vpastomedio float,
                          vpastobajo float,                          
                          vlancealto int,
                          vlancemedio int,
                          vlancebajo int,
                          vcantlances int,
                          vpesopastoalto float,
                          vpesopastomedio float, 
                          vpesopastobajo float, 
                          vcantpasto float, 
                          vporcentajealtro float, 
                          vporcentajemedio float, 
                          vporcentajebajo float, 
                          vtotalmetrocuadrado float, 
                          vcantpastopotrero float, 
                          vtiempopotrero float,  
                          vobservaciones varchar(2000), 
                          vidresponsable int) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que modifica un aforo'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select id from aforo where fecha=vfecha AND idpotrero = vidpotrero and id<>vid)
		THEN

                UPDATE aforo
                SET fecha = vfecha, idpotrero = vidpotrero, pastoalto = vpastoalto, pastomedio = vpastomedio,
                    pastobajo = vpastobajo,lancealto = vlancealto,lancemedio = vlancemedio,lancebajo = vlancebajo,
                    cantlances = vcantlances, pesopastoalto = vpesopastoalto, pesopastomedio = vpesopastomedio, 
                    pesopastobajo = vpesopastobajo, cantpasto = vcantpasto, porcentajealtro = vporcentajealtro, 
                    porcentajemedio = vporcentajemedio, porcentajebajo = vporcentajebajo, totalmetrocuadrado = vtotalmetrocuadrado, 
                    cantpastopotrero = vcantpastopotrero, tiempopotrero = vtiempopotrero,  observaciones = vobservaciones, 
                    idresponsable = vidresponsable
                WHERE id=vid;

		set res=1;
								
			
		END IF;

	RETURN res;
	

END$$

CREATE  FUNCTION `updateclimatologico`(`vid` INT, `vfecha` VARCHAR(20), `vnubosidad` VARCHAR(20), `vpluviometria` FLOAT, `vobservaciones` VARCHAR(2000), `vidresponsable` INT) RETURNS int(1)
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

CREATE  FUNCTION `updatepassword`(vid int, vpass varchar(50)) RETURNS int(1)
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

CREATE  FUNCTION `updatepermission`(vid integer, vpermission varchar(2000)) RETURNS int(1)
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

CREATE  FUNCTION `updatepotrero`(`vid` INT(11), `vnumero` INT(11), `varea` FLOAT(11), `vobservacion` VARCHAR(2000), `vidrotacion` INT(11), `vestado` TINYINT, `vidresponsable` INT(11)) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que modifica un potrero'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select numero from potrero where numero=vnumero and id<>vid)
		THEN

UPDATE potrero
   SET  numero=vnumero, area=varea, observacion=vobservacion, idrotacion=vidrotacion, estado = vestado
 WHERE id=vid;

			set res=1;
								
			
		END IF;

	RETURN res;
	

END$$

CREATE  FUNCTION `updaterol`(cod INT,nom varchar(50),des varchar(2000)) RETURNS int(1)
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

CREATE  FUNCTION `updaterotacion`(vid int, 
                          vnombre varchar(50), 
                          vcantvacas int(11), 
                          vidresponsable int(11)) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que modifica una rotacion'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select nombre from rotacion where nombre=vnombre and id<>vid)
		THEN

UPDATE rotacion
   SET  nombre = vnombre, cantvacas = vcantvacas, idresponsable = vidresponsable 
 WHERE id=vid;

			set res=1;
								
			
		END IF;

	RETURN res;
	

END$$

CREATE  FUNCTION `updateuser`(`vid` INT, `vfirstname` VARCHAR(50), `vsecondname` VARCHAR(50), `vfirstlastname` VARCHAR(50), `vsecondlastname` VARCHAR(50), `vcedula` VARCHAR(50), `vcorreo` VARCHAR(50), `vcelular` VARCHAR(50), `vfoto` VARCHAR(200), `vuser` VARCHAR(50), `vrol` INT, `vdescription` VARCHAR(50)) RETURNS int(1)
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

CREATE  FUNCTION `updatevaca`(vid int, 
                          vnumero varchar(20), 
                          vnombre varchar(30), 
                          vidrotacion int, 
                          vsexo int, 
                          vraza int, 
                          vtipoanimal int, 
                          vedad int,                 
                          vidresponsable int) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que modifica una vaca'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select numero from vaca where numero=vnumero and id<>vid)
		THEN

UPDATE vaca
   SET numero=vnumero ,nombre= vnombre,idrotacion= vidrotacion,sexo=vsexo ,
       raza= vraza,tipoanimal=vtipoanimal ,edad=vedad ,idresponsable= vidresponsable
 WHERE id=vid;

			set res=1;
								
			
		END IF;

	RETURN res;
	

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aforo`
--

CREATE TABLE IF NOT EXISTS `aforo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` varchar(20) DEFAULT NULL,
  `idpotrero` int(11) DEFAULT NULL,
  `pastoalto` float DEFAULT NULL,
  `pastobajo` float DEFAULT NULL,
  `pastomedio` float DEFAULT NULL,
  `lancealto` int(11) DEFAULT NULL,
  `lancemedio` int(11) DEFAULT NULL,
  `lancebajo` int(11) DEFAULT NULL,
  `cantlances` int(11) DEFAULT NULL,
  `pesopastoalto` float DEFAULT NULL,
  `pesopastobajo` float DEFAULT NULL,
  `pesopastomedio` float DEFAULT NULL,
  `cantpasto` float DEFAULT NULL,
  `porcentajealtro` float DEFAULT NULL,
  `porcentajemedio` float DEFAULT NULL,
  `porcentajebajo` float DEFAULT NULL,
  `totalmetrocuadrado` float DEFAULT NULL,
  `cantpastopotrero` float DEFAULT NULL,
  `tiempopotrero` float DEFAULT NULL,
  `observaciones` varchar(2000) DEFAULT NULL,
  `idresponsable` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idpotrero` (`idpotrero`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `aforo`
--

INSERT INTO `aforo` (`id`, `fecha`, `idpotrero`, `pastoalto`, `pastobajo`, `pastomedio`, `lancealto`, `lancemedio`, `lancebajo`, `cantlances`, `pesopastoalto`, `pesopastobajo`, `pesopastomedio`, `cantpasto`, `porcentajealtro`, `porcentajemedio`, `porcentajebajo`, `totalmetrocuadrado`, `cantpastopotrero`, `tiempopotrero`, `observaciones`, `idresponsable`) VALUES
(1, '02-05-2020', 1, 23123, 23123, 23123, 23123, 12312, 1231, 36666, 534673000, 28464400, 284690000, 847828000, 63.06, 33.58, 3.36, 23123, 25689700, 93416.9, 'sdfsfsdfs', 1),
(2, '2020-10-23', 3, 10, 5, 7, 10, 12, 10, 32, 100, 50, 84, 234, 31.25, 37.5, 31.25, 7.3125, 112.539, 0.204617, '', 1),
(3, '2020-2-23', 3, 10, 5, 7, 11, 9, 15, 35, 110, 75, 63, 248, 31.43, 25.71, 42.86, 7.08571, 109.049, 0.198271, 'ffhg', 1),
(4, '2020-6-30', 3, 1, 1, 1, 10, 10, 10, 30, 10, 10, 10, 30, 33.33, 33.33, 33.33, 1, 15.39, 0.0279818, '', 1),
(5, '2020-3-31', 4, 1, 1, 1, 10, 10, 10, 30, 10, 10, 10, 30, 33.33, 33.33, 33.33, 1, 1606.61, 2.92112, 'sdsadsadsadsa', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estadoclimatologico`
--

CREATE TABLE IF NOT EXISTS `estadoclimatologico` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` varchar(20) DEFAULT NULL,
  `nubosidad` varchar(20) DEFAULT NULL,
  `pluviometria` float DEFAULT NULL,
  `observaciones` varchar(2000) CHARACTER SET utf8 DEFAULT NULL,
  `idresponsable` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Volcado de datos para la tabla `estadoclimatologico`
--

INSERT INTO `estadoclimatologico` (`id`, `fecha`, `nubosidad`, `pluviometria`, `observaciones`, `idresponsable`) VALUES
(12, '2020-3-31', 'Alta', 33, 'Mucha lluvia', 1);

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
(3, 'Roles', '/roles', -1, NULL, 3, 'shirt'),
(4, 'Permisos', '/permisos', -1, NULL, 4, 'finger-print'),
(5, 'Estado climatologico', '/estado-climatologico', -1, NULL, 5, 'cloud'),
(6, 'Rotacion', '/rotaciones', -1, NULL, 6, 'git-compare'),
(7, 'Potreros', '/potrero', -1, NULL, 7, 'crop'),
(8, 'Aforos', '/aforos', -1, NULL, 8, 'keypad'),
(9, 'Vacas', '/vacas', -1, NULL, 9, 'logo-octocat'),
(12, 'Plaga', '/plaga', -1, NULL, 12, 'bug'),
(13, 'Fertilizacion', '/fertilizacion', -1, NULL, 13, 'color-fill'),
(14, 'Reportes', '/reportes', -1, NULL, 14, 'bookmarks'),
(15, 'Plan de manejo', '/plan-manejo', -1, NULL, 15, 'trending-up'),
(16, 'Analisis', '/analisis', -1, NULL, 16, 'speedometer'),
(17, 'Informe', '/informe', -1, NULL, 16, 'analytics');

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
(85, 1),
(85, 2),
(85, 5),
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 12),
(1, 13),
(1, 14),
(1, 15),
(1, 16),
(1, 17),
(93, 1),
(93, 4),
(93, 5),
(93, 6),
(93, 7),
(93, 8),
(93, 9),
(93, 12),
(93, 13),
(93, 14),
(93, 15),
(93, 16),
(93, 17),
(94, 1),
(94, 5),
(94, 6),
(94, 7),
(94, 8),
(94, 9),
(94, 12),
(94, 13),
(94, 14),
(94, 15),
(94, 16),
(94, 17);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `plandemanejo`
--

CREATE TABLE IF NOT EXISTS `plandemanejo` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `fecha` varchar(20) DEFAULT NULL,
  `nombre` varchar(20) DEFAULT NULL,
  `idResponsable` int(6) DEFAULT NULL,
  `observaciones` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `potrero`
--

CREATE TABLE IF NOT EXISTS `potrero` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numero` int(11) DEFAULT NULL,
  `area` float DEFAULT NULL,
  `observacion` varchar(2000) DEFAULT NULL,
  `idrotacion` int(11) DEFAULT NULL,
  `estado` tinyint(1) NOT NULL,
  `idresponsable` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idrotacion` (`idrotacion`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Volcado de datos para la tabla `potrero`
--

INSERT INTO `potrero` (`id`, `numero`, `area`, `observacion`, `idrotacion`, `estado`, `idresponsable`) VALUES
(1, 1111, 2222, '3333', 1, 0, 1),
(2, 2222, 222, '222', 1, 0, 1),
(3, 333, 30.78, '333', 2, 0, 1),
(4, 2321, 3213.23, 'weweqee', 2, 0, 1),
(5, 3242, 34242, 'fdffsfsdf', 1, 0, 1),
(6, 32423, 34242, 'fdffsfsdf', 3, 0, 1),
(7, 111111, 111111, '11111', 2, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `presentacion`
--

CREATE TABLE IF NOT EXISTS `presentacion` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) DEFAULT NULL,
  `observacion` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `raza_vaca`
--

CREATE TABLE IF NOT EXISTS `raza_vaca` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `observaciones` varchar(2000) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `raza_vaca`
--

INSERT INTO `raza_vaca` (`id`, `nombre`, `observaciones`) VALUES
(1, 'Gyrolando', ''),
(2, 'Sueca Roja-y-Blanca', '');

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
(93, 'Desarrollador', 'Tiene acceso a todo, menos creacion de usuarios y nuevos roles'),
(94, 'Pruebas', 'No tiene acceso a nada administrativo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rotacion`
--

CREATE TABLE IF NOT EXISTS `rotacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `cantvacas` int(11) DEFAULT NULL,
  `idresponsable` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `rotacion`
--

INSERT INTO `rotacion` (`id`, `nombre`, `cantvacas`, `idresponsable`) VALUES
(1, 'Vacas horras', 5, 1),
(2, 'Rotacion de prueba', 10, 1),
(3, 'Rotacion prueba 2', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sexo_vaca`
--

CREATE TABLE IF NOT EXISTS `sexo_vaca` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `observaciones` varchar(2000) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `sexo_vaca`
--

INSERT INTO `sexo_vaca` (`id`, `nombre`, `observaciones`) VALUES
(1, 'Hembra', ''),
(2, 'Macho', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_animal`
--

CREATE TABLE IF NOT EXISTS `tipo_animal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `observaciones` varchar(2000) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `tipo_animal`
--

INSERT INTO `tipo_animal` (`id`, `nombre`, `observaciones`) VALUES
(1, 'Vaca', ''),
(2, 'Novilla', ''),
(3, 'Becerro macho', ''),
(4, 'Ternera', ''),
(5, 'Toro reproductor', '');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=40 ;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `primer_nombre`, `segundo_nombre`, `primer_apellido`, `segundo_apellido`, `cedula`, `correo`, `celular`, `foto`, `usuario`, `password`, `rol`, `descripcion`) VALUES
(1, 'Johnny', 'Alexander', 'Salazar', 'Cardona', '1053802815', 'alexander9052@gmail.com', '3217501560', 'Resource/Images/Users/johnny9052_1581479770333.jpg', 'johnny9052', 'df5be1862ca6bf8589cf799004248e87', 1, ''),
(2, 'David', '', 'Angarita', '', '423423423', 'davidangaritag@gmail.com', '', '', 'davidangaritag', '202cb962ac59075b964b07152d234b70', 93, 'es una loquita'),
(36, 'usuario de prueba', '', 'macana', '', '12345', 'prueba@correo.com', '231654', '', 'prueba', '202cb962ac59075b964b07152d234b70', 94, 'undefined'),
(37, 'Fabio', 'Alejandro', 'Quintero ', 'Hincapie', '12345', 'fabio@correo.com', '3188216823', '', 'fabio', '202cb962ac59075b964b07152d234b70', 93, 'undefined'),
(39, 'pepito', 'andres', 'perez', 'ortiz', '23423409', 'pepito@correo.com', '32164727428', '', 'pepitouser', '294893408', 1, 'Usuario de pepito');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vaca`
--

CREATE TABLE IF NOT EXISTS `vaca` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `numero` varchar(20) DEFAULT NULL,
  `nombre` varchar(30) DEFAULT NULL,
  `idrotacion` int(6) DEFAULT NULL,
  `sexo` int(10) DEFAULT NULL,
  `raza` int(10) DEFAULT NULL,
  `tipoanimal` int(10) DEFAULT NULL,
  `edad` int(5) DEFAULT NULL,
  `idresponsable` int(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `vaca_rotacion_fk` (`idrotacion`),
  KEY `vaca_raza_fk` (`raza`),
  KEY `vaca_sexo_fk` (`sexo`),
  KEY `vaca_tipoanimal_fk` (`tipoanimal`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=213 ;

--
-- Volcado de datos para la tabla `vaca`
--

INSERT INTO `vaca` (`id`, `numero`, `nombre`, `idrotacion`, `sexo`, `raza`, `tipoanimal`, `edad`, `idresponsable`) VALUES
(2, '1010', '1010', 1, 1, 1, 1, 11, 0),
(3, '1013', '1013', 1, 1, 1, 1, 11, 0),
(4, '1015', '1015', 1, 1, 1, 1, 11, 0),
(5, '1016', '1016', 1, 1, 1, 1, 11, 0),
(6, '1020', '1020', 1, 1, 1, 1, 11, 0),
(7, '1025', '1025', 1, 1, 1, 1, 11, 0),
(8, '1030', '1030', 1, 1, 1, 1, 11, 0),
(9, '1037', '1037', 1, 1, 1, 1, 11, 0),
(10, '1043', '1043', 1, 1, 1, 1, 11, 0),
(11, '1050', '1050', 1, 1, 1, 1, 11, 0),
(12, '1680', '1680', 1, 1, 1, 2, 0, 0),
(13, '5613', '5613', 1, 2, 1, 3, 0, 0),
(14, '1069', '1069', 1, 1, 1, 1, 10, 0),
(15, '1072', '1072', 1, 1, 1, 1, 10, 0),
(16, '1077', '1077', 1, 1, 1, 1, 9, 0),
(17, '1081', '1081', 1, 1, 1, 1, 10, 0),
(18, '1092', '1092', 1, 1, 1, 1, 10, 0),
(19, '1095', '1095', 1, 1, 1, 1, 11, 0),
(20, '1109', '1109', 1, 1, 1, 1, 10, 0),
(21, '1111', '1111', 1, 1, 1, 1, 10, 0),
(22, '1116', '1116', 1, 1, 1, 1, 10, 0),
(23, '1117', '1117', 1, 1, 1, 1, 10, 0),
(24, '1120', '1120', 1, 1, 1, 1, 10, 0),
(25, '1121', '1121', 1, 1, 1, 1, 10, 0),
(26, '1127', '1127', 1, 1, 1, 1, 10, 0),
(27, '1133', '1133', 1, 1, 1, 1, 10, 0),
(28, '1141', '1141', 1, 1, 1, 1, 10, 0),
(29, '1148', '1148', 1, 1, 1, 1, 10, 0),
(30, '1152', '1152', 1, 1, 1, 1, 10, 0),
(31, '1329', 'ANTONIA', 1, 1, 1, 1, 6, 0),
(32, '1359', 'ARCENIA', 1, 1, 1, 1, 5, 0),
(33, '1362', 'AYMARA', 1, 1, 1, 1, 5, 0),
(34, '1295', 'BAMBINA', 1, 1, 1, 1, 6, 0),
(35, '1391', 'BEATRIZ', 1, 1, 1, 1, 5, 0),
(36, '1397', 'BIRSA', 1, 1, 1, 1, 5, 0),
(37, '1368', 'BOHEMIA', 1, 1, 1, 1, 5, 0),
(38, '1403', 'CELESTINA', 1, 1, 1, 1, 5, 0),
(39, '1275', 'DUVANA', 1, 1, 1, 1, 7, 0),
(40, '1184', 'MELCOCHA', 1, 1, 1, 1, 8, 0),
(41, '1178', 'MILKA', 1, 1, 1, 1, 8, 0),
(42, '1278', 'MOMO', 1, 1, 1, 1, 7, 0),
(43, '1189', 'MOTA', 1, 1, 1, 1, 8, 0),
(44, '1251', 'PICARONA', 1, 1, 1, 1, 7, 0),
(45, '1287', 'PILAR', 1, 1, 2, 1, 7, 0),
(46, '1240', 'WANDA', 1, 1, 1, 1, 7, 0),
(47, '1203', 'ZELMA', 1, 1, 1, 1, 8, 0),
(48, '1682', '1682', 1, 1, 1, 2, 0, 0),
(49, '1678', '1678', 1, 1, 1, 2, 0, 0),
(50, '1675', '1675', 1, 1, 1, 2, 0, 0),
(51, '1674', '1674', 1, 1, 1, 2, 0, 0),
(52, '1673', '1673', 1, 1, 1, 2, 0, 0),
(53, '1672', '1672', 1, 1, 1, 2, 0, 0),
(54, '1671', '1671', 1, 1, 1, 2, 0, 0),
(55, '1520', '1520', 1, 1, 1, 1, 3, 0),
(56, '1670', '1670', 1, 1, 1, 2, 0, 0),
(57, '1487', '1487', 1, 1, 1, 2, 4, 0),
(58, '1490', '1490', 1, 1, 1, 2, 4, 0),
(59, '1493', '1493', 1, 1, 1, 2, 4, 0),
(60, '1502', '1502', 1, 1, 1, 1, 3, 0),
(61, '1511', '1511', 1, 1, 1, 2, 3, 0),
(62, '1565', 'LUISA', 1, 1, 1, 2, 2, 0),
(63, '1593', '1593', 1, 1, 1, 2, 2, 0),
(64, '1594', '1594', 1, 1, 1, 2, 2, 0),
(65, '1595', '1595', 1, 1, 1, 2, 2, 0),
(66, '1596', '1596', 1, 1, 1, 2, 2, 0),
(67, '1651', '1651', 1, 1, 1, 2, 0, 0),
(68, '1652', '1652', 1, 1, 1, 2, 0, 0),
(69, '1653', '1653', 1, 1, 1, 2, 0, 0),
(70, '1655', '1655', 1, 1, 1, 2, 0, 0),
(71, '1656', '1656', 1, 1, 1, 2, 0, 0),
(72, '1657', '1657', 1, 1, 1, 2, 0, 0),
(73, '1658', '1658', 1, 1, 1, 2, 0, 0),
(74, '1683', '1683', 1, 1, 1, 2, 0, 0),
(75, '1684', '1684', 1, 1, 1, 2, 0, 0),
(76, '1688', '1688', 1, 1, 1, 2, 0, 0),
(77, '1690', '1690', 1, 1, 1, 2, 0, 0),
(78, '1691', '1691', 1, 1, 1, 2, 0, 0),
(79, '1692', '1692', 1, 1, 1, 2, 0, 0),
(80, '1693', '1693', 1, 1, 1, 2, 0, 0),
(81, '5625', '5625', 1, 2, 1, 3, 0, 0),
(82, '5627', '5627', 1, 2, 1, 3, 0, 0),
(83, '1696', '1696', 1, 1, 1, 2, 0, 0),
(84, '1697', '1697', 1, 1, 1, 2, 0, 0),
(85, '1698', 'SARITA', 1, 1, 1, 4, 0, 0),
(86, '1702', '1702', 1, 1, 1, 4, 0, 0),
(87, '1703', '1703', 1, 1, 1, 4, 0, 0),
(88, '1704', '1704', 1, 1, 1, 4, 0, 0),
(89, '1705', '1705', 1, 1, 1, 4, 0, 0),
(90, '1706', '1706', 1, 1, 1, 4, 0, 0),
(91, '1707', '1707', 1, 1, 1, 4, 0, 0),
(92, '1708', '1708', 1, 1, 1, 4, 0, 0),
(93, '5645', '5645', 1, 2, 1, 3, 0, 0),
(94, '1709', '1709', 1, 1, 1, 4, 0, 0),
(95, '1007', '1007', 1, 1, 1, 1, 11, 0),
(96, '1012', '1012', 1, 1, 1, 1, 11, 0),
(97, '1035', '1035', 1, 1, 1, 1, 11, 0),
(98, '1062', '1062', 1, 1, 1, 1, 9, 0),
(99, '1088', '1088', 1, 1, 1, 1, 10, 0),
(100, '1090', '1090', 1, 1, 1, 1, 10, 0),
(101, '1091', '1091', 1, 1, 1, 1, 10, 0),
(102, '1100', '1100', 1, 1, 1, 1, 10, 0),
(103, '1106', '1106', 1, 1, 1, 1, 9, 0),
(104, '1112', '1112', 1, 1, 1, 1, 10, 0),
(105, '1131', '1131', 1, 1, 1, 1, 9, 0),
(106, '1138', '1138', 1, 1, 1, 1, 10, 0),
(107, '1193', 'BERNA', 1, 1, 1, 1, 8, 0),
(108, '1237', 'CARAMBOLA', 1, 1, 1, 1, 7, 0),
(109, '1390', 'CATERINA', 1, 1, 1, 1, 5, 0),
(110, '1408', 'CAYETANA', 1, 1, 1, 1, 5, 0),
(111, '1188', 'DAISY', 1, 1, 1, 1, 8, 0),
(112, '1219', 'FILOMENA', 1, 1, 1, 1, 7, 0),
(113, '1207', 'MARA', 1, 1, 1, 1, 7, 0),
(114, '1183', 'MARQUEZA', 1, 1, 1, 1, 8, 0),
(115, '1195', 'PINTA', 1, 1, 1, 1, 8, 0),
(116, '1212', 'SIMONETA', 1, 1, 1, 1, 7, 0),
(117, '1505', '1505', 1, 1, 1, 1, 3, 0),
(118, '1488', '1488', 1, 1, 1, 1, 4, 0),
(119, '1494', '1494', 1, 1, 1, 1, 4, 0),
(120, '1495', '1495', 1, 1, 1, 1, 4, 0),
(121, '1518', '1518', 1, 1, 1, 1, 3, 0),
(122, '5343', 'ZEUS', 1, 2, 1, 5, 3, 0),
(123, '1006', '1006', 1, 1, 1, 1, 11, 0),
(124, '1019', '1019', 1, 1, 1, 1, 11, 0),
(125, '1029', '1029', 1, 1, 1, 1, 11, 0),
(126, '1036', '1036', 1, 1, 1, 1, 11, 0),
(127, '1046', '1046', 1, 1, 1, 1, 11, 0),
(128, '1061', '1061', 1, 1, 1, 1, 9, 0),
(129, '1066', '1066', 1, 1, 1, 1, 10, 0),
(130, '1085', '1085', 1, 1, 1, 1, 10, 0),
(131, '1086', '1086', 1, 1, 1, 1, 9, 0),
(132, '1097', '1097', 1, 1, 1, 1, 10, 0),
(133, '1132', '1132', 1, 1, 1, 1, 10, 0),
(134, '1149', '1149', 1, 1, 1, 1, 10, 0),
(135, '1292', 'AMANDA', 1, 1, 1, 1, 6, 0),
(136, '1186', 'KIKA', 1, 1, 1, 1, 8, 0),
(137, '1187', 'MAGOLA', 1, 1, 1, 1, 8, 0),
(138, '1241', 'MATILDA', 1, 1, 1, 1, 7, 0),
(139, '1247', 'NIÑA', 1, 1, 1, 1, 7, 0),
(140, '1192', 'TINA', 1, 1, 1, 1, 8, 0),
(141, '1392', 'BAYONA', 1, 1, 1, 1, 5, 0),
(142, '1053', '1053', 1, 1, 1, 1, 10, 0),
(143, '1055', '1055', 1, 1, 1, 1, 10, 0),
(144, '1071', '1071', 1, 1, 1, 1, 9, 0),
(145, '1099', '1099', 1, 1, 1, 1, 10, 0),
(146, '1144', '1144', 1, 1, 1, 1, 10, 0),
(147, '1150', '1150', 1, 1, 1, 1, 10, 0),
(148, '1157', '1157', 1, 1, 1, 1, 10, 0),
(149, '1322', 'ARMONIA', 1, 1, 1, 1, 6, 0),
(150, '1206', 'AURORA', 1, 1, 1, 1, 8, 0),
(151, '1293', 'AZAIRA', 1, 1, 1, 1, 6, 0),
(152, '1309', 'BAXIA', 1, 1, 1, 1, 6, 0),
(153, '1182', 'BELLOTA', 1, 1, 1, 1, 8, 0),
(154, '1250', 'CHURRITA', 1, 1, 1, 1, 7, 0),
(155, '1249', 'CUYABRA', 1, 1, 1, 1, 7, 0),
(156, '1236', 'FIONA', 1, 1, 1, 1, 7, 0),
(157, '1283', 'GRADYS', 1, 1, 1, 1, 7, 0),
(158, '1253', 'SOFIA', 1, 1, 1, 1, 7, 0),
(159, '1205', 'VICENTA', 1, 1, 1, 1, 8, 0),
(160, '1429', '1429', 1, 1, 1, 1, 5, 0),
(161, '1018', '1018', 1, 1, 1, 1, 11, 0),
(162, '1022', '1022', 1, 1, 1, 1, 11, 0),
(163, '1024', '1024', 1, 1, 1, 1, 11, 0),
(164, '1034', '1034', 1, 1, 1, 1, 11, 0),
(165, '1051', '1051', 1, 1, 1, 1, 10, 0),
(166, '1054', '1054', 1, 1, 1, 1, 11, 0),
(167, '1503', 'juana', 1, 1, 1, 1, 3, 0),
(168, '1057', '1057', 1, 1, 1, 1, 10, 0),
(169, '1067', '1067', 1, 1, 1, 1, 9, 0),
(170, '1079', 'GOLONDRINA', 1, 1, 1, 1, 10, 0),
(171, '1108', '1108', 1, 1, 1, 1, 10, 0),
(172, '1125', '1125', 1, 1, 1, 1, 9, 0),
(173, '1159', '1159', 1, 1, 1, 1, 10, 0),
(174, '1395', 'CORDELIA', 1, 1, 1, 1, 5, 0),
(175, '1248', 'LEONELA', 1, 1, 1, 1, 7, 0),
(176, '1190', 'LOLITA', 1, 1, 1, 1, 8, 0),
(177, '1180', 'OLIVA', 1, 1, 1, 1, 8, 0),
(178, '1204', 'SUSU', 1, 1, 1, 1, 8, 0),
(179, '1515', '1515', 1, 1, 1, 1, 3, 0),
(180, '1521', '1521', 1, 1, 1, 1, 3, 0),
(181, '1005', '1005', 1, 1, 1, 1, 11, 0),
(182, '1014', '1014', 1, 1, 1, 1, 11, 0),
(183, '1052', '1052', 1, 1, 1, 1, 9, 0),
(184, '1056', '1056', 1, 1, 1, 1, 10, 0),
(185, '1064', '1064', 1, 1, 1, 1, 10, 0),
(186, '1073', '1073', 1, 1, 1, 1, 9, 0),
(187, '1075', '1075', 1, 1, 1, 1, 10, 0),
(188, '1076', '1076', 1, 1, 1, 1, 10, 0),
(189, '1078', '1078', 1, 1, 1, 1, 10, 0),
(190, '1083', '1083', 1, 1, 1, 1, 9, 0),
(191, '1096', '1096', 1, 1, 1, 1, 10, 0),
(192, '1098', '1098', 1, 1, 1, 1, 10, 0),
(193, '1143', '1143', 1, 1, 1, 1, 10, 0),
(194, '1146', '1146', 1, 1, 1, 1, 10, 0),
(195, '1147', '1147', 1, 1, 1, 1, 10, 0),
(196, '1161', '1161', 1, 1, 1, 1, 10, 0),
(197, '1382', 'BAHIANA', 1, 1, 1, 1, 5, 0),
(198, '1364', 'BALBINA', 1, 1, 1, 1, 5, 0),
(199, '1385', 'BATAVIA', 1, 1, 1, 1, 5, 0),
(200, '1387', 'BENEDICTA', 1, 1, 1, 1, 5, 0),
(201, '1196', 'BERTA', 1, 1, 1, 1, 8, 0),
(202, '1328', 'BETSY', 1, 1, 1, 1, 6, 0),
(203, '1286', 'CHOLITA', 1, 1, 1, 1, 7, 0),
(204, '1409', 'CICIOLINA', 1, 1, 1, 1, 5, 0),
(205, '1179', 'DORIS', 1, 1, 1, 1, 8, 0),
(206, '1191', 'FATIMA', 1, 1, 1, 1, 8, 0),
(207, '1185', 'GOLOSA', 1, 1, 1, 1, 8, 0),
(208, '1194', 'GORDA', 1, 1, 1, 1, 8, 0),
(209, '1252', 'JOAQUINA', 1, 1, 1, 1, 7, 0),
(210, '1239', 'WANDREITA', 1, 1, 1, 1, 7, 0),
(211, '1522', '1522', 1, 1, 1, 1, 3, 0),
(212, '312321', 'vaca prueba', 3, 1, 1, 2, 31232, 1);

--
-- Disparadores `vaca`
--
DROP TRIGGER IF EXISTS `after_vacas_insert`;
DELIMITER //
CREATE TRIGGER `after_vacas_insert` AFTER INSERT ON `vaca`
 FOR EACH ROW begin
       update rotacion set cantvacas = cantvacas + 1
       where id = new.idrotacion;
    end
//
DELIMITER ;
DROP TRIGGER IF EXISTS `before_vacas_delete`;
DELIMITER //
CREATE TRIGGER `before_vacas_delete` BEFORE DELETE ON `vaca`
 FOR EACH ROW begin
      update rotacion set cantvacas = cantvacas - 1
      where id = old.idrotacion;
 end
//
DELIMITER ;
DROP TRIGGER IF EXISTS `before_vacas_update`;
DELIMITER //
CREATE TRIGGER `before_vacas_update` BEFORE UPDATE ON `vaca`
 FOR EACH ROW begin
      if(new.idrotacion<>old.idrotacion)
        then
            update rotacion set cantvacas = cantvacas + 1
            where id = new.idrotacion;

            update rotacion set cantvacas = cantvacas - 1
            where id = old.idrotacion;
      end if;
    end
//
DELIMITER ;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `aforo`
--
ALTER TABLE `aforo`
  ADD CONSTRAINT `aforo_ibfk_1` FOREIGN KEY (`idpotrero`) REFERENCES `potrero` (`id`);

--
-- Filtros para la tabla `menu_rol`
--
ALTER TABLE `menu_rol`
  ADD CONSTRAINT `menu_rol_ibfk_1` FOREIGN KEY (`idrol`) REFERENCES `rol` (`id`),
  ADD CONSTRAINT `menu_rol_ibfk_2` FOREIGN KEY (`idmenu`) REFERENCES `menu` (`id`);

--
-- Filtros para la tabla `potrero`
--
ALTER TABLE `potrero`
  ADD CONSTRAINT `potrero_ibfk_1` FOREIGN KEY (`idrotacion`) REFERENCES `rotacion` (`id`);

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`rol`) REFERENCES `rol` (`id`);

--
-- Filtros para la tabla `vaca`
--
ALTER TABLE `vaca`
  ADD CONSTRAINT `vaca_raza_fk` FOREIGN KEY (`raza`) REFERENCES `raza_vaca` (`id`),
  ADD CONSTRAINT `vaca_rotacion_fk` FOREIGN KEY (`idrotacion`) REFERENCES `rotacion` (`id`),
  ADD CONSTRAINT `vaca_sexo_fk` FOREIGN KEY (`sexo`) REFERENCES `sexo_vaca` (`id`),
  ADD CONSTRAINT `vaca_tipoanimal_fk` FOREIGN KEY (`tipoanimal`) REFERENCES `tipo_animal` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
