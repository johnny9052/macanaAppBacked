<?php

/* IMPORTS */
require '../../Infraestructure/CORS.php';
require '../../DTO/InsumoFumigacion/InsumoFumigacionDTO.php';
require '../../DAO/InsumoFumigacion/InsumoFumigacionDAO.php';
require '../../Helper/Action/Action.php';
require '../../Infraestructure/Security.php';


/* RECEPCION DE DATOS */
$action = getInfo('action');
$id = getInfo('id');
$nombre = getInfo('nombre');
$marca = getInfo('marca');
$idpresentacion = getInfo('idpresentacion');
$idresponsable = getInfo('idresponsable');


/* RECEPCION DEL TOKEN */
$token = getInfo('token');
$security = new Security();

if ($security->validarTokenUser($token)) {
    /* DEFINICION DE OBJETOS */
    $obj = new InsumoFumigacionDTO($id, $nombre, $marca, $idpresentacion, $idresponsable);
    $dao = new InsumoFumigacionDAO();

    /* CONTROL DE ACCIONES */
    ExecuteAction($action, $obj, $dao);
}


