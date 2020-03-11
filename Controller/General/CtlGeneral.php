<?php

/*IMPORTS*/
require '../../DTO/General/GeneralDTO.php';
require '../../DAO/General/GeneralDAO.php';
require '../../Helper/Action/Load.php';
require '../../Helper/Action/Action.php';
require '../../Infraestructure/CORS.php';

/*RECEPCION DE DATOS*/
$action = getInfo('action');
$id = getInfo('id');

/*DEFINICION DE OBJETOS*/
$obj = new GeneralDTO($id);
$dao = new GeneralDAO();

/* CONTROL DE ACCIONES */
ExecuteActionLoad($action, $obj, $dao);


