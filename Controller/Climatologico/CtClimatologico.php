<?php

/*IMPORTS*/
require '../../DTO/Climatologico/ClimatologicoDTO.php';
require '../../DAO/Climatologico/ClimatologicoDAO.php';
include '../../Helper/Action/Action.php';
require '../../Infraestructure/CORS.php';

/*RECEPCION DE DATOS*/
$action = getInfo('action');
$id = getInfo('id');
$fecha = getInfo('fecha');
$nubosidad = getInfo('nubosidad');
$pluviometria = getInfo('pluviometria');
$observaciones = getInfo('observaciones');
$idresponsable = getInfo('idresponsable');


/*DEFINICION DE OBJETOS*/
$obj = new ClimatologicoDTO($id, $fecha, $nubosidad, $pluviometria, $observaciones, $idresponsable);
$dao = new ClimatologicoDAO();

/* CONTROL DE ACCIONES */
ExecuteAction($action, $obj, $dao);


