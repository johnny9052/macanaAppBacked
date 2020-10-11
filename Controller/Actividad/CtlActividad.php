<?php

/* IMPORTS */
require '../../Infraestructure/CORS.php';
require '../../DTO/Actividad/ActividadDTO.php';
require '../../DAO/Actividad/ActividadDAO.php';
require '../../Helper/Action/Action.php';
require '../../Infraestructure/Security.php';




/* RECEPCION DE DATOS */
$action       = getInfo('action');

$id           = getInfo('id');
$nombre       = getInfo('nombre');
$descripcion  = getInfo('descripcion');
//echo $description;

/* RECEPCION DEL TOKEN */
$token      = getInfo('token');
$security   = new Security();

/* DEFINICION DE OBJETOS */
$obj = new ActividadDTO($id, $nombre, $descripcion);
$dao = new ActividadDAO();

/* CONTROL DE ACCIONES */
ExecuteAction($action, $obj, $dao);


