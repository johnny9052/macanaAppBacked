<?php

/* IMPORTS */
require '../../DAO/Configuration/PermissionDAO.php';
require '../../DTO/Configuration/PermissionDTO.php';
include '../../Helper/Action/Action.php';
require '../../Infraestructure/CORS.php';

/* RECEPCION DE DATOS */
$action = getInfo('action');
$id = getInfo('id');
$permission = getInfo('permission');

/* DEFINICION DE OBJETOS */
$obj = new PermissionDTO($id, $permission);
$dao = new PermissionDAO();

/* CONTROL DE ACCIONES */
switch ($action) {

    case "loadSimple":
        $dao->LoadSimpleAllMenu();
        break;

    case "load":
        $dao->LoadAllMenu();
        break;

    case "update":
        $dao->Update($obj);
        break;
    
    case "loadAsignados":
        $dao->LoadMenuAsignados($obj);
        break;

    case "loadPermission":
        $dao->LoadPermission($obj);

    case "loadPermissionSimple":
        $dao->LoadSimplePermission($obj);
}




