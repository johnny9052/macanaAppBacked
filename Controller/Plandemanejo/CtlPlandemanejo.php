<?php

/*IMPORTS*/
require '../../Infraestructure/CORS.php';
require '../../DTO/Plandemanejo/PlandemanejoDTO.php';
require '../../DAO/Plandemanejo/PlandemanejoDAO.php';
require '../../Helper/Action/Action.php';


/*RECEPCION DE DATOS*/
$action = getInfo('action');
$id = getInfo('id');
$fecha = getInfo('fecha');
$nombre = getInfo('nombre');
$idResponsable = getInfo('idResponsable');
$observaciones = getInfo('observaciones');


/*DEFINICION DE OBJETOS*/
$obj = new PlandemanejoDTO($id, $fecha,$nombre,$idResponsable,$observaciones);
$dao = new PlandemanejoDAO();

/* CONTROL DE ACCIONES */
ExecuteAction($action, $obj, $dao);


