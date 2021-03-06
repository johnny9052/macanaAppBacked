<?php

/*IMPORTS*/
require '../../Infraestructure/CORS.php';
require '../../DTO/Climatologico/ClimatologicoDTO.php';
require '../../DAO/Climatologico/ClimatologicoDAO.php';
require '../../Helper/Action/Action.php';


/*RECEPCION DE DATOS*/
$action = getInfo('action');
$id = getInfo('id');
$fecha = getInfo('fecha');
$nubosidad = getInfo('nubosidad');
$pluviometria = getInfo('pluviometria');
$observaciones = getInfo('observaciones');
$idresponsable = getInfo('idresponsable');

/* Caracter de separado para archivos CSV */
$caracter = getInfo('caracter');

/*DEFINICION DE OBJETOS*/
$obj = new ClimatologicoDTO($id, $fecha, $nubosidad, $pluviometria, $observaciones, $idresponsable,$caracter);
$dao = new ClimatologicoDAO();


/* CONTROL DE ACCIONES */
ExecuteAction($action, $obj, $dao);


