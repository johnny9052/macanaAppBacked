<?php

/*IMPORTS*/
require '../../DTO/General/ValidationDTO.php';
require '../../DAO/General/ValidationDAO.php';
include '../../Helper/Action/Validation.php';

/*RECEPCION DE DATOS*/
$action = (isset($_REQUEST['action']) ? $_REQUEST['action'] : "");
$id = (isset($_POST['keyValidation']) ? $_POST['keyValidation'] : "");

/*DEFINICION DE OBJETOS*/
$obj = new ValidationDTO($id);
$dao = new ValidationDAO();

/* CONTROL DE ACCIONES */
ExecuteActionValidation($action, $obj, $dao);


