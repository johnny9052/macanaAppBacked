<?php

/* IMPORTS */
require '../../Infraestructure/CORS.php';
require '../../DTO/RazaVaca/RazaVacaDTO.php';
require '../../DAO/RazaVaca/RazaVacaDAO.php';
require '../../Helper/Action/Action.php';
require '../../Infraestructure/Security.php';


/* RECEPCION DE DATOS */
$action = getInfo('action');
$id = getInfo('id');
$nombre = getInfo('nombre');
$observaciones = getInfo('observaciones');


/* RECEPCION DEL TOKEN */
$token = getInfo('token');
$security = new Security();

if ($security->validarTokenUser($token)) {
    /* DEFINICION DE OBJETOS */
    $obj = new RazaVacaDTO($id, $nombre, $observaciones);
    $dao = new RazaVacaDAO();

    /* CONTROL DE ACCIONES */
    ExecuteAction($action, $obj, $dao);
}


