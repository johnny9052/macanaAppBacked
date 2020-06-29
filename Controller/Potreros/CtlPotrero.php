<?php

/*IMPORTS*/
require '../../DTO/Potrero/PotreroDTO.php';
require '../../DAO/Potrero/PotreroDAO.php';
require '../../Helper/Action/Action.php';
require '../../Infraestructure/CORS.php';

/*RECEPCION DE DATOS*/
$action = getInfo('action');
$id = getInfo('id');
$numero = getInfo('numero');
$area = getInfo('area');
$observacion = getInfo('observacion');
$idrotacion = getInfo('idrotacion');
$estado = getInfo('estado');
$idresponsable = getInfo('idresponsable');
$ordenrotacion = getInfo('ordenrotacion');

/*DEFINICION DE OBJETOS*/
$obj = new PotreroDTO($id, $numero, $area, $observacion, $idrotacion, $idresponsable,$ordenrotacion);
$dao = new PotreroDAO();

/* CONTROL DE ACCIONES */
ExecuteAction($action, $obj, $dao);


