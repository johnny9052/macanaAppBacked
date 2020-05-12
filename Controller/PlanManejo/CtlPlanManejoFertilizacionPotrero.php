<?php

/* IMPORTS */
require '../../Infraestructure/CORS.php';
require '../../DTO/PlanManejo/PlanManejoFertilizacionPotreroDTO.php';
require '../../DAO/PlanManejo/PlanManejoFertilizacionPotreroDAO.php';
require '../../Helper/Action/Action.php';
require '../../Infraestructure/Security.php';


/* RECEPCION DE DATOS */
$action = getInfo('action');
$id = getInfo('id');
$idplanfertilizacion = getInfo('idplanfertilizacion');
$idpotrero = getInfo('idpotrero');
$fecha = getInfo('fecha');
$observaciones = getInfo('observaciones');
$ejecutado = getInfo('ejecutado');
$idresponsable = getInfo('idresponsable');


/* RECEPCION DEL TOKEN */
$token = getInfo('token');
$security = new Security();

if ($security->validarTokenUser($token)) {
    /* DEFINICION DE OBJETOS */
    $obj = new PlanManejoFertilizacionPotreroDTO($id, $idplanfertilizacion, $idpotrero, $fecha, $observaciones, $idresponsable, $ejecutado);
    $dao = new PlanManejoFertilizacionPotreroDAO();

    /* CONTROL DE ACCIONES */
    ExecuteAction($action, $obj, $dao);
}
    


