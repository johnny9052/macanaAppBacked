/*********************LIST******************************/

DELIMITER //
CREATE PROCEDURE listPermisosAsignados(vidrol int)
    COMMENT 'Procedimiento que lista los menus asignados a un rol'
BEGIN
   select idrol, idmenu
   from menu_rol
   where idrol = vidrol;
END//

DELIMITER ;
