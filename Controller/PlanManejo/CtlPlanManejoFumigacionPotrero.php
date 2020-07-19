<?php

/* IMPORTS */
require '../../Infraestructure/CORS.php';
require '../../DTO/PlanManejo/PlanManejoFumigacionPotreroDTO.php';
require '../../DTO/PlanManejo/PlanManejoFumigacionPotreroConfiguracionDTO.php';
require '../../DAO/PlanManejo/PlanManejoFumigacionPotreroDAO.php';
require '../../Helper/Action/Action.php';
require '../../Infraestructure/Security.php';


/* RECEPCION DE DATOS */
$action = getInfo('action');
$id = getInfo('id');
$idplanfumigacion = getInfo('idplanfumigacion');
$idpotrero = getInfo('idpotrero');
$fecha = getInfo('fecha');
$observaciones = getInfo('observaciones');
$ejecutado = getInfo('ejecutado');
$idresponsable = getInfo('idresponsable');



/* RECEPCION DE DATOS CONFIGURACION CARGA */
$idplanmanejo = getInfo('idplanmanejo');
$idrotacion = getInfo('idrotacion');

/* RECEPCION DEL TOKEN */
$token = getInfo('token');
$security = new Security();

if ($security->validarTokenUser($token)) {
    /* DEFINICION DE OBJETOS */
    $obj = new PlanManejoFumigacionPotreroDTO($id, $idplanfumigacion, $idpotrero, $fecha, $observaciones, $idresponsable, $ejecutado);
    $dao = new PlanManejoFumigacionPotreroDAO();


    /* DEFINICION DE OBJETOS CONFIGURACIONA */
    $conf = new PlanManejoFumigacionPotreroConfiguracionDTO($idplanmanejo, $idrotacion, $idresponsable);
    
    switch ($action) {

        case "potreroEjecutadoPorOperario":
            $dao->SavePotreroOperario($obj);
            break;

        case "asociarpotrerosrotaciones":
            $dao->SavePotrerosPorRotaciones($conf);
            break;
        
        case "listPotrerosByPlanesManejo":
            $dao->ListPotrerosByPlanesManejo($obj);
            break;

        default :
            /* CONTROL DE ACCIONES */
            ExecuteAction($action, $obj, $dao);
            break;
    }
}
    


