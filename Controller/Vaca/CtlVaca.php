<?php

/*IMPORTS*/
require '../../DTO/Vaca/VacaDTO.php';
require '../../DAO/Vaca/VacaDAO.php';
include '../../Helper/Action/Action.php';
require '../../Infraestructure/CORS.php';

/*RECEPCION DE DATOS*/
$action = getInfo('action');
$id = getInfo('id');
$numero = getInfo('numero');
$nombre = getInfo('nombre');
$idRotacion = getInfo('idRotacion');
$sexo = getInfo('sexo');
$raza = getInfo('raza');
$tipoanimal = getInfo('tipoanimal');
$edad = getInfo('edad');
$idresponsable = getInfo('idresponsable');

/*DEFINICION DE OBJETOS*/
$obj = new VacaDTO($id, $numero, $nombre, $idRotacion, $sexo, $raza, $tipoanimal, $edad, $idresponsable);
$dao = new VacaDAO();

/* CONTROL DE ACCIONES */
ExecuteAction($action, $obj, $dao);

