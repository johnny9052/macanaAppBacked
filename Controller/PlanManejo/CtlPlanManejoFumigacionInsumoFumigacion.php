<?php

/* IMPORTS */
require '../../Infraestructure/CORS.php';
require '../../DTO/PlanManejo/PlanManejoFumigacionInsumoFumigacionDTO.php';
require '../../DAO/PlanManejo/PlanManejoFumigacionInsumoFumigacionDAO.php';
require '../../Helper/Action/Action.php';
require '../../Infraestructure/Security.php';


/* RECEPCION DE DATOS */
$action = getInfo('action');
$id = getInfo('id');
$idplanfumigacion = getInfo('idplanfumigacion');
$idinsumofumigacion = getInfo('idinsumofumigacion');
$cantidad = getInfo('cantidad');
$idresponsable = getInfo('idresponsable');


/* RECEPCION DEL TOKEN */
$token = getInfo('token');
$security = new Security();

if ($security->validarTokenUser($token)) {
    /* DEFINICION DE OBJETOS */
    $obj = new PlanManejoFumigacionInsumoFumigacionDTO($id, $idplanfumigacion, $idinsumofumigacion, $cantidad, $idresponsable);
    $dao = new PlanManejoFumigacionInsumoFumigacionDAO();

    /* CONTROL DE ACCIONES */
    ExecuteAction($action, $obj, $dao);
}
    


