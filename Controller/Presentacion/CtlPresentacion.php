<?php

/*IMPORTS*/
require '../../Infraestructure/CORS.php';
require '../../DTO/Presentacion/PresentacionDTO.php';
require '../../DAO/Presentacion/PresentacionDAO.php';
require '../../Helper/Action/Action.php';


/*RECEPCION DE DATOS*/
$action = getInfo('action');
$id = getInfo('id');
$nombre = getInfo('nombre');
$observacion = getInfo('observacion');

/*DEFINICION DE OBJETOS*/
$obj = new PresentacionDTO($id, $nombre, $observacion);
$dao = new PresentacionDAO();

/* CONTROL DE ACCIONES */
ExecuteAction($action, $obj, $dao);


