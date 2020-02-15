<?php

/*IMPORTS*/
require '../../DTO/Configuration/RolDTO.php';
require '../../DAO/Configuration/RolDAO.php';
include '../../Helper/Action/Action.php';
require '../../Infraestructure/CORS.php';

/*RECEPCION DE DATOS*/
$action = getInfo('action');
$id = getInfo('id');
$name = getInfo('name');
$description = getInfo('description');

/*DEFINICION DE OBJETOS*/
$obj = new RolDTO($id, $name, $description);
$dao = new RolDAO();

/* CONTROL DE ACCIONES */
ExecuteAction($action, $obj, $dao);


