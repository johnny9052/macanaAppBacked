<?php

/* IMPORTS */
require '../../Infraestructure/CORS.php';
require '../../DTO/Configuration/RolDTO.php';
require '../../DAO/Configuration/RolDAO.php';
require '../../Helper/Action/Action.php';
require '../../Infraestructure/Security.php';


/* RECEPCION DE DATOS */
$action = getInfo('action');
$id = getInfo('id');
$name = getInfo('name');
$description = getInfo('description');


/* RECEPCION DEL TOKEN */
$token = getInfo('token');
$security = new Security();

if ($security->validarTokenUser($token)) {
    /* DEFINICION DE OBJETOS */
    $obj = new RolDTO($id, $name, $description);
    $dao = new RolDAO();

    /* CONTROL DE ACCIONES */
    ExecuteAction($action, $obj, $dao);
}


