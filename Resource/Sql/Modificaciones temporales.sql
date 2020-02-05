CREATE TABLE IF NOT EXISTS noticia (
  `id` int(11) NOT NULL AUTO_INCREMENT,    
  `titulo` varchar(50) DEFAULT NULL,
  `descripcion` varchar(2000) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `foto` varchar(2000) DEFAULT NULL,    
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  ;





DELIMITER //
CREATE FUNCTION savenoticia (cod INT,titl varchar(50),des varchar(2000), fech varchar(20), phot varchar(2000),vid varchar(500)) RETURNS int(1)
    COMMENT 'Funcion que almacena una noticia'
READS SQL DATA 
DETERMINISTIC 
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select titulo from noticia where titulo=titl)
		THEN
			insert into noticia(titulo,descripcion,fecha,foto,video) values(titl,des,fech,phot,vid);	
			set res = 1;							
			
		END IF;

	RETURN res;
	
END//

DELIMITER ;







DELIMITER //
CREATE FUNCTION updatenoticia(cod INT,titl varchar(50),des varchar(2000), fech varchar(20), phot varchar(2000),vid varchar(500)) RETURNS INT( 1 ) 
COMMENT  'Funcion que modifica una noticia'
READS SQL DATA 
DETERMINISTIC 
BEGIN 
    DECLARE res INT DEFAULT 0;
    
IF NOT EXISTS(select titulo from noticia where titulo=titl and id<>cod)
		THEN
			update noticia set titulo = titl,descripcion = des, fecha = fech,foto = phot, video = vid
                        where id = cod;		
			set res=1;
														
		END IF;

	RETURN res;
	

END//

DELIMITER ;







DELIMITER //
CREATE PROCEDURE searchnoticia(idnoticia int)
COMMENT 'Procedimiento que carga la informacion de una noticia'
BEGIN 	
	select id,titulo,descripcion, fecha,foto,video
	from noticia
	where id = idnoticia;
	
END//

DELIMITER ;




DELIMITER //
CREATE PROCEDURE listnoticia(iduser int)
COMMENT 'Procedimiento que lista los roles de un determinado usuario'
BEGIN
   select id,titulo as titulo_noticia,descripcion ,fecha,foto as ruta_foto,video as ruta_video
   from noticia
   order by fecha;
END//

DELIMITER ;






DELIMITER //
CREATE FUNCTION deletenoticia(vid INT) RETURNS INT( 1 ) 
COMMENT  'Funcion que elimina una noticia'
READS SQL DATA 
DETERMINISTIC 
BEGIN 
    DECLARE res INT DEFAULT 0;
    DELETE FROM noticia WHERE id = vid;
SET res = 1;
	RETURN res;
END//

DELIMITER ;