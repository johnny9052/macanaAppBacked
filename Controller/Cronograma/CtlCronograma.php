<?php

/* IMPORTS */
require '../../Infraestructure/CORS.php';
require '../../DTO/Cronograma/CronogramaDTO.php';
require '../../DAO/Cronograma/CronogramaDAO.php';
require '../../Helper/Action/Action.php';
require '../../Infraestructure/Security.php';


/* RECEPCION DE DATOS */
$action          = getInfo('action');

$id              = getInfo('id');
$idactividad     = getInfo('idactividad');
$fechaProgramada = getInfo('fechaProgramada');
$fechaEjecutada  = getInfo('fechaEjecutada');
$idPotrero       = getInfo('idPotrero');
$idResponsable   = getInfo('idResponsable');
$ejecutado       = getInfo('ejecutado');

/* RECEPCION DEL TOKEN */
$token      = getInfo('token');
$security   = new Security();

/* DATOS NECESARIOS PARA EL REPORTE */

/* Caracter de separado para archivos CSV */
$caracter = getInfo('caracter');

/* END DATOS NECESARIOS PARA EL REPORTE */

$obj = new CronogramaDTO($id, $idactividad, $fechaProgramada, $fechaEjecutada, $idPotrero, $idResponsable, $ejecutado,$caracter);
$dao = new CronogramaDAO();

/* CONTROL DE ACCIONES */
ExecuteAction($action, $obj, $dao);



