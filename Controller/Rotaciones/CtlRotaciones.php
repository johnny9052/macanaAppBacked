<?php

/*IMPORTS*/
require '../../DTO/Rotaciones/RotacionesDTO.php';
require '../../DAO/Rotaciones/RotacionesDAO.php';
require '../../Helper/Action/Action.php';
require '../../Infraestructure/CORS.php';

/*RECEPCION DE DATOS*/
$action = getInfo('action');
$id = getInfo('id');
$nombre = getInfo('nombre');
$cantvacas = getInfo('cantvacas');
$idresponsable = getInfo('idresponsable');

/* DATOS NECESARIOS PARA EL REPORTE */

/* Caracter de separado para archivos CSV */
$caracter = getInfo('caracter');

/* END DATOS NECESARIOS PARA EL REPORTE */


/*DEFINICION DE OBJETOS*/
$obj = new RotacionesDTO($id, $nombre, $cantvacas, $idresponsable, $caracter);
$dao = new RotacionesDAO();

/* CONTROL DE ACCIONES */
ExecuteAction($action, $obj, $dao);


