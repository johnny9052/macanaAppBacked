<?php

/* IMPORTS */
require '../../Infraestructure/CORS.php';
require '../../DTO/Security/LogInDTO.php';
require '../../DAO/Security/LogInDAO.php';
require '../../Helper/Action/Action.php';
require '../../Infraestructure/Security.php';

/* RECEPCION DE DATOS */
$action = getInfo('action');
$usuario = getInfo('username');
$password = getInfo('password');


/*RECEPCION DEL TOKEN*/
$token = getInfo('token');
$security = new Security();

if ($security->validarTokenUser($token)) {
    /* DEFINICION DE OBJETOS */
    $obj = new LogInDTO($usuario, $password);
    $conex = new LogInDAO();

    /* CONTROL DE ACCIONES */
    switch ($action) {

        case "logIn":
            $conex->SignIn($obj);
            break;
    }
} 
