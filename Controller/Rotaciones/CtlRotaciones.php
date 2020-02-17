<?php

/*IMPORTS*/
require '../../DTO/Rotaciones/RotacionesDTO.php';
require '../../DAO/Rotaciones/RotacionesDAO.php';
include '../../Helper/Action/Action.php';
require '../../Infraestructure/CORS.php';

/*RECEPCION DE DATOS*/
$action = getInfo('action');
$id = getInfo('id');
$nombre = getInfo('nombre');
$cantvacas = getInfo('cantvacas');
$idresponsable = getInfo('idresponsable');

/*DEFINICION DE OBJETOS*/
$obj = new RotacionesDTO($id, $nombre, $cantvacas, $idresponsable);
$dao = new RotacionesDAO();

/* CONTROL DE ACCIONES */
ExecuteAction($action, $obj, $dao);


