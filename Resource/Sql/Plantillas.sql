/*********************CREAR TABLA******************************/

create table estadoclimatologico(
    id int AUTO_INCREMENT,
    fecha varchar(20),
    nubosidad varchar(20),
    pluviometria int,
    observaciones varchar(2000),
    idresponsable int,
    primary key(id)
);



/*********************LIST******************************/

DELIMITER //
CREATE PROCEDURE listclimatologico(iduser int)
    COMMENT 'Procedimiento que lista los cambios climatologicos'
BEGIN
   select id, fecha,nubosidad, pluviometria, observaciones, 
          idresponsable
   from estadoclimatologico
   order by id;
END//

DELIMITER ;

/*********************SAVE******************************/

DELIMITER //
CREATE FUNCTION saveuser (vid int, 
                          vfirstname varchar(50), 
                          vsecondname varchar(50), 
                          vfirstlastname varchar(50), 
                          vsecondlastname varchar(50), 

                          vcedula varchar(50), 
                          vcorreo varchar(50), 
                          vcelular varchar(50),                 
                          vfoto varchar(50), 

                          vuser varchar(50), 
                          vpass varchar(50), 
                          vrol int, 
                          vdescription varchar(50)) RETURNS int(1)
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
	
END//

DELIMITER ;










/*********************UPDATE******************************/




DELIMITER //
CREATE FUNCTION updateuser (vid int, vfirstname varchar(50), 
                          vsecondname varchar(50), 
                          vfirstlastname varchar(50), 
                          vsecondlastname varchar(50), 
                          vcedula varchar(50), 
                          vcorreo varchar(50), 
                          vcelular varchar(50),                 
                          vfoto varchar(50), 
                          vuser varchar(50), 
                          vrol int, 
                          vdescription varchar(50)) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que modifica un usuario'
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select usuario from usuario where usuario=vuser and id<>vid)
		THEN

            UPDATE usuario
            SET  primer_nombre=vfirstname, segundo_nombre=vsecondname, 
                    primer_apellido=vfirstlastname, segundo_apellido=vsecondlastname, 
                    cedula = vcedula, correo = vcorreo, celular = vcelular, foto = vfoto,
                    usuario=vuser, rol=vrol, descripcion=vdescription
            WHERE id=vid;

	set res=1;
								
			
		END IF;

	RETURN res;
	

END//

DELIMITER ;







/*********************DELETE******************************/

DELIMITER //
CREATE  FUNCTION deleteuser(vid INT) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que elimina un usuario'
BEGIN 
    DECLARE res INT DEFAULT 0;
    DELETE FROM usuario WHERE id = vid;
    SET res = 1;
    RETURN res;

END//

DELIMITER ;







/***************************ARRAYS*******************************/


CREATE FUNCTION `updatepermission`(vid integer, 
vpermission varchar(2000)) RETURNS int(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Funcion que actualiza los permisos de un rol'
BEGIN 
    DECLARE res INT DEFAULT 0;
    /*Variable que contendra el permiso a almacenar*/
    DECLARE permiso varchar(50) DEFAULT '';    

    -- DECLARE lastId = SELECT LAST_INSERT_ID();

    /*Se borra todos los permisos existentes del usuario*/
    delete from menu_rol where idrol = vid;
    
    WHILE (LOCATE(',', vpermission) > 0) DO
        /*Se saca el primer campo separado por coma del varchar ELT (Posicion del arreglo, arreglo)*/
    	SET permiso = ELT(1, vpermission);
        /*Se elimina ese primer valor y se reemplaza en la cadena. En este caso toma desde la posicion 
         despues de la primera coma en adelante*/
    	SET vpermission = SUBSTRING(vpermission, LOCATE(',',vpermission) + 1);
        /*Se almacena en la tabla, siempre y cuando tenga un dato para almacenar*/
            IF permiso <> ',' THEN	
    		INSERT INTO menu_rol(idrol, idmenu) VALUES (vid, permiso);
            END IF;
    END WHILE;

    SET res = 1;

    RETURN res;	
END