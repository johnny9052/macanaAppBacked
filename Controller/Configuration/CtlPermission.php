<?php

/* IMPORTS */
require '../../Infraestructure/CORS.php';
require '../../DAO/Configuration/PermissionDAO.php';
require '../../DTO/Configuration/PermissionDTO.php';
require '../../Helper/Action/Action.php';
require '../../Infraestructure/Security.php';

/* RECEPCION DE DATOS */
$action = getInfo('action');
$id = getInfo('id');
$permission = getInfo('permission');

/* RECEPCION DEL TOKEN */
$token = getInfo('token');
$security = new Security();


if ($security->validarTokenUser($token)) {

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
}



