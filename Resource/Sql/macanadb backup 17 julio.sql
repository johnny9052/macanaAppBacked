-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 17-07-2020 a las 16:15:53
-- Versión del servidor: 5.7.25-28-log
-- Versión de PHP: 7.3.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `dbdxbar7e6xcvq`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE  PROCEDURE `listaforo` (IN `iduser` INT)  BEGIN
   select a.id,a.fecha,a.idpotrero,a.pastoalto,a.pastobajo,a.pastomedio,a.lancealto,a.lancemedio,a.lancebajo,a.cantlances,a.pesopastoalto,a.pesopastobajo,a.pesopastomedio,a.cantpasto,
          a.porcentajealtro,a.porcentajemedio,a.porcentajebajo,a.totalmetrocuadrado,a.cantpastopotrero,a.tiempopotrero,a.observaciones,a.idresponsable, a.fechaentrada,a.fechasalida, p.numero as numeropotrero
   from aforo as a
   inner join potrero as p on p.id = a.idpotrero
   order by id;
END$$

CREATE  PROCEDURE `listaforocsv` (IN `iduser` INT)  BEGIN
   select p.numero as numeropotrero, a.fecha,a.pastoalto,a.pastobajo,a.pastomedio,a.lancealto,a.lancemedio,a.lancebajo,a.cantlances,a.pesopastoalto,a.pesopastobajo,a.pesopastomedio,a.cantpasto,
          a.porcentajealtro,a.porcentajemedio,a.porcentajebajo,a.totalmetrocuadrado,a.cantpastopotrero,a.tiempopotrero,a.observaciones
   from aforo as a
   inner join potrero as p on p.id = a.idpotrero
   order by id;
END$$

CREATE  PROCEDURE `listclimatologico` (`iduser` INT)  BEGIN
   select id, fecha,nubosidad, pluviometria, observaciones, idresponsable
   from estadoclimatologico
   order by id;
END$$

CREATE  PROCEDURE `listfertilizante` (`idfertilizante` INT)  BEGIN
   select f.id,f.nombre,f.marca,f.idpresentacion,f.idresponsable, p.nombre as presentacion
   from fertilizante as f join presentacion as p 
   on f.idpresentacion = p.id
   order by f.nombre;
END$$

CREATE  PROCEDURE `listPermisosAsignados` (`vidrol` INT)  BEGIN
   select idrol, idmenu
   from menu_rol
   where idrol = vidrol;
END$$

CREATE  PROCEDURE `listplandemanejo` (`iduser` INT)  BEGIN
   select id, fecha,nombre,idResponsable,observaciones
   from plandemanejo
   order by id;
END$$

CREATE  PROCEDURE `listplanmanejofertilizacion` (`iduser` INT)  BEGIN
   select id,nombre,fechainicio,observaciones
   from planmanejofertilizacion
   order by id;
END$$

CREATE  PROCEDURE `listplanmanejofertilizacionfertilizante` (`idplanmanejofertilizacion` INT)  BEGIN
   select pm.id,pm.idplanmanejo,pm.idfertilizante,pm.cantidad,pm.idresponsable, f.nombre
   from planmanejofertilizacionfertilizante as pm join fertilizante as f 
   on pm.idfertilizante = f.id 
   where pm.idplanmanejo = idplanmanejofertilizacion
   order by idfertilizante;
END$$

CREATE  PROCEDURE `listplanmanejofertilizacionpotrero` (`idplanmanejofertilizacion` INT)  BEGIN
   select pm.id, pm.idplanmanejo,pm.idpotrero,pm.fecha,pm.observaciones,pm.ejecutado, p.numero
   from planmanejofertilizacionpotrero as pm join potrero as p 
   on pm.idpotrero = p.id 
   where pm.idplanmanejo = idplanmanejofertilizacion
   order by idPotrero;
END$$

CREATE  PROCEDURE `listplanmanejofertilizacionpotreroByPlanManejo` (`idplanmanejofertilizacion` INT)  BEGIN
   select pm.idpotrero as id ,pm.idplanmanejo,pm.fecha,pm.observaciones,pm.ejecutado, p.numero, p.area as area
   from planmanejofertilizacionpotrero as pm join potrero as p 
   on pm.idpotrero = p.id 
   where pm.idplanmanejo = idplanmanejofertilizacion and p.estado = 0 and pm.ejecutado = 0
   order by idPotrero;
END$$

CREATE  PROCEDURE `listpotrero` (IN `iduser` INT)  BEGIN
 select p.id as id, p.numero as numero,p.area as area, 
          p.observacion as observacion, p.idrotacion as idrotacion,
          p.ordenrotacion as ordenrotacion,
          case 
           when p.estado=1 then 'true'
           else 'false'
          end as estado,
          p.idresponsable as idresponsable, r.cantvacas as 	cantvacas
   from potrero as p 
   inner join rotacion as r on p.idrotacion = r.id
   order by id;
END$$

CREATE  PROCEDURE `listPresentacion` (`iduser` INT)  BEGIN
   select id, nombre,observacion
   from presentacion
   order by id;
END$$

CREATE  PROCEDURE `listrazavaca` (`vid` INT)  BEGIN
   select id,nombre,observaciones
   from raza_vaca
   order by id;
END$$

CREATE  PROCEDURE `listrol` (`iduser` INT)  BEGIN
   select id,nombre as nombre_rol,descripcion 
   from rol
   order by nombre;
END$$

CREATE  PROCEDURE `listrotacion` (`iduser` INT)  BEGIN
   select id,nombre,cantvacas,idresponsable
   from rotacion
   order by id;
END$$

CREATE  PROCEDURE `listsexovaca` (`vid` INT)  BEGIN
   select id,nombre,observaciones
   from sexo_vaca
   order by id;
END$$

CREATE  PROCEDURE `listtipovaca` (`vid` INT)  BEGIN
   select id,nombre,observaciones
   from tipo_animal
   order by id;
END$$

CREATE  PROCEDURE `listuser` (IN `iduser` INT)  BEGIN
   
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

CREATE  PROCEDURE `listvaca` (IN `iduser` INT)  BEGIN
   select v.id,v.numero,v.nombre,v.idrotacion,v.sexo,v.raza,v.tipoanimal,
          v.edad,v.idresponsable, r.nombre as nombre_rotacion
   from vaca as v inner join rotacion as r on r.id = v.idrotacion
   order by id;
END$$

CREATE  PROCEDURE `loadallmenu` ()  BEGIN
   
	select m.id,m.nombre,m.codigo,m.padre as codpadre,m2.nombre as nombrepadre,m.prioridad, m.icono as icono
	from menu as m
	left JOIN menu as m2 on m.padre = m2.id	
	order by m.prioridad;

END$$

CREATE  PROCEDURE `loadapage` (IN `vpage` VARCHAR(2000), IN `vrol` INT)  BEGIN
   
	select m.codigo
	from menu as m 	
	inner join menu_rol as mr on mr.idmenu = m.id
	where mr.idrol = vrol AND m.codigo = vpage;	

END$$

CREATE  PROCEDURE `loadmenu` (IN `rol` INT)  BEGIN
   
	select m.id,m.nombre,m.codigo,m.padre as codpadre,m2.nombre as nombrepadre,mr.idrol,m.prioridad, m.icono as icono
	from menu as m
	left JOIN menu as m2 on m.padre = m2.id
	LEFT join menu_rol as mr on mr.idmenu = m.id
	where (mr.idrol = rol OR (m.padre = -1 AND (mr.idrol = rol OR mr.idrol IS NULL)))
	order by m.prioridad;
END$$

CREATE  PROCEDURE `loadrol` (IN `idfilter` INT)  BEGIN
 
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

CREATE  PROCEDURE `login` (IN `usu` VARCHAR(50), IN `pass` VARCHAR(50))  BEGIN
   select u.usuario,u.primer_nombre,u.primer_apellido,u.rol,u.id,r.nombre as rol_nombre,u.foto
   from usuario as u
   inner join rol as r on u.rol = r.id
   where password=pass and usuario=usu;		
END$$

CREATE  PROCEDURE `searchrol` (`idrol` INT)  BEGIN
 
	
	select id,nombre,descripcion
	from rol
	where id = idrol;
	
END$$

CREATE  PROCEDURE `searchuser` (`vid` INT)  BEGIN
 	
	SELECT id, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, 
	usuario, rol, descripcion
	FROM usuario
	where id = vid;	
	
END$$

--
-- Funciones
--
CREATE  FUNCTION `deleteaforo` (`vid` INT) RETURNS INT(1) READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que elimina un aforo'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
    DELETE FROM aforo WHERE id = vid;
    SET res = 1;
    RETURN res;

END$$

CREATE  FUNCTION `deleteclimatologico` (`vid` INT) RETURNS INT(1) READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que elimina un estado climatologico'
BEGIN 
    DECLARE res INT DEFAULT 0;
    DELETE FROM estadoclimatologico WHERE id = vid;
SET res = 1;
	RETURN res;

END$$

CREATE  FUNCTION `deletefertilizante` (`vid` INT) RETURNS INT(1) READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que elimina un fertilizante'
BEGIN 
    DECLARE res INT DEFAULT 0;
    DELETE FROM fertilizante WHERE id = vid;
    SET res = 1;
    RETURN res;

END$$

CREATE  FUNCTION `deleteplandemanejo` (`vid` INT) RETURNS INT(1) READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que elimina un plan de manejo'
BEGIN 
    DECLARE res INT DEFAULT 0;
    DELETE FROM plandemanejo WHERE id = vid;
    SET res = 1;
    RETURN res;

END$$

CREATE  FUNCTION `deleteplanmanejofertilizacion` (`vid` INT) RETURNS INT(1) READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que elimina un plan de manejo fertilizacion'
BEGIN 
    DECLARE res INT DEFAULT 0;
    DELETE FROM planmanejofertilizacion WHERE id = vid;
    SET res = 1;
    RETURN res;

END$$

CREATE  FUNCTION `deleteplanmanejofertilizacionfertilizante` (`vid` INT) RETURNS INT(1) READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que elimina un plan de manejo fertilizacion fertilizante'
BEGIN 
    DECLARE res INT DEFAULT 0;
    DELETE FROM planmanejofertilizacionfertilizante 
    WHERE id = vid;
    SET res = 1;
    RETURN res;

END$$

CREATE  FUNCTION `deleteplanmanejofertilizacionpotrero` (`vid` INT) RETURNS INT(1) READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que elimina un plan de manejo fertilizacion potrero'
BEGIN 
    DECLARE res INT DEFAULT 0;
    DELETE FROM planmanejofertilizacionpotrero 
    WHERE id = vid;
    SET res = 1;
    RETURN res;

END$$

CREATE  FUNCTION `deletepotrero` (`vid` INT) RETURNS INT(1) READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que elimina un potrero'
BEGIN 
    DECLARE res INT DEFAULT 0;
    DELETE FROM potrero WHERE id = vid;
SET res = 1;
	RETURN res;

END$$

CREATE  FUNCTION `deletepresentacion` (`vid` INT) RETURNS INT(1) READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que elimina una presentacion'
BEGIN 
    DECLARE res INT DEFAULT 0;
    DELETE FROM presentacion WHERE id = vid;
    SET res = 1;
    RETURN res;

END$$

CREATE  FUNCTION `deleterol` (`cod` INT) RETURNS INT(1) READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que elimina un rol'
BEGIN
	DECLARE res INT default 0;	
    delete from rol where id = cod;
	SET res = 1;
	RETURN res;
END$$

CREATE  FUNCTION `deleterotacion` (`vid` INT) RETURNS INT(1) READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que elimina una rotacion'
BEGIN 
    DECLARE res INT DEFAULT 0;
    DELETE FROM rotacion WHERE id = vid;
SET res = 1;
	RETURN res;

END$$

CREATE  FUNCTION `deleteuser` (`vid` INT) RETURNS INT(1) READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que elimina un usuario'
BEGIN 
    DECLARE res INT DEFAULT 0;
    DELETE FROM usuario WHERE id = vid;
SET res = 1;
	RETURN res;
END$$

CREATE  FUNCTION `deletevaca` (`vid` INT) RETURNS INT(1) READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que elimina una vaca'
BEGIN 
    DECLARE res INT DEFAULT 0;
    DELETE FROM vaca WHERE id = vid;
SET res = 1;
	RETURN res;

END$$

CREATE  FUNCTION `saveaforo` (`vid` INT, `vfecha` VARCHAR(20), `vidpotrero` INT, `vpastoalto` FLOAT, `vpastomedio` FLOAT, `vpastobajo` FLOAT, `vlancealto` INT, `vlancemedio` INT, `vlancebajo` INT, `vcantlances` INT, `vpesopastoalto` FLOAT, `vpesopastomedio` FLOAT, `vpesopastobajo` FLOAT, `vcantpasto` FLOAT, `vporcentajealtro` FLOAT, `vporcentajemedio` FLOAT, `vporcentajebajo` FLOAT, `vtotalmetrocuadrado` FLOAT, `vcantpastopotrero` FLOAT, `vtiempopotrero` FLOAT, `vobservaciones` VARCHAR(2000), `vidresponsable` INT, `vfechaentrada` VARCHAR(20), `vfechasalida` VARCHAR(20)) RETURNS INT(1) READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que almacena un aforo'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select id from aforo where fecha=vfecha AND idpotrero = vidpotrero)
		THEN
			insert into aforo(fecha,idpotrero,pastoalto,pastomedio,pastobajo,lancealto,lancemedio,lancebajo,
                                          cantlances,pesopastoalto,pesopastomedio,pesopastobajo,cantpasto,porcentajealtro,
                                          porcentajemedio,porcentajebajo,totalmetrocuadrado,cantpastopotrero,
                                          tiempopotrero,idresponsable,observaciones,fechaentrada, fechasalida)
                        values (vfecha,vidpotrero,vpastoalto,vpastomedio,vpastobajo,vlancealto,vlancemedio,vlancebajo,vcantlances,
                                vpesopastoalto,vpesopastomedio,vpesopastobajo,vcantpasto,vporcentajealtro,vporcentajemedio,vporcentajebajo,
                                vtotalmetrocuadrado,vcantpastopotrero,vtiempopotrero,vidresponsable,vobservaciones,vfechaentrada,vfechasalida);
			set res = 1;
			
				
			
		END IF;

RETURN res;
	
END$$

CREATE  FUNCTION `saveclimatologico` (`id` INT, `vfecha` VARCHAR(20), `vnubosidad` VARCHAR(20), `vpluviometria` FLOAT, `vobservaciones` VARCHAR(2000), `vidresponsable` INT) RETURNS INT(1) READS SQL DATA
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

CREATE  FUNCTION `savefertilizante` (`vid` INT, `vnombre` VARCHAR(50), `vmarca` VARCHAR(50), `vidpresentacion` INT(11), `vidresponsable` INT(11)) RETURNS INT(1) READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que almacena un fertilizante'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select id from fertilizante where id=vid)
		THEN
			insert into fertilizante(nombre, marca, idpresentacion, idresponsable)
			VALUES (vnombre,vmarca,vidpresentacion,vidresponsable);
			set res = 1;
			
		END IF;

RETURN res;
	
END$$

CREATE  FUNCTION `saveplandemanejo` (`vid` INT, `vfecha` VARCHAR(20), `vnombre` VARCHAR(20), `vidresponsable` INT(6), `vobservaciones` VARCHAR(2000)) RETURNS INT(1) READS SQL DATA
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

CREATE  FUNCTION `saveplanmanejofertilizacion` (`vid` INT, `vnombre` VARCHAR(200), `vfechainicio` VARCHAR(50), `vobservaciones` VARCHAR(50), `vidresponsable` INT) RETURNS INT(1) READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que almacena un plan de manejo fertilizacion'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select id from planmanejofertilizacion where fechainicio=vfechainicio)
		THEN
			insert into planmanejofertilizacion(nombre,fechainicio,observaciones,idresponsable)
			VALUES (vnombre,vfechainicio,vobservaciones,vidresponsable);
			set res = 1;
		END IF;

RETURN res;
	
END$$

CREATE  FUNCTION `saveplanmanejofertilizacionfertilizante` (`vidplanmanejo` INT, `vidfertilizante` INT, `vcantidad` INT, `vidresponsable` INT) RETURNS INT(1) READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que almacena un plan de manejo fertilizacion fertilizante'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select idplanmanejo from planmanejofertilizacionfertilizante where idplanmanejo=vidplanmanejo and idfertilizante=vidfertilizante)
		THEN
			insert into planmanejofertilizacionfertilizante(idplanmanejo,idfertilizante,cantidad,idresponsable)
			VALUES (vidplanmanejo,vidfertilizante,vcantidad,vidresponsable);
			set res = 1;
		END IF;

RETURN res;
	
END$$

CREATE  FUNCTION `saveplanmanejofertilizacionpotrero` (`vidplanmanejo` INT, `vidpotrero` INT, `vidresponsable` INT) RETURNS INT(1) READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que almacena un plan de manejo fertilizacion potrero'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select idplanmanejo from planmanejofertilizacionpotrero where idplanmanejo=vidplanmanejo and idpotrero=vidpotrero)
		THEN
			insert into planmanejofertilizacionpotrero(idplanmanejo,idpotrero,ejecutado,idresponsable)
			VALUES (vidplanmanejo,vidpotrero,0,vidresponsable);
			set res = 1;
		END IF;

RETURN res;
	
END$$

CREATE  FUNCTION `saveplanmanejofertilizacionpotreroporcaracteristica` (`vidplanmanejo` INT, `vidrotacion` INT, `vidresponsable` INT) RETURNS INT(1) READS SQL DATA
    DETERMINISTIC
    COMMENT 'Procedimiento que asigna a un plan de manejo todos los potreros de la finca \r\n             o de una rotacion en especifico'
BEGIN

    DECLARE res INT DEFAULT 0;

    
    DECLARE idpotrerotemp INT;

    DECLARE asignacion_potreros_cursor CURSOR FOR
        select id
        from potrero
        where case
                when vidrotacion <> -1 then
                    idrotacion = vidrotacion
                else 
                    id
                end;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET @hecho = TRUE;

    OPEN asignacion_potreros_cursor;

    loopControl: LOOP
        FETCH asignacion_potreros_cursor INTO idpotrerotemp;

        IF @hecho THEN
            LEAVE loopControl;
        ELSE
            IF NOT EXISTS(select id from planmanejofertilizacionpotrero where idplanmanejo=vidplanmanejo and idpotrero=idpotrerotemp)
		THEN
                    insert into planmanejofertilizacionpotrero (idplanmanejo,idpotrero,fecha,observaciones,ejecutado,idresponsable)
                    values (vidplanmanejo,idpotrerotemp,CURDATE(),'',0,vidresponsable);            								
		END IF;
        END IF;


    END LOOP loopControl;

    CLOSE asignacion_potreros_cursor;

    set res = 1;    
    RETURN res;

END$$

CREATE  FUNCTION `savepotrero` (`vid` INT(11), `vnumero` INT(11), `varea` INT(11), `vobservacion` VARCHAR(2000), `vidrotacion` INT(11), `vidresponsable` INT(11), `vordenrotacion` INT(2), `vestado` INT(1)) RETURNS INT(1) READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que almacena un potrero'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select numero from potrero where numero=vnumero OR (idrotacion=vidrotacion AND ordenrotacion=vordenrotacion))
		THEN
			insert into potrero(numero, area, observacion, idrotacion, idresponsable,ordenrotacion, estado)
			VALUES (vnumero, 
                          varea, 
                          vobservacion , 
                          vidrotacion ,
                          vidresponsable,
	                      vordenrotacion, vestado);
			set res = 1;
			
				
			
		END IF;

	RETURN res;
	
END$$

CREATE  FUNCTION `savepresentacion` (`vid` INT, `vnombre` VARCHAR(20), `vobservacion` VARCHAR(2000)) RETURNS INT(1) READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que almacena una presentacion'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select nombre from presentacion where nombre=vnombre)
		THEN
			insert into presentacion(nombre, observacion)
			VALUES (vnombre,vobservacion);
			set res = 1;
			
				
			
		END IF;

RETURN res;
	
END$$

CREATE  FUNCTION `saverol` (`cod` INT, `nom` VARCHAR(50), `des` VARCHAR(2000)) RETURNS INT(1) READS SQL DATA
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

CREATE  FUNCTION `saverotacion` (`vid` INT, `vnombre` VARCHAR(50), `vcantvacas` INT(11), `vidresponsable` INT(11)) RETURNS INT(1) READS SQL DATA
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

CREATE  FUNCTION `saveuser` (`id` INT, `vfirstname` VARCHAR(50), `vsecondname` VARCHAR(50), `vfirstlastname` VARCHAR(50), `vsecondlastname` VARCHAR(50), `vcedula` VARCHAR(50), `vcorreo` VARCHAR(50), `vcelular` VARCHAR(50), `vfoto` VARCHAR(200), `vuser` VARCHAR(50), `vpass` VARCHAR(50), `vrol` INT, `vdescription` VARCHAR(50)) RETURNS INT(1) READS SQL DATA
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

CREATE  FUNCTION `savevaca` (`vid` INT, `vnumero` VARCHAR(20), `vnombre` VARCHAR(30), `vidrotacion` INT, `vsexo` INT, `vraza` INT, `vtipoanimal` INT, `vedad` INT, `vidresponsable` INT) RETURNS INT(1) READS SQL DATA
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

CREATE  FUNCTION `updaeplandemanejo` (`vid` INT, `vfecha` VARCHAR(20), `vnombre` VARCHAR(20), `vidresponsable` INT(6), `vobservaciones` VARCHAR(2000)) RETURNS INT(1) READS SQL DATA
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

CREATE  FUNCTION `updateaforo` (`vid` INT, `vfecha` VARCHAR(20), `vidpotrero` INT, `vpastoalto` FLOAT, `vpastomedio` FLOAT, `vpastobajo` FLOAT, `vlancealto` INT, `vlancemedio` INT, `vlancebajo` INT, `vcantlances` INT, `vpesopastoalto` FLOAT, `vpesopastomedio` FLOAT, `vpesopastobajo` FLOAT, `vcantpasto` FLOAT, `vporcentajealtro` FLOAT, `vporcentajemedio` FLOAT, `vporcentajebajo` FLOAT, `vtotalmetrocuadrado` FLOAT, `vcantpastopotrero` FLOAT, `vtiempopotrero` FLOAT, `vobservaciones` VARCHAR(2000), `vidresponsable` INT, `vfechaentrada` VARCHAR(20), `vfechasalida` VARCHAR(20)) RETURNS INT(1) READS SQL DATA
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
                    idresponsable = vidresponsable, fechaentrada=vfechaentrada, fechasalida = vfechasalida
                WHERE id=vid;

		set res=1;
								
			
		END IF;

	RETURN res;
	

END$$

CREATE  FUNCTION `updateclimatologico` (`vid` INT, `vfecha` VARCHAR(20), `vnubosidad` VARCHAR(20), `vpluviometria` FLOAT, `vobservaciones` VARCHAR(2000), `vidresponsable` INT) RETURNS INT(1) READS SQL DATA
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

CREATE  FUNCTION `updatefertilizante` (`vid` INT, `vnombre` VARCHAR(50), `vmarca` VARCHAR(50), `vidpresentacion` INT(11), `vidresponsable` INT(11)) RETURNS INT(1) READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que modifica un fertilizante'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select nombre from fertilizante where nombre=vnombre AND id<>vid)
		THEN

            UPDATE fertilizante
            SET  nombre=vnombre, marca = vmarca, idpresentacion = vidpresentacion, idresponsable = vidresponsable
            WHERE id=vid;

	set res=1;
								
			
		END IF;

	RETURN res;
	

END$$

CREATE  FUNCTION `updatepassword` (`vid` INT, `vpass` VARCHAR(50)) RETURNS INT(1) READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que actualiza el password del usuario'
BEGIN 
    DECLARE res INT DEFAULT 0;
    

            UPDATE usuario
            SET password=vpass
            WHERE id=vid;

	    set res=1;
								

	RETURN res;
	

END$$

CREATE  FUNCTION `updatepermission` (`vid` INTEGER, `vpermission` VARCHAR(2000)) RETURNS INT(1) READS SQL DATA
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

CREATE  FUNCTION `updateplanmanejofertilizacion` (`vid` INT, `vnombre` VARCHAR(200), `vfechainicio` VARCHAR(50), `vobservaciones` VARCHAR(50), `vidresponsable` INT) RETURNS INT(1) READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que modifica un plan de manejo fertilizacion'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select id from planmanejofertilizacion where fechainicio=vfechainicio and id<>vid)
		THEN

            UPDATE planmanejofertilizacion
            SET  nombre=vnombre, fechainicio=vfechainicio, 
                   observaciones=vobservaciones
            WHERE id=vid;

	set res=1;
								
			
		END IF;

	RETURN res;
	

END$$

CREATE  FUNCTION `updateplanmanejofertilizacionfertilizante` (`vid` INT, `vidplanmanejo` INT, `vidfertilizante` INT, `vcantidad` INT, `vidresponsable` INT) RETURNS INT(1) READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que modifica un plan de manejo fertilizacion fertilizante'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select idplanmanejo from planmanejofertilizacionfertilizante where idplanmanejo=vidplanmanejo and idfertilizante=vidfertilizante and id <> vid)
		THEN

            UPDATE planmanejofertilizacionfertilizante
            SET  cantidad=vcantidad,idfertilizante=vidfertilizante 
            WHERE id=vid;

	set res=1;
								
			
		END IF;

	RETURN res;
	

END$$

CREATE  FUNCTION `updateplanmanejofertilizacionpotrero` (`vid` INT, `vidplanmanejo` INT, `vidpotrero` INT, `vidresponsable` INT) RETURNS INT(1) READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que modifica un plan de manejo fertilizacion potrero'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select idplanmanejo from planmanejofertilizacionpotrero where idplanmanejo=vidplanmanejo and idpotrero=vidpotrero and id <> vid)
		THEN

            UPDATE planmanejofertilizacionpotrero
            SET  idpotrero=vidpotrero
            WHERE id=vid;

	set res=1;
								
			
		END IF;

	RETURN res;
	

END$$

CREATE  FUNCTION `updateplanmanejofertilizacionpotreroByOperario` (`vidplanmanejo` INT, `vidpotrero` INT, `vfecha` VARCHAR(20), `vobservaciones` VARCHAR(2000), `vejecutado` TINYINT, `vidresponsable` INT) RETURNS INT(1) READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que modifica un plan de manejo fertilizacion potrero'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
    IF EXISTS(select idplanmanejo from planmanejofertilizacionpotrero where idplanmanejo=vidplanmanejo and idpotrero=vidpotrero)
            THEN
                UPDATE planmanejofertilizacionpotrero
                SET  fecha=vfecha,observaciones=vobservaciones,ejecutado=vejecutado,idresponsable = vidresponsable
                WHERE idplanmanejo=vidplanmanejo and idpotrero=vidpotrero;

                set res=1;							
    END IF;

RETURN res;
	

END$$

CREATE  FUNCTION `updatepotrero` (`vid` INT(11), `vnumero` INT(11), `varea` INT(11), `vobservacion` VARCHAR(2000), `vidrotacion` INT(11), `vidresponsable` INT(11), `vordenrotacion` INT(2), `vestado` INT(1)) RETURNS INT(1) READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que modifica un potrero'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select numero from potrero where numero=vnumero and 
              id<>vid OR (idrotacion=vidrotacion AND ordenrotacion=vordenrotacion AND id<>vid))
		THEN

UPDATE potrero
   SET  numero=vnumero, area=varea, observacion=vobservacion, idrotacion=vidrotacion, ordenrotacion=vordenrotacion, estado= vestado
   WHERE id=vid;

			set res=1;
								
			
		END IF;

	RETURN res;
	

END$$

CREATE  FUNCTION `updatepresentacion` (`vid` INT, `vnombre` VARCHAR(20), `vobservacion` VARCHAR(2000)) RETURNS INT(1) READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que modifica una presentacion'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select nombre from presentacion where nombre=vnombre and id<>vid)
		THEN

            UPDATE presentacion
            SET  nombre=vnombre,observacion=vobservacion
            WHERE id=vid;

	set res=1;
								
			
		END IF;

	RETURN res;
	

END$$

CREATE  FUNCTION `updaterol` (`cod` INT, `nom` VARCHAR(50), `des` VARCHAR(2000)) RETURNS INT(1) READS SQL DATA
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

CREATE  FUNCTION `updaterotacion` (`vid` INT, `vnombre` VARCHAR(50), `vcantvacas` INT(11), `vidresponsable` INT(11)) RETURNS INT(1) READS SQL DATA
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

CREATE  FUNCTION `updateuser` (`vid` INT, `vfirstname` VARCHAR(50), `vsecondname` VARCHAR(50), `vfirstlastname` VARCHAR(50), `vsecondlastname` VARCHAR(50), `vcedula` VARCHAR(50), `vcorreo` VARCHAR(50), `vcelular` VARCHAR(50), `vfoto` VARCHAR(200), `vuser` VARCHAR(50), `vrol` INT, `vdescription` VARCHAR(50)) RETURNS INT(1) READS SQL DATA
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

CREATE  FUNCTION `updatevaca` (`vid` INT, `vnumero` VARCHAR(20), `vnombre` VARCHAR(30), `vidrotacion` INT, `vsexo` INT, `vraza` INT, `vtipoanimal` INT, `vedad` INT, `vidresponsable` INT) RETURNS INT(1) READS SQL DATA
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
-- Estructura de tabla para la tabla `actividades`
--

CREATE TABLE `actividades` (
  `id` int(11) NOT NULL,
  `tipoActividad` varchar(30) NOT NULL,
  `fechaInicio` varchar(20) CHARACTER SET latin1 NOT NULL,
  `idPotrero` int(11) NOT NULL,
  `fechaEjecucion` varchar(20) CHARACTER SET latin1 NOT NULL,
  `idAforo` int(11) NOT NULL,
  `cumpio` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aforo`
--

CREATE TABLE `aforo` (
  `id` int(11) NOT NULL,
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
  `fechaEntrada` varchar(20) DEFAULT NULL,
  `fechasalida` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `aforo`
--

INSERT INTO `aforo` (`id`, `fecha`, `idpotrero`, `pastoalto`, `pastobajo`, `pastomedio`, `lancealto`, `lancemedio`, `lancebajo`, `cantlances`, `pesopastoalto`, `pesopastobajo`, `pesopastomedio`, `cantpasto`, `porcentajealtro`, `porcentajemedio`, `porcentajebajo`, `totalmetrocuadrado`, `cantpastopotrero`, `tiempopotrero`, `observaciones`, `idresponsable`, `fechaEntrada`, `fechasalida`) VALUES
(1, '2020-7-4', 14, 3.23, 1.87, 2.35, 15, 13, 8, 36, 48.45, 14.96, 30.55, 93.96, 41.67, 36.11, 22.22, 2.61, 5872.5, 35.6, '', 43, 'undefined', 'undefined');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estadoclimatologico`
--

CREATE TABLE `estadoclimatologico` (
  `id` int(11) NOT NULL,
  `fecha` varchar(20) DEFAULT NULL,
  `nubosidad` varchar(20) DEFAULT NULL,
  `pluviometria` float DEFAULT NULL,
  `observaciones` varchar(2000) CHARACTER SET utf8 DEFAULT NULL,
  `idresponsable` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `estadoclimatologico`
--

INSERT INTO `estadoclimatologico` (`id`, `fecha`, `nubosidad`, `pluviometria`, `observaciones`, `idresponsable`) VALUES
(14, '2020-6-30', 'Alta', 22, 'Día Oscuro', 41);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fertilizante`
--

CREATE TABLE `fertilizante` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `marca` varchar(50) DEFAULT NULL,
  `idpresentacion` int(11) DEFAULT NULL,
  `idresponsable` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `fertilizante`
--

INSERT INTO `fertilizante` (`id`, `nombre`, `marca`, `idpresentacion`, `idresponsable`) VALUES
(1, 'urea', 'indefinida', 5, 43);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menu`
--

CREATE TABLE `menu` (
  `id` int(11) NOT NULL,
  `nombre` varchar(30) DEFAULT NULL,
  `codigo` varchar(2000) DEFAULT NULL,
  `padre` int(11) DEFAULT NULL,
  `descripcion` varchar(2000) DEFAULT NULL,
  `prioridad` int(11) DEFAULT NULL,
  `icono` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
(14, 'Reportes', '/reportes', -1, NULL, 12, 'bookmarks'),
(16, 'Analisis', '/analisis', -1, NULL, 13, 'speedometer'),
(18, 'PM fertilizacion', '/plan-manejo-fertilizacion', -1, '', 14, 'trending-up'),
(19, 'Presentación', '/presentacion', -1, '', 15, 'stopwatch'),
(21, 'Fertilizacion', '/plan-manejo-fertilizacion-operario', -1, '', 16, 'trending-up'),
(22, 'Fertilizantes', '/fertilizante', -1, NULL, 17, 'bonfire'),
(23, 'Cronograma', '/cronograma', -1, NULL, 18, 'calendar');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menu_rol`
--

CREATE TABLE `menu_rol` (
  `idrol` int(11) DEFAULT NULL,
  `idmenu` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `menu_rol`
--

INSERT INTO `menu_rol` (`idrol`, `idmenu`) VALUES
(85, 1),
(85, 2),
(85, 5),
(95, 1),
(95, 5),
(95, 6),
(95, 7),
(95, 8),
(95, 9),
(95, 18),
(95, 21),
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 14),
(1, 16),
(1, 18),
(1, 19),
(1, 21),
(1, 22),
(1, 23),
(93, 1),
(93, 2),
(93, 3),
(93, 4),
(93, 5),
(93, 6),
(93, 7),
(93, 8),
(93, 9),
(93, 14),
(93, 16),
(93, 18),
(93, 19),
(93, 21),
(93, 22),
(93, 23),
(94, 1),
(94, 5),
(94, 6),
(94, 7),
(94, 8),
(94, 9),
(94, 14),
(94, 16),
(94, 18);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `plandemanejo`
--

CREATE TABLE `plandemanejo` (
  `id` int(6) NOT NULL,
  `fecha` varchar(20) DEFAULT NULL,
  `nombre` varchar(20) DEFAULT NULL,
  `idResponsable` int(6) DEFAULT NULL,
  `observaciones` varchar(2000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `planmanejofertilizacion`
--

CREATE TABLE `planmanejofertilizacion` (
  `id` int(11) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `fechainicio` varchar(20) DEFAULT NULL,
  `observaciones` varchar(2000) DEFAULT NULL,
  `idresponsable` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `planmanejofertilizacion`
--

INSERT INTO `planmanejofertilizacion` (`id`, `nombre`, `fechainicio`, `observaciones`, `idresponsable`) VALUES
(3, 'aplicacion urea', '2020-7-4', '', 43),
(4, 'gallunaza ', '2020-7-14', 'jajajaj', 37);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `planmanejofertilizacionfertilizante`
--

CREATE TABLE `planmanejofertilizacionfertilizante` (
  `id` int(11) NOT NULL,
  `idplanmanejo` int(11) DEFAULT NULL,
  `idfertilizante` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `idresponsable` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `planmanejofertilizacionfertilizante`
--

INSERT INTO `planmanejofertilizacionfertilizante` (`id`, `idplanmanejo`, `idfertilizante`, `cantidad`, `idresponsable`) VALUES
(3, 3, 1, 10, 43),
(4, 4, 1, 10, 37);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `planmanejofertilizacionpotrero`
--

CREATE TABLE `planmanejofertilizacionpotrero` (
  `id` int(11) NOT NULL,
  `idplanmanejo` int(11) DEFAULT NULL,
  `idpotrero` int(11) DEFAULT NULL,
  `fecha` varchar(20) DEFAULT NULL,
  `observaciones` varchar(2000) DEFAULT NULL,
  `ejecutado` tinyint(1) DEFAULT NULL,
  `idresponsable` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `planmanejofertilizacionpotrero`
--

INSERT INTO `planmanejofertilizacionpotrero` (`id`, `idplanmanejo`, `idpotrero`, `fecha`, `observaciones`, `ejecutado`, `idresponsable`) VALUES
(4, 3, 14, '17/7/2020', 'esta es una observacion de prueba', 1, 91),
(5, 3, 15, '2020-07-04', '', 0, 43),
(6, 3, 16, '2020-07-04', '', 0, 43),
(7, 4, 14, NULL, NULL, 0, 37),
(8, 4, 15, '2020-07-14', '', 0, 37),
(9, 4, 16, '2020-07-14', '', 0, 37);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `potrero`
--

CREATE TABLE `potrero` (
  `id` int(11) NOT NULL,
  `numero` int(11) DEFAULT NULL,
  `area` float DEFAULT NULL,
  `observacion` varchar(2000) DEFAULT NULL,
  `idrotacion` int(11) DEFAULT NULL,
  `estado` tinyint(1) NOT NULL,
  `idresponsable` int(11) DEFAULT NULL,
  `ordenrotacion` int(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `potrero`
--

INSERT INTO `potrero` (`id`, `numero`, `area`, `observacion`, `idrotacion`, `estado`, `idresponsable`, `ordenrotacion`) VALUES
(14, 1, 4500, 'plan', 5, 0, 43, 1),
(15, 2, 5000, 'plan', 5, 0, 43, 2),
(16, 3, 4300, 'plan', 5, 0, 43, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `presentacion`
--

CREATE TABLE `presentacion` (
  `id` int(6) NOT NULL,
  `nombre` varchar(20) DEFAULT NULL,
  `observacion` varchar(2000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `presentacion`
--

INSERT INTO `presentacion` (`id`, `nombre`, `observacion`) VALUES
(5, 'gramos', '1000grvson 1 kg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `raza_vaca`
--

CREATE TABLE `raza_vaca` (
  `id` int(11) NOT NULL,
  `nombre` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `observaciones` varchar(2000) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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

CREATE TABLE `rol` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `descripcion` varchar(2000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`id`, `nombre`, `descripcion`) VALUES
(1, 'administrador', 'Super administrador del sistema, tiene todos los permisos'),
(85, 'root', 'Tiene todos los permisos, excepto configuracion de roles, usuarios y permisos de usuario'),
(93, 'Desarrollador', 'Tiene acceso a todo, menos creacion de usuarios y nuevos roles'),
(94, 'Pruebas', 'No tiene acceso a nada administrativo'),
(95, 'tester google', 'rol para revisión por parte de google');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rotacion`
--

CREATE TABLE `rotacion` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `cantvacas` int(11) DEFAULT NULL,
  `idresponsable` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `rotacion`
--

INSERT INTO `rotacion` (`id`, `nombre`, `cantvacas`, `idresponsable`) VALUES
(1, 'Default', -22, 37),
(4, 'Rotación 1', 24, 41),
(5, '1', 3, 43);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sexo_vaca`
--

CREATE TABLE `sexo_vaca` (
  `id` int(11) NOT NULL,
  `nombre` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `observaciones` varchar(2000) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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

CREATE TABLE `tipo_animal` (
  `id` int(11) NOT NULL,
  `nombre` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `observaciones` varchar(2000) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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

CREATE TABLE `usuario` (
  `id` int(11) NOT NULL,
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
  `descripcion` varchar(2000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `primer_nombre`, `segundo_nombre`, `primer_apellido`, `segundo_apellido`, `cedula`, `correo`, `celular`, `foto`, `usuario`, `password`, `rol`, `descripcion`) VALUES
(36, 'usuario de prueba', '', 'macana', '', '12345', 'prueba@correo.com', '231654', '', 'prueba', '202cb962ac59075b964b07152d234b70', 94, 'undefined'),
(37, 'Fabio', 'Alejandro', 'Quintero ', 'Hincapie', '12345', 'fabio@correo.com', '3188216823', '', 'fabio', '827ccb0eea8a706c4c34a16891f84e7b', 93, 'undefined'),
(39, 'pepito', 'andres', 'perez', 'ortiz', '23423409', 'pepito@correo.com', '32164727428', '', 'pepitouser', '294893408', 1, 'Usuario de pepito'),
(40, 'Desarrollador', '', 'Desarrollador', '', '12345', '12345@gmail.com', '12345', '', 'johnny9052', 'df5be1862ca6bf8589cf799004248e87', 1, 'undefined'),
(41, 'Admin', '', 'Admin', '', '123456', '', '', '', 'admin', '95e5a9b5aed820de6ae395fbd0ac7856', 1, 'undefined'),
(42, 'tester', 'tester', 'tester', 'tester', '12345', 'tester@correo.com', '12345', '', 'tester', '8e607a4752fa2e59413e5790536f2b42', 95, 'undefined'),
(43, 'Sara', '', 'Quintero', '', '1094976410', 'saraquintero1399@gmail.com', '3104115892', '', 'Sara', '8ec5f756efbf61cb15d63cc134f4170b', 1, 'undefined');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vaca`
--

CREATE TABLE `vaca` (
  `id` int(6) NOT NULL,
  `numero` varchar(20) DEFAULT NULL,
  `nombre` varchar(30) DEFAULT NULL,
  `idrotacion` int(6) DEFAULT NULL,
  `sexo` int(10) DEFAULT NULL,
  `raza` int(10) DEFAULT NULL,
  `tipoanimal` int(10) DEFAULT NULL,
  `edad` int(5) DEFAULT NULL,
  `idresponsable` int(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `vaca`
--

INSERT INTO `vaca` (`id`, `numero`, `nombre`, `idrotacion`, `sexo`, `raza`, `tipoanimal`, `edad`, `idresponsable`) VALUES
(2, '1010', '1010', 5, 1, 1, 1, 11, 43),
(3, '1013', '1013', 5, 1, 1, 1, 11, 43),
(4, '1015', '1015', 5, 1, 1, 1, 11, 43),
(5, '1016', '1016', 4, 1, 1, 1, 11, 41),
(6, '1020', '1020', 4, 1, 1, 1, 11, 41),
(7, '1025', '1025', 4, 1, 1, 1, 11, 41),
(8, '1030', '1030', 4, 1, 1, 1, 11, 41),
(9, '1037', '1037', 4, 1, 1, 1, 11, 41),
(10, '1043', '1043', 4, 1, 1, 1, 11, 41),
(11, '1050', '1050', 4, 1, 1, 1, 11, 41),
(12, '1680', '1680', 4, 1, 1, 2, 0, 41),
(13, '5613', '5613', 4, 2, 1, 3, 0, 41),
(14, '1069', '1069', 4, 1, 1, 1, 10, 41),
(15, '1072', '1072', 4, 1, 1, 1, 10, 41),
(16, '1077', '1077', 4, 1, 1, 1, 9, 41),
(17, '1081', '1081', 4, 1, 1, 1, 10, 41),
(18, '1092', '1092', 4, 1, 1, 1, 10, 41),
(19, '1095', '1095', 4, 1, 1, 1, 11, 41),
(20, '1109', '1109', 4, 1, 1, 1, 10, 41),
(21, '1111', '1111', 4, 1, 1, 1, 10, 41),
(22, '1116', '1116', 4, 1, 1, 1, 10, 41),
(23, '1117', '1117', 4, 1, 1, 1, 10, 41),
(24, '1120', '1120', 4, 1, 1, 1, 10, 41),
(25, '1121', '1121', 4, 1, 1, 1, 10, 41),
(26, '1127', '1127', 4, 1, 1, 1, 10, 41),
(27, '1133', '1133', 4, 1, 1, 1, 10, 41),
(28, '1141', '1141', 4, 1, 1, 1, 10, 41),
(29, '1148', '1148', 1, 1, 1, 1, 10, 41),
(30, '1152', '1152', 1, 1, 1, 1, 10, 41),
(31, '1329', 'ANTONIA', 1, 1, 1, 1, 6, 41),
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
(211, '1522', '1522', 1, 1, 1, 1, 3, 0);

--
-- Disparadores `vaca`
--
DELIMITER $$
CREATE TRIGGER `after_vacas_insert` AFTER INSERT ON `vaca` FOR EACH ROW begin
       update rotacion set cantvacas = cantvacas + 1
       where id = new.idrotacion;
    end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_vacas_delete` BEFORE DELETE ON `vaca` FOR EACH ROW begin
      update rotacion set cantvacas = cantvacas - 1
      where id = old.idrotacion;
 end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_vacas_update` BEFORE UPDATE ON `vaca` FOR EACH ROW begin
      if(new.idrotacion<>old.idrotacion)
        then
            update rotacion set cantvacas = cantvacas + 1
            where id = new.idrotacion;

            update rotacion set cantvacas = cantvacas - 1
            where id = old.idrotacion;
      end if;
    end
$$
DELIMITER ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `actividades`
--
ALTER TABLE `actividades`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `aforo`
--
ALTER TABLE `aforo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idpotrero` (`idpotrero`);

--
-- Indices de la tabla `estadoclimatologico`
--
ALTER TABLE `estadoclimatologico`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `fertilizante`
--
ALTER TABLE `fertilizante`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idpresentacion` (`idpresentacion`);

--
-- Indices de la tabla `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `menu_rol`
--
ALTER TABLE `menu_rol`
  ADD KEY `menu_usuario_idmenu_fkey` (`idmenu`),
  ADD KEY `menu_usuario_idrol_fkey` (`idrol`);

--
-- Indices de la tabla `plandemanejo`
--
ALTER TABLE `plandemanejo`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `planmanejofertilizacion`
--
ALTER TABLE `planmanejofertilizacion`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `planmanejofertilizacionfertilizante`
--
ALTER TABLE `planmanejofertilizacionfertilizante`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idplanmanejo` (`idplanmanejo`),
  ADD KEY `idfertilizante` (`idfertilizante`);

--
-- Indices de la tabla `planmanejofertilizacionpotrero`
--
ALTER TABLE `planmanejofertilizacionpotrero`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idplanmanejo` (`idplanmanejo`),
  ADD KEY `idpotrero` (`idpotrero`);

--
-- Indices de la tabla `potrero`
--
ALTER TABLE `potrero`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idrotacion` (`idrotacion`);

--
-- Indices de la tabla `presentacion`
--
ALTER TABLE `presentacion`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `raza_vaca`
--
ALTER TABLE `raza_vaca`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `rotacion`
--
ALTER TABLE `rotacion`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `sexo_vaca`
--
ALTER TABLE `sexo_vaca`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipo_animal`
--
ALTER TABLE `tipo_animal`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_rol_fkey` (`rol`);

--
-- Indices de la tabla `vaca`
--
ALTER TABLE `vaca`
  ADD PRIMARY KEY (`id`),
  ADD KEY `vaca_rotacion_fk` (`idrotacion`),
  ADD KEY `vaca_raza_fk` (`raza`),
  ADD KEY `vaca_sexo_fk` (`sexo`),
  ADD KEY `vaca_tipoanimal_fk` (`tipoanimal`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `actividades`
--
ALTER TABLE `actividades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `aforo`
--
ALTER TABLE `aforo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `estadoclimatologico`
--
ALTER TABLE `estadoclimatologico`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `fertilizante`
--
ALTER TABLE `fertilizante`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `menu`
--
ALTER TABLE `menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `plandemanejo`
--
ALTER TABLE `plandemanejo`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `planmanejofertilizacion`
--
ALTER TABLE `planmanejofertilizacion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `planmanejofertilizacionfertilizante`
--
ALTER TABLE `planmanejofertilizacionfertilizante`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `planmanejofertilizacionpotrero`
--
ALTER TABLE `planmanejofertilizacionpotrero`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `potrero`
--
ALTER TABLE `potrero`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `presentacion`
--
ALTER TABLE `presentacion`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `raza_vaca`
--
ALTER TABLE `raza_vaca`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- AUTO_INCREMENT de la tabla `rotacion`
--
ALTER TABLE `rotacion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `sexo_vaca`
--
ALTER TABLE `sexo_vaca`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tipo_animal`
--
ALTER TABLE `tipo_animal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT de la tabla `vaca`
--
ALTER TABLE `vaca`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=212;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `aforo`
--
ALTER TABLE `aforo`
  ADD CONSTRAINT `aforo_ibfk_1` FOREIGN KEY (`idpotrero`) REFERENCES `potrero` (`id`);

--
-- Filtros para la tabla `fertilizante`
--
ALTER TABLE `fertilizante`
  ADD CONSTRAINT `fertilizante_ibfk_1` FOREIGN KEY (`idpresentacion`) REFERENCES `presentacion` (`id`);

--
-- Filtros para la tabla `menu_rol`
--
ALTER TABLE `menu_rol`
  ADD CONSTRAINT `menu_rol_ibfk_1` FOREIGN KEY (`idrol`) REFERENCES `rol` (`id`),
  ADD CONSTRAINT `menu_rol_ibfk_2` FOREIGN KEY (`idmenu`) REFERENCES `menu` (`id`);

--
-- Filtros para la tabla `planmanejofertilizacionfertilizante`
--
ALTER TABLE `planmanejofertilizacionfertilizante`
  ADD CONSTRAINT `planmanejofertilizacionfertilizante_ibfk_1` FOREIGN KEY (`idplanmanejo`) REFERENCES `planmanejofertilizacion` (`id`),
  ADD CONSTRAINT `planmanejofertilizacionfertilizante_ibfk_2` FOREIGN KEY (`idfertilizante`) REFERENCES `fertilizante` (`id`);

--
-- Filtros para la tabla `planmanejofertilizacionpotrero`
--
ALTER TABLE `planmanejofertilizacionpotrero`
  ADD CONSTRAINT `planmanejofertilizacionpotrero_ibfk_1` FOREIGN KEY (`idplanmanejo`) REFERENCES `planmanejofertilizacion` (`id`),
  ADD CONSTRAINT `planmanejofertilizacionpotrero_ibfk_2` FOREIGN KEY (`idpotrero`) REFERENCES `potrero` (`id`);

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
COMMIT;
