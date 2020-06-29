<?php

/* IMPORTS */
require '../../Infraestructure/CORS.php';
require '../../DTO/PlanManejo/PlanManejoFertilizacionFertilizanteDTO.php';
require '../../DAO/PlanManejo/PlanManejoFertilizacionFertilizanteDAO.php';
require '../../Helper/Action/Action.php';
require '../../Infraestructure/Security.php';


/* RECEPCION DE DATOS */
$action = getInfo('action');
$id = getInfo('id');
$idplanfertilizacion = getInfo('idplanfertilizacion');
$idfertilizante = getInfo('idfertilizante');
$cantidad = getInfo('cantidad');
$idresponsable = getInfo('idresponsable');


/* RECEPCION DEL TOKEN */
$token = getInfo('token');
$security = new Security();

if ($security->validarTokenUser($token)) {
    /* DEFINICION DE OBJETOS */
    $obj = new PlanManejoFertilizacionFertilizanteDTO($id, $idplanfertilizacion, $idfertilizante, $cantidad, $idresponsable);
    $dao = new PlanManejoFertilizacionFertilizanteDAO();

    /* CONTROL DE ACCIONES */
    ExecuteAction($action, $obj, $dao);
}
    


