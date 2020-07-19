<?php

/* IMPORTS */
require '../../Infraestructure/CORS.php';
require '../../DTO/PlanManejo/PlanManejoFumigacionDTO.php';
require '../../DAO/PlanManejo/PlanManejoFumigacionDAO.php';
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
    $obj = new PlanManejoFumigacionDTO($id, $nombre, $fechainicio, $descripcion, $idresponsable);
    $dao = new PlanManejoFumigacionDAO();

    /* CONTROL DE ACCIONES */
    ExecuteAction($action, $obj, $dao);
}


