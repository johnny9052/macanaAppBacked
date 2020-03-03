<?php

/*IMPORTS*/
require '../../DTO/Potrero/PotreroDTO.php';
require '../../DAO/Potrero/PotreroDAO.php';
include '../../Helper/Action/Action.php';
require '../../Infraestructure/CORS.php';

/*RECEPCION DE DATOS*/
$action = getInfo('action');
$id = getInfo('id');
$numero = getInfo('numero');
$area = getInfo('area');
$observacion = getInfo('observacion');
$idrotacion = getInfo('idrotacion');
$idresponsable = getInfo('idresponsable');

/*DEFINICION DE OBJETOS*/
$obj = new PotreroDTO($id, $numero, $area, $observacion, $idrotacion, $idresponsable);
$dao = new PotreroDAO();

/* CONTROL DE ACCIONES */
ExecuteAction($action, $obj, $dao);


