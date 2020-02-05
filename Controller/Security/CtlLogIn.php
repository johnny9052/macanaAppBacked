<?php

/* IMPORTS */
require '../../DTO/Security/LogInDTO.php';
require '../../DAO/Security/LogInDAO.php';
require '../../Infraestructure/CORS.php';

/* RECEPCION DE DATOS */
$action = (isset($_REQUEST['action']) ? $_REQUEST['action'] : "");
$usuario = (isset($_POST['username']) ? $_POST['username'] : "");
$password = (isset($_POST['password']) ? $_POST['password'] : "");


/* DEFINICION DE OBJETOS */
$obj = new LogInDTO($usuario, $password);
$conex = new LogInDAO();


/* CONTROL DE ACCIONES */


switch ($action) {
    
    case "logIn":
        $conex->SignIn($obj);
        break;
}




