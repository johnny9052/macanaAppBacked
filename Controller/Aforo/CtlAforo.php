<?php

/* IMPORTS */
require '../../DTO/Aforo/AforoDTO.php';
require '../../DAO/Aforo/AforoDAO.php';
include '../../Helper/Action/Action.php';
require '../../Infraestructure/CORS.php';

/* RECEPCION DE DATOS */
$action = getInfo('action');

$id = getInfo('id');
$fecha= getInfo('fecha');
$idpotrero= getInfo('idpotrero');
$pastoalto= getInfo('pastoalto');
$pastobajo= getInfo('pastobajo');
$pastomedio= getInfo('pastomedio');
$lancealto= getInfo('lancealto');
$lancemedio= getInfo('lancemedio');
$lancebajo= getInfo('lancebajo');
$cantlances= getInfo('cantlances');
$pesopastoalto= getInfo('pesopastoalto');
$pesopastobajo= getInfo('pesopastobajo');
$pesopastomedio= getInfo('pesopastomedio');
$cantpasto= getInfo('cantpasto');
$porcentajealtro= getInfo('porcentajealtro');
$porcentajemedio= getInfo('porcentajemedio');
$porcentajebajo= getInfo('porcentajebajo');
$totalmetrocuadrado= getInfo('totalmetrocuadrado');
$cantpastopotrero= getInfo('cantpastopotrero');
$tiempopotrero= getInfo('tiempopotrero');
$observaciones= getInfo('observaciones');
$idresponsable= getInfo('idresponsable');

/* DEFINICION DE OBJETOS */
$obj = new AforoDTO($id, $fecha, $idpotrero, $pastoalto, $pastobajo, $pastomedio, $lancealto, $lancemedio, $lancebajo, $cantlances, $pesopastoalto, $pesopastobajo, $pesopastomedio, $cantpasto, $porcentajealtro, $porcentajemedio, $porcentajebajo, $totalmetrocuadrado, $cantpastopotrero, $tiempopotrero, $observaciones, $idresponsable);
$dao = new AforoDAO();

/* CONTROL DE ACCIONES */
ExecuteAction($action, $obj, $dao);


