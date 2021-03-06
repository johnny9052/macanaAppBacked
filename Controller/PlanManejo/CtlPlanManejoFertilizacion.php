<?php

/* IMPORTS */
require '../../Infraestructure/CORS.php';
require '../../DTO/PlanManejo/PlanManejoFertilizacionDTO.php';
require '../../DAO/PlanManejo/PlanManejoFertilizacionDAO.php';
require '../../Helper/Action/Action.php';
require '../../Infraestructure/Security.php';


/* RECEPCION DE DATOS */
$action = getInfo('action');
$id = getInfo('id');
$nombre = getInfo('nombre');
$fechainicio = getInfo('fechainicio');
$descripcion = getInfo('observaciones');
$idresponsable = getInfo('idresponsable');


/* RECEPCION DEL TOKEN */
$token = getInfo('token');
$security = new Security();

if ($security->validarTokenUser($token)) {
    /* DEFINICION DE OBJETOS */
    $obj = new PlanManejoFertilizacionDTO($id, $nombre, $fechainicio, $descripcion, $idresponsable);
    $dao = new PlanManejoFertilizacionDAO();

    /* CONTROL DE ACCIONES */
    ExecuteAction($action, $obj, $dao);
}


