
create table estadoclimatologico(
    id int AUTO_INCREMENT,
    fecha varchar(20),
    nubosidad varchar(20),
    pluviometria int,
    observaciones nvarchar(2000),
    idresponsable int,
    primary key(id)
);




create table rotacion(
    id int AUTO_INCREMENT,
    nombre varchar(50),
    cantvacas int,
    idresponsable int,
    primary key(id)
);



create table potrero(
    id int AUTO_INCREMENT,
    numero int,
    area int,
    observacion varchar(2000),
    idrotacion int,
    idresponsable int,
    primary key(id),
    foreign key (idrotacion) references rotacion(id)
);




create table aforo(
    id int AUTO_INCREMENT,
    fecha varchar(20),
    idpotrero int,
    pastoalto double,
    pastobajo double,
    pastomedio int,
    lancealto int,
    lancemedio int,
    lancebajo int,
    cantlances int,
    pesopastoalto int,
    pesopastobajo int,
    pesopastomedio int,
    cantpasto int,
    porcentajealtro int,
    porcentajemedio int,
    porcentajebajo int,
    totalmetrocuadrado int,
    cantpastopotrero int,
    tiempopotrero int,
    observaciones varchar(2000),
    idresponsable int,
    primary key(id),
    foreign key (idpotrero) references potrero(id)
);



create table sexo_vaca(
    id int AUTO_INCREMENT,
    nombre nvarchar(20),
    observaciones nvarchar(2000),
    primary key(id)
);

insert into sexo_vaca(nombre,observaciones) values ('Hembra','');
insert into sexo_vaca(nombre,observaciones) values ('Macho','');


create table raza_vaca(
    id int AUTO_INCREMENT,
    nombre nvarchar(20),
    observaciones nvarchar(2000),
    primary key(id)
);


insert into raza_vaca(nombre,observaciones) values ('Gyrolando','');
insert into raza_vaca(nombre,observaciones) values ('Sueca Roja-y-Blanca','');


create table tipo_animal(
    id int AUTO_INCREMENT,
    nombre nvarchar(20),
    observaciones nvarchar(2000),
    primary key(id)
);


insert into tipo_animal(nombre,observaciones) values ('Vaca','');
insert into tipo_animal(nombre,observaciones) values ('Novilla','');
insert into tipo_animal(nombre,observaciones) values ('Becerro macho','');
insert into tipo_animal(nombre,observaciones) values ('Ternera','');
insert into tipo_animal(nombre,observaciones) values ('Toro reproductor','');


select * 
from sexo_vaca;


update vaca
set sexo = '2'
where sexo = 'Macho'


select distinct raza 
from vaca;


update vaca
set raza = '2'
where raza = 'Sueca Roja-y-Blanca'



select distinct tipoanimal 
from vaca;


update vaca
set tipoanimal = '5'
where tipoanimal = 'Toro reproductor'


ALTER TABLE vaca
ADD CONSTRAINT vaca_raza_fk
FOREIGN KEY (raza) REFERENCES raza_vaca(id);


ALTER TABLE vaca
ADD CONSTRAINT vaca_sexo_fk
FOREIGN KEY (sexo) REFERENCES sexo_vaca(id);


ALTER TABLE vaca
ADD CONSTRAINT vaca_tipoanimal_fk
FOREIGN KEY (tipoanimal) REFERENCES tipo_animal(id);





DELIMITER //
CREATE PROCEDURE listvaca(iduser int)
    COMMENT 'Procedimiento que lista las vacas'
BEGIN
   select id,numero,nombre,idrotacion,sexo,raza,tipoanimal,edad,idresponsable
   from vaca
   order by id;
END//

DELIMITER ;




DELIMITER //
CREATE PROCEDURE listrotacion(iduser int)
    COMMENT 'Procedimiento que lista las rotaciones'
BEGIN
   select id,nombre,cantvacas,idresponsable
   from rotacion
   order by id;
END//

DELIMITER ;



DELIMITER //
CREATE PROCEDURE listsexovaca(vid int)
    COMMENT 'Procedimiento que lista las rotaciones'
BEGIN
   select id,nombre,observaciones
   from sexo_vaca
   order by id;
END//

DELIMITER ;




DELIMITER //
CREATE PROCEDURE listrazavaca(vid int)
    COMMENT 'Procedimiento que lista las razas'
BEGIN
   select id,nombre,observaciones
   from raza_vaca
   order by id;
END//

DELIMITER ;



DELIMITER //
CREATE PROCEDURE listtipovaca(vid int)
    COMMENT 'Procedimiento que lista los tipos de vacas'
BEGIN
   select id,nombre,observaciones
   from tipo_animal
   order by id;
END//

DELIMITER ;











DELIMITER //
CREATE FUNCTION savevaca (vid int, 
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
	
END//

DELIMITER ;







DELIMITER //
CREATE FUNCTION updatevaca (vid int, 
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
	

END//

DELIMITER ;








DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION deletevaca(vid INT) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que elimina una vaca'
BEGIN 
    DECLARE res INT DEFAULT 0;
    DELETE FROM vaca WHERE id = vid;
SET res = 1;
	RETURN res;

END//

DELIMITER ;





DELIMITER //
CREATE PROCEDURE listaforo(iduser int)
    COMMENT 'Procedimiento que lista los aforos'
BEGIN
   select a.id,a.fecha,a.idpotrero,a.pastoalto,a.pastobajo,a.pastomedio,a.lancealto,a.lancemedio,a.lancebajo,a.cantlances,a.pesopastoalto,a.pesopastobajo,a.pesopastomedio,a.cantpasto,
          a.porcentajealtro,a.porcentajemedio,a.porcentajebajo,a.totalmetrocuadrado,a.cantpastopotrero,a.tiempopotrero,a.observaciones,a.idresponsable, p.numero as numeropotrero
   from aforo as a
   inner join potrero as p on p.id = a.idpotrero
   order by id;
END//

DELIMITER ;






DROP FUNCTION IF EXISTS saveaforo;

DELIMITER //
CREATE FUNCTION saveaforo (vid int, 
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
	
END//

DELIMITER ;








DROP FUNCTION IF EXISTS updateaforo;

DELIMITER //
CREATE FUNCTION updateaforo (vid int, 
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
	

END//

DELIMITER ;









DELIMITER //
CREATE  FUNCTION deleteaforo(vid INT) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que elimina un aforo'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
    DELETE FROM aforo WHERE id = vid;
    SET res = 1;
    RETURN res;

END//

DELIMITER ;



/********************DISPARADORES*********************************/


drop trigger if exists before_vacas_update;

delimiter //
    create trigger before_vacas_update
      before update
      on vaca
      for each row
    begin
      if(new.idrotacion<>old.idrotacion)
        then
            update rotacion set cantvacas = cantvacas + 1
            where id = new.idrotacion;

            update rotacion set cantvacas = cantvacas - 1
            where id = old.idrotacion;
      end if;
    end //
delimiter ;



drop trigger if exists after_vacas_insert;

 delimiter //
    create trigger after_vacas_insert
      after insert
      on vaca
      for each row
    begin
       update rotacion set cantvacas = cantvacas + 1
       where id = new.idrotacion;
    end //
 delimiter ;




 drop trigger if exists before_vacas_delete;  
  
 delimiter //
 create trigger before_vacas_delete
   before delete
   on vaca
   for each row
 begin
      update rotacion set cantvacas = cantvacas - 1
      where id = old.idrotacion;
 end //
 delimiter ;



/****************************PLAN DE MANEJO***************************************************/

delete from menu_rol where idmenu = 15;

delete from menu where id = 15;

insert into menu (nombre,codigo,padre,descripcion,prioridad,icono) values ('Plan de manejo fertilizacion','/plan-manejo-fertilizacion','-1','','17','trending-up');




create table planmanejofertilizacion(
    id int AUTO_INCREMENT,
    periodicidad int,
    fechainicio varchar(20),
    fechafin varchar(20),
    observaciones varchar(2000),
    idresponsable int,
    primary key(id)
);




DELIMITER //
CREATE PROCEDURE listplanmanejofertilizacion(iduser int)
    COMMENT 'Procedimiento que lista los planes de manejo fertilizacion'
BEGIN
   select id,periodicidad,fechainicio,fechafin,observaciones
   from planmanejofertilizacion
   order by id;
END//

DELIMITER ;







DELIMITER //
CREATE FUNCTION saveplanmanejofertilizacion (vid int, 
                          vperiodicidad varchar(50), 
                          vfechainicio varchar(50), 
                          vfechafin varchar(50), 
                          vobservaciones varchar(50), 
                          vidresponsable int) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que almacena un plan de manejo fertilizacion'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select id from planmanejofertilizacion where fechainicio=vfechainicio and fechafin=vfechafin)
		THEN
			insert into planmanejofertilizacion(periodicidad,fechainicio,fechafin,observaciones,idresponsable)
			VALUES (vperiodicidad,vfechainicio,vfechafin,vobservaciones,vidresponsable);
			set res = 1;
		END IF;

RETURN res;
	
END//

DELIMITER ;









DELIMITER //
CREATE FUNCTION updateplanmanejofertilizacion (vid int, 
                          vperiodicidad varchar(50), 
                          vfechainicio varchar(50), 
                          vfechafin varchar(50), 
                          vobservaciones varchar(50), 
                          vidresponsable int) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que modifica un plan de manejo fertilizacion'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select id from planmanejofertilizacion where fechainicio=vfechainicio and fechafin=vfechafin and id<>vid)
		THEN

            UPDATE planmanejofertilizacion
            SET  periodicidad=vperiodicidad, fechainicio=vfechainicio, 
                    fechafin=vfechafin, observaciones=vobservaciones
            WHERE id=vid;

	set res=1;
								
			
		END IF;

	RETURN res;
	

END//

DELIMITER ;







DELIMITER //
CREATE  FUNCTION deleteplanmanejofertilizacion(vid INT) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que elimina un plan de manejo fertilizacion'
BEGIN 
    DECLARE res INT DEFAULT 0;
    DELETE FROM planmanejofertilizacion WHERE id = vid;
    SET res = 1;
    RETURN res;

END//

DELIMITER ;



/********************GESTION POTRERO*****************************/


create table planmanejofertilizacionpotrero(
    id int AUTO_INCREMENT,
    idplanmanejo int,
    idpotrero int,
    fecha varchar(20),
    observaciones varchar(2000),
    ejecutado tinyint(1),
    idresponsable int,
    primary key (id),
    foreign key (idplanManejo) references planmanejofertilizacion(id),
    foreign key (idpotrero) references potrero(id)
);




DELIMITER //
CREATE PROCEDURE listplanmanejofertilizacionpotrero(idplanmanejofertilizacion int)
    COMMENT 'Procedimiento que lista los potreros de un plan de manejo fertilizacion'
BEGIN
   select pm.id, pm.idplanmanejo,pm.idpotrero,pm.fecha,pm.observaciones,pm.ejecutado, p.numero
   from planmanejofertilizacionpotrero as pm join potrero as p 
   on pm.idpotrero = p.id 
   where pm.idplanmanejo = idplanmanejofertilizacion
   order by idPotrero;
END//

DELIMITER ;






DROP FUNCTION IF EXISTS saveplanmanejofertilizacionpotrero;

DELIMITER //
CREATE FUNCTION saveplanmanejofertilizacionpotrero (
                          vidplanmanejo int, 
                          vidpotrero int, 
                          vfecha varchar(20), 
                          vobservaciones varchar(2000), 
                          vejecutado tinyint, 
                          vidresponsable int) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que almacena un plan de manejo fertilizacion potrero'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select idplanmanejo from planmanejofertilizacionpotrero where idplanmanejo=idplanmanejo and idpotrero=vidpotrero)
		THEN
			insert into planmanejofertilizacionpotrero(idplanmanejo,idpotrero,fecha,observaciones,ejecutado,idresponsable)
			VALUES (vidplanmanejo,vidpotrero,vfecha,vobservaciones,vejecutado,vidresponsable);
			set res = 1;
		END IF;

RETURN res;
	
END//

DELIMITER ;







DROP FUNCTION IF EXISTS updateplanmanejofertilizacionpotrero;


DELIMITER //
CREATE FUNCTION updateplanmanejofertilizacionpotrero (
                          vid int,
                          vidplanmanejo int, 
                          vidpotrero int, 
                          vfecha varchar(20), 
                          vobservaciones varchar(2000), 
                          vejecutado tinyint, 
                          vidresponsable int) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que modifica un plan de manejo fertilizacion potrero'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select idplanmanejo from planmanejofertilizacionpotrero where idplanmanejo=vidplanmanejo and idpotrero=vidpotrero and id <> vid)
		THEN

            UPDATE planmanejofertilizacionpotrero
            SET  fecha=vfecha,observaciones=vobservaciones,ejecutado=vejecutado,idpotrero=vidpotrero
            WHERE id=vid;

	set res=1;
								
			
		END IF;

	RETURN res;
	

END//

DELIMITER ;







DROP FUNCTION IF EXISTS deleteplanmanejofertilizacionpotrero;

DELIMITER //
CREATE  FUNCTION deleteplanmanejofertilizacionpotrero(vid INT) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que elimina un plan de manejo fertilizacion potrero'
BEGIN 
    DECLARE res INT DEFAULT 0;
    DELETE FROM planmanejofertilizacionpotrero 
    WHERE id = vid;
    SET res = 1;
    RETURN res;

END//

DELIMITER ;




/********************GESTION FERTILIZANTE*****************************/


create table fertilizante(
    id int AUTO_INCREMENT,
    nombre varchar(50),
    marca varchar(50),
    idpresentacion int,
    idresponsable int,
    primary key (id),
    foreign key (idpresentacion) references presentacion(id)
);


create table planmanejofertilizacionfertilizante(
    id int AUTO_INCREMENT,
    idplanmanejo int,
    idfertilizante int,
    cantidad int,
    idresponsable int,
    primary key (id),
    foreign key (idplanManejo) references planmanejofertilizacion(id),
    foreign key (idfertilizante) references fertilizante(id)
);




  
DELIMITER //
CREATE PROCEDURE listplanmanejofertilizacionfertilizante(idplanmanejofertilizacion int)
    COMMENT 'Procedimiento que lista los fertilizantes de un plan de manejo fertilizacion'
BEGIN
   select pm.id,pm.idplanmanejo,pm.idfertilizante,pm.cantidad,pm.idresponsable, f.numero
   from planmanejofertilizacionfertilizante as pm join fertilizante as f 
   on pm.idfertilizante = f.id 
   where pm.idplanmanejo = idplanmanejofertilizacion
   order by idfertilizante;
END//

DELIMITER ;






DROP FUNCTION IF EXISTS saveplanmanejofertilizacionfertilizante;

DELIMITER //
CREATE FUNCTION saveplanmanejofertilizacionfertilizante (
                          vidplanmanejo int, 
                          vidfertilizante int, 
                          vcantidad int,                           
                          vidresponsable int) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que almacena un plan de manejo fertilizacion fertilizante'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select idplanmanejo from planmanejofertilizacionfertilizante where idplanmanejo=idplanmanejo and idfertilizante=vidfertilizante)
		THEN
			insert into planmanejofertilizacionfertilizante(idplanmanejo,idfertilizante,cantidad,idresponsable)
			VALUES (vidplanmanejo,vidfertilizante,vcantidad,vidresponsable);
			set res = 1;
		END IF;

RETURN res;
	
END//

DELIMITER ;







DROP FUNCTION IF EXISTS updateplanmanejofertilizacionfertilizante;


DELIMITER //
CREATE FUNCTION updateplanmanejofertilizacionfertilizante (
                          vid int,
                          vidplanmanejo int, 
                          vidfertilizante int, 
                          vcantidad int,                           
                          vidresponsable int) RETURNS int(1)
    READS SQL DATA
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
	

END//

DELIMITER ;





DROP FUNCTION IF EXISTS deleteplanmanejofertilizacionfertilizante;

DELIMITER //
CREATE  FUNCTION deleteplanmanejofertilizacionfertilizante(vid INT) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que elimina un plan de manejo fertilizacion fertilizante'
BEGIN 
    DECLARE res INT DEFAULT 0;
    DELETE FROM planmanejofertilizacionfertilizante 
    WHERE id = vid;
    SET res = 1;
    RETURN res;

END//

DELIMITER ;

