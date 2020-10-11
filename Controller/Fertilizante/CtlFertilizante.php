<?php

/* IMPORTS */
require '../../Infraestructure/CORS.php';
require '../../DTO/Fertilizante/FertilizanteDTO.php';
require '../../DAO/Fertilizante/FertilizanteDAO.php';
require '../../Helper/Action/Action.php';
require '../../Infraestructure/Security.php';


/* RECEPCION DE DATOS */
$action         = getInfo('action');
$id             = getInfo('id');
$nombre         = getInfo('nombre');
$marca          = getInfo('marca');
$idpresentacion = getInfo('idpresentacion');
$idresponsable  = getInfo('idresponsable');


/* RECEPCION DEL TOKEN */
$token = getInfo('token');
$security = new Security();

/* DATOS NECESARIOS PARA EL REPORTE */

/* Caracter de separado para archivos CSV */
$caracter = getInfo('caracter');

/* END DATOS NECESARIOS PARA EL REPORTE */


if ($security->validarTokenUser($token)) {
    /* DEFINICION DE OBJETOS */
    $obj = new FertilizanteDTO($id, $nombre, $marca,$idpresentacion,$idresponsable, $caracter);
    $dao = new FertilizanteDAO();

    /* CONTROL DE ACCIONES */
    ExecuteAction($action, $obj, $dao);
}


