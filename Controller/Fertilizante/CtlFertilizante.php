<?php

/*IMPORTS*/
require '../../DTO/Fertilizante/FertilizanteDTO.php';
require '../../DAO/Fertilizante/FertilizanteDAO.php';
require '../../Helper/Action/Action.php';
require '../../Infraestructure/CORS.php';

/*RECEPCION DE DATOS*/
$action = getInfo('action');
$id = getInfo('id');
$nombre = getInfo('nombre');
$marca = getInfo('marca');
$idpresentacion = getInfo('idpresentacion');
$idresponsable = getInfo('idresponsable');

/*DEFINICION DE OBJETOS*/
$obj = new FertilizanteDTO($id, $nombre, $marca, $idpresentacion, $idresponsable);
$dao = new FertilizanteDAO();

/* CONTROL DE ACCIONES */
ExecuteAction($action, $obj, $dao);


